import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/countdown_progress_bar.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/fasting_time_item.dart';

class SehriIftarScheduleCard extends StatelessWidget {
  const SehriIftarScheduleCard({
    super.key,
    required this.theme,
    required this.sehriTime,
    required this.iftarTime,
    required this.remainingTime,
    required this.progress,
    required this.title,
  });

  final ThemeData theme;
  final String sehriTime;
  final String iftarTime;
  final String remainingTime;
  final double progress;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FastingTimeItem(
                  icon: SvgPath.icFazrFill,
                  title: 'Sehri',
                  time: sehriTime,
                ),
              ),
              Expanded(
                child: FastingTimeItem(
                  icon: SvgPath.icMaghribFill,
                  title: 'Iftar',
                  time: iftarTime,
                ),
              ),
            ],
          ),
          gapH16,
          CountdownProgressBar(
            theme: theme,
            progress: progress,
            remainingTime: remainingTime,
            title: title,
          ),
        ],
      ),
    );
  }
}
