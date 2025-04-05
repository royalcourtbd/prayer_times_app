import 'package:flutter/material.dart';
import 'package:prayer_times/presentation/main/presenter/main_presenter.dart';

class DoubleTapBackToExitApp extends StatelessWidget {
  const DoubleTapBackToExitApp({
    required this.child,
    required this.mainPresenter,
    super.key,
  });

  final Widget child;
  final MainPresenter mainPresenter;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        await mainPresenter.handleBackPress();
      },
      child: child,
    );
  }
}
