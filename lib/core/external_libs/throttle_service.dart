import 'dart:async';

typedef EasyThrottleCallback = void Function();

class _ThrottleOperation {
  _ThrottleOperation(
    this.callback,
    this.timer, {
    this.onAfter,
  });

  EasyThrottleCallback callback;
  EasyThrottleCallback? onAfter;
  Timer timer;
}

class Throttle {
  Throttle._();

  static final Map<String, _ThrottleOperation> _operations = {};

  static bool throttle(
    String tag,
    Duration duration,
    EasyThrottleCallback onExecute, {
    EasyThrottleCallback? onAfter,
    EasyThrottleCallback? onThrottled,
  }) {
    final bool throttled = _operations.containsKey(tag);
    if (throttled) {
      onThrottled?.call();
      return true;
    }

    _operations[tag] = _ThrottleOperation(
      onExecute,
      Timer(duration, () {
        _operations[tag]?.timer.cancel();
        final _ThrottleOperation? removed = _operations.remove(tag);

        removed?.onAfter?.call();
      }),
      onAfter: onAfter,
    );

    onExecute();

    return false;
  }

  static void cancel(String tag) {
    _operations[tag]?.timer.cancel();
    _operations.remove(tag);
  }

  static void cancelAll() {
    for (final _ThrottleOperation operation in _operations.values) {
      operation.timer.cancel();
    }
    _operations.clear();
  }

  static int count() => _operations.length;
}

typedef EasyDebounceCallback = void Function();

class _EasyDebounceOperation {
  _EasyDebounceOperation(this.callback, this.timer);

  EasyDebounceCallback callback;
  Timer timer;
}

class Debounce {
  Debounce._();

  static final Map<String, _EasyDebounceOperation> _operations = {};

  static void debounce(
    String tag,
    Duration duration,
    EasyDebounceCallback onExecute,
  ) {
    if (duration == Duration.zero) {
      _operations[tag]?.timer.cancel();
      _operations.remove(tag);
      onExecute();
    } else {
      _operations[tag]?.timer.cancel();

      _operations[tag] = _EasyDebounceOperation(
        onExecute,
        Timer(duration, () {
          _operations[tag]?.timer.cancel();
          _operations.remove(tag);

          onExecute();
        }),
      );
    }
  }

  static void fire(String tag) {
    _operations[tag]?.callback();
  }

  static void cancel(String tag) {
    _operations[tag]?.timer.cancel();
    _operations.remove(tag);
  }

  static void cancelAll() {
    for (final operation in _operations.values) {
      operation.timer.cancel();
    }
    _operations.clear();
  }

  static int count() {
    return _operations.length;
  }
}
