import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/home_presenter.dart';

class RemainingPrayerSection extends StatelessWidget {
  const RemainingPrayerSection({
    super.key,
    required this.theme,
    required this.onBuildContainer,
    required this.homePresenter,
  });

  final ThemeData theme;
  final HomePresenter homePresenter;
  final Widget Function({
    required BuildContext context,
    required ThemeData theme,
    required Widget child,
  }) onBuildContainer;

  @override
  Widget build(BuildContext context) {
    return onBuildContainer(
      context: context,
      theme: theme,
      child: ArcProgressBar(
        innerPadding: 4,
        foregroundColor: context.color.primaryColor,
        backgroundColor: context.color.primaryColor100,
        percentage: homePresenter.currentUiState.remainingTimeProgress,
        strokeCap: StrokeCap.round,
        handleWidget: Container(
          decoration: BoxDecoration(
            color: context.color.primaryColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: context.color.whiteColor,
              width: 2,
            ),
          ),
        ),
        arcThickness: 6,
        handleSize: 16,
        bottomCenterWidget: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Remaining ${homePresenter.getRemainingTimeText()}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: tenPx,
                color: context.color.subTitleColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              homePresenter.getFormattedRemainingTime(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: nineteenPx,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
