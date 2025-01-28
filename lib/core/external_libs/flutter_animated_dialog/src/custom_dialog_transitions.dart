import 'dart:math' as math;

import 'package:flutter/material.dart';

class Rotation3DTransition extends AnimatedWidget {
  const Rotation3DTransition({
    super.key,
    required Animation<double> turns,
    this.alignment = Alignment.center,
    this.child,
  }) : super(listenable: turns);

  Animation<double> get turns => listenable as Animation<double>;

  final Alignment? alignment;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    final Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, 0.0006)
      ..rotateY(turnsValue);
    return Transform(
      transform: transform,
      alignment: FractionalOffset.center,
      child: child,
    );
  }
}

class CustomRotationTransition extends AnimatedWidget {
  const CustomRotationTransition({
    super.key,
    required Animation<double> turns,
    this.alignment = Alignment.center,
    this.child,
  }) : super(listenable: turns);

  Animation<double> get turns => listenable as Animation<double>;

  final Alignment? alignment;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    final Matrix4 transform = Matrix4.rotationZ(turnsValue * math.pi);
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}
