// custom_toast.dart
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CustomToast extends StatefulWidget {
  final String message;
  final Duration duration;

  final double xOffset;
  final double yOffset;

  const CustomToast({
    super.key,
    required this.message,
    this.duration = const Duration(seconds: 2),
    this.xOffset = 0.0,
    this.yOffset = 50.0,
  });

  @override
  CustomToastState createState() => CustomToastState();
}

class CustomToastState extends State<CustomToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _animationController.reverse().then((value) {
          if (mounted) {
            Overlay.of(context).setState(() {});
          }
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    _offsetAnimation = Tween<Offset>(
      begin: Offset(
          widget.xOffset / screenWidth, 1.0 + (widget.yOffset / screenHeight)),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Positioned(
      left: widget.xOffset,
      bottom: widget.yOffset,
      right: widget.xOffset,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: twentyPx),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: twentyPx, vertical: tenPx),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(twentyFourPx),
                ),
                child: Text(
                  widget.message,
                  style: TextStyle(
                    color: context.color.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
