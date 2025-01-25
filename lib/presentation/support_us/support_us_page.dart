import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';

class SupportUsPage extends StatelessWidget {
  const SupportUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Support Us',
        theme: theme,
      ),
    );
  }
}
