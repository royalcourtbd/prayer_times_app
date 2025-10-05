import 'dart:collection';
import 'package:salat_times/core/external_libs/lru_map/generating_iterable.dart';

abstract class LruMap<K, V> implements Map<K, V> {
  factory LruMap({int? maximumSize}) = LinkedLruHashMap<K, V>;

  int get maximumSize;

  set maximumSize(int size);
}

class _LinkedEntry<K, V> {
  _LinkedEntry(this.key, this.value);

  K key;
  V value;

  _LinkedEntry<K, V>? next;
  _LinkedEntry<K, V>? previous;
}

class LinkedLruHashMap<K, V> implements LruMap<K, V> {
  factory LinkedLruHashMap({int? maximumSize}) => LinkedLruHashMap._fromMap(
        HashMap<K, _LinkedEntry<K, V>>(),
        maximumSize: maximumSize,
      );

  LinkedLruHashMap._fromMap(this._entries, {int? maximumSize})
      : _maximumSize = maximumSize ?? _defaultMaximumSize;

  static const _defaultMaximumSize = 100;

  final Map<K, _LinkedEntry<K, V>> _entries;

  int _maximumSize;

  _LinkedEntry<K, V>? _head;
  _LinkedEntry<K, V>? _tail;

  @override
  void addAll(Map<K, V> other) => other.forEach((k, v) => this[k] = v);

  @override
  void addEntries(Iterable<MapEntry<K, V>> entries) {
    for (final entry in entries) {
      this[entry.key] = entry.value;
    }
  }

  @override
  LinkedLruHashMap<K2, V2> cast<K2, V2>() {
    throw UnimplementedError('cast');
  }

  @override
  void clear() {
    _entries.clear();
    _head = _tail = null;
  }

  @override
  bool containsKey(Object? key) => _entries.containsKey(key);

  @override
  bool containsValue(Object? value) => values.contains(value);

  @override
  Iterable<MapEntry<K, V>> get entries =>
      _entries.values.map((entry) => MapEntry<K, V>(entry.key, entry.value));

  @override
  void forEach(void Function(K key, V value) action) {
    _LinkedEntry<K, V>? head = _head;
    while (head != null) {
      action(head.key, head.value);
      head = head.next;
    }
  }

  @override
  int get length => _entries.length;

  @override
  bool get isEmpty => _entries.isEmpty;

  @override
  bool get isNotEmpty => _entries.isNotEmpty;

  Iterable<_LinkedEntry<K, V>> _iterable() {
    if (_head == null) {
      return const Iterable.empty();
    }
    return GeneratingIterable<_LinkedEntry<K, V>>(() => _head!, (n) => n.next);
  }

  @override
  Iterable<K> get keys => _iterable().map((e) => e.key);

  @override
  Iterable<V> get values => _iterable().map((e) => e.value);

  @override
  Map<K2, V2> map<K2, V2>(Object Function(K key, V value) transform) {
    throw UnimplementedError('map');
  }

  @override
  int get maximumSize => _maximumSize;

  @override
  set maximumSize(int maximumSize) {
    ArgumentError.checkNotNull(maximumSize, 'maximumSize');
    while (length > maximumSize) {
      _removeLru();
    }
    _maximumSize = maximumSize;
  }

  @override
  V putIfAbsent(K key, V Function() ifAbsent) {
    final entry =
        _entries.putIfAbsent(key, () => _createEntry(key, ifAbsent()));
    if (length > maximumSize) {
      _removeLru();
    }
    _promoteEntry(entry);
    return entry.value;
  }

  @override
  V? operator [](Object? key) {
    final entry = _entries[key];
    if (entry != null) {
      _promoteEntry(entry);
      return entry.value;
    } else {
      return null;
    }
  }

  @override
  void operator []=(K key, V value) {
    _insertMru(_createEntry(key, value));

    if (length > maximumSize) {
      assert(length == maximumSize + 1);
      _removeLru();
    }
  }

  @override
  V? remove(Object? key) {
    final entry = _entries.remove(key);
    if (entry == null) {
      return null;
    }
    if (entry == _head && entry == _tail) {
      _head = _tail = null;
    } else if (entry == _head) {
      _head = _head!.next;
      _head?.previous = null;
    } else if (entry == _tail) {
      _tail = _tail!.previous;
      _tail?.next = null;
    } else {
      entry.previous!.next = entry.next;
      entry.next!.previous = entry.previous;
    }
    return entry.value;
  }

  @override
  void removeWhere(bool Function(K key, V value) test) {
    final keysToRemove = <K>[];
    _entries.forEach((key, entry) {
      if (test(key, entry.value)) keysToRemove.add(key);
    });
    keysToRemove.forEach(remove);
  }

  @override
  String toString() {
    if (_isToStringVisiting(this)) {
      return '{...}';
    }

    final result = StringBuffer();
    try {
      _toStringVisiting.add(this);
      result.write('{');
      bool first = true;
      forEach((k, v) {
        if (!first) {
          result.write(', ');
        }
        first = false;
        result.write('$k: $v');
      });
      result.write('}');
    } finally {
      assert(identical(_toStringVisiting.last, this));
      _toStringVisiting.removeLast();
    }

    return result.toString();
  }

  @override
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    V newValue;
    if (containsKey(key)) {
      newValue = update(this[key] as V);
    } else {
      if (ifAbsent == null) {
        throw ArgumentError.value(key, 'key', 'Key not in map');
      }
      newValue = ifAbsent();
    }

    _insertMru(_createEntry(key, newValue));

    if (length > maximumSize) {
      assert(length == maximumSize + 1);
      _removeLru();
    }
    return newValue;
  }

  @override
  void updateAll(V Function(K key, V value) update) {
    _entries.forEach((key, entry) {
      final newValue = _createEntry(key, update(key, entry.value));
      _entries[key] = newValue;
    });
  }

  void _promoteEntry(_LinkedEntry<K, V> entry) {
    if (entry == _head) {
      return;
    }

    if (entry.previous != null) {
      entry.previous!.next = entry.next;

      if (_tail == entry) {
        _tail = entry.previous;
      }
    }

    if (entry.next != null) {
      entry.next!.previous = entry.previous;
    }

    if (_head != null) {
      _head!.previous = entry;
    }
    entry
      ..previous = null
      ..next = _head;
    _head = entry;

    if (_tail == null) {
      assert(length == 1);
      _tail = _head;
    }
  }

  _LinkedEntry<K, V> _createEntry(K key, V value) {
    return _LinkedEntry<K, V>(key, value);
  }

  void _insertMru(_LinkedEntry<K, V> entry) {
    final value = entry.value;
    _promoteEntry(_entries.putIfAbsent(entry.key, () => entry)..value = value);
  }

  void _removeLru() {
    _entries.remove(_tail!.key);

    _tail = _tail!.previous;
    _tail?.next = null;

    if (_tail == null) {
      _head = null;
    }
  }
}

final List<Object> _toStringVisiting = [];

bool _isToStringVisiting(Object o) =>
    _toStringVisiting.any((e) => identical(o, e));
