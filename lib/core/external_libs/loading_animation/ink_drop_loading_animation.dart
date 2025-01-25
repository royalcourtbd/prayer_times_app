import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/external_libs/loading_animation/draw_arc.dart';

class InkDropLoading extends StatefulWidget {
  const InkDropLoading({
    super.key,
    required this.size,
    required this.color,
    this.ringColor,
  });
  final double size;
  final Color color;
  final Color? ringColor;

  @override
  InkDropState createState() => InkDropState();
}

class InkDropState extends State<InkDropLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final Color color = widget.color;
    final Color ringColor = widget.ringColor ?? Theme.of(context).dividerColor;
    final double strokeWidth = size / 5;
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Arc.draw(
              strokeWidth: strokeWidth,
              size: size,
              color: ringColor,
              startAngle: math.pi / 2,
              endAngle: 2 * math.pi,
            ),
            Visibility(
              visible: _animationController.value <= 0.9,
              child: Transform.translate(
                offset: Tween<Offset>(
                  begin: Offset(0, -size),
                  end: Offset.zero,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.05,
                          0.4,
                          curve: Curves.easeInCubic,
                        ),
                      ),
                    )
                    .value,
                child: Arc.draw(
                  strokeWidth: strokeWidth,
                  size: size,
                  color: color,
                  startAngle: -3 * math.pi / 2,
                  // endAngle: math.pi / (size * size),
                  endAngle: Tween<double>(
                    begin: math.pi / (size * size),
                    end: math.pi / 1.13,
                  )
                      .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(
                            0.38,
                            0.9,
                          ),
                        ),
                      )
                      .value,
                ),
              ),
            ),
            Visibility(
              visible: _animationController.value <= 0.9,
              child: Transform.translate(
                offset: Tween<Offset>(
                  begin: Offset(0, -size),
                  end: Offset.zero,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.05,
                          0.4,
                          curve: Curves.easeInCubic,
                        ),
                      ),
                    )
                    .value,
                child: Arc.draw(
                  strokeWidth: strokeWidth,
                  size: size,
                  color: color,
                  startAngle: -3 * math.pi / 2,
                  endAngle: Tween<double>(
                    begin: math.pi / (size * size),
                    end: -math.pi / 1.13,
                  )
                      .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(
                            0.38,
                            0.9,
                          ),
                        ),
                      )
                      .value,
                ),
              ),
            ),

            /// Right
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: -math.pi / 4,
                endAngle: Tween<double>(
                  begin: -math.pi / 7.4,
                  end: -math.pi / 4,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.9,
                          0.96,
                        ),
                      ),
                    )
                    .value,
              ),
            ),
            // Left
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: -3 * math.pi / 4,
                // endAngle: math.pi / 4
                // endAngle: math.pi / 7.4
                endAngle: Tween<double>(
                  begin: math.pi / 7.4,
                  end: math.pi / 4,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.9,
                          0.96,
                        ),
                      ),
                    )
                    .value,
              ),
            ),

            /// Right
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: -math.pi / 3.5,
                // endAngle: math.pi / 28,
                endAngle: Tween<double>(
                  begin: math.pi / 1.273,
                  end: math.pi / 28,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.9,
                          1,
                        ),
                      ),
                    )
                    .value,
              ),
            ),

            /// Left
            Visibility(
              visible: _animationController.value >= 0.9,
              child: Arc.draw(
                strokeWidth: strokeWidth,
                size: size,
                color: color,
                startAngle: math.pi / 0.778,
                // endAngle: -math.pi / 1.273
                // endAngle: -math.pi / 27

                endAngle: Tween<double>(
                  begin: -math.pi / 1.273,
                  end: -math.pi / 27,
                )
                    .animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: const Interval(
                          0.9,
                          1,
                        ),
                      ),
                    )
                    .value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
