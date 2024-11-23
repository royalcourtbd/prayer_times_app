import 'package:flutter/material.dart';

class ZoomIn extends StatefulWidget {
  ZoomIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.from = 1.0,
  }) {
    if (manualTrigger == true && controller == null) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  final Widget child;
  final Duration duration;
  final Duration delay;
  final void Function(AnimationController)? controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  @override
  ZoomInState createState() => ZoomInState();
}

class ZoomInState extends State<ZoomIn> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  bool disposed = false;
  late Animation<double> fade;
  late Animation<double> opacity;

  @override
  void dispose() {
    disposed = true;
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    fade = Tween(begin: 0.001, end: widget.from)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: controller!));

    opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller!, curve: const Interval(0, 0.65)),
    );

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller?.forward();
        }
      });
    }

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller?.forward();
    }

    if (!widget.animate) {
      controller?.animateBack(0);
    }

    return AnimatedBuilder(
      animation: fade,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scale: fade.value,
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
