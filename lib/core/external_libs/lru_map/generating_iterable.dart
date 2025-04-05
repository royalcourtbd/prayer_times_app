import 'dart:collection';

class GeneratingIterable<T> extends IterableBase<T> {
  GeneratingIterable(this._initial, this._next);

  final T Function() _initial;
  final T? Function(T value) _next;

  @override
  Iterator<T> get iterator => _GeneratingIterator(_initial(), _next);
}

class _GeneratingIterator<T> implements Iterator<T> {
  _GeneratingIterator(this.object, this.next);

  final T? Function(T value) next;
  T? object;
  bool started = false;

  @override
  T get current {
    final cur = started ? object : null;
    return cur!;
  }

  @override
  bool moveNext() {
    final obj = object;
    if (obj == null) return false;
    if (started) {
      object = next(obj);
    } else {
      started = true;
    }
    return object != null;
  }
}
