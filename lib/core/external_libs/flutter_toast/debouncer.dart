// debouncer.dart
import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  bool _isReady = true;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (!_isReady) return;

    _isReady = false;
    action();

    _timer = Timer(Duration(milliseconds: milliseconds), () {
      _isReady = true;
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
