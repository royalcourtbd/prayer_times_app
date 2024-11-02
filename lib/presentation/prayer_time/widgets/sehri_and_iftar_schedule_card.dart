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
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: FastingTimeItem(
                  icon: SvgPath.icFazrFill,
                  title: 'Sehri',
                  time: '4:27',
                ),
              ),
              Expanded(
                child: FastingTimeItem(
                  icon: SvgPath.icMaghribFill,
                  title: 'Iftar',
                  time: '18:30',
                ),
              ),
            ],
          ),
          gapH16,
          CountdownProgressBar(
            theme: theme,
            progress: 50,
            remainingTime: '4:27:23',
          ),
        ],
      ),
    );
  }
}
