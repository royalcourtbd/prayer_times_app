import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';
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
        innerPadding: 5,
        foregroundColor: _getForegroundProgressBarColor(context),
        backgroundColor: _getBackgroundColor(context),
        percentage: homePresenter.currentUiState.remainingTimeProgress,
        strokeCap: StrokeCap.round,
        handleWidget: Container(
          decoration: BoxDecoration(
            color: _getForegroundProgressBarColor(context),
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Remaining',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: tenPx,
                color: context.color.subTitleColor,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
            Text(
              homePresenter
                  .getRemainingTimeText(), // দ্বিতীয় লাইনে বাকি টেক্সট
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: tenPx,
                // height: 1,
                color: context.color.subTitleColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            gapH5,
            Text(
              homePresenter.getFormattedRemainingTime(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: nineteenPx,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getForegroundProgressBarColor(BuildContext context) {
    if (homePresenter.currentUiState.activeWaqtType == WaqtType.sunrise) {
      return context.color.errorColor;
    }
    return context.color.primaryColor900;
  }

  Color _getBackgroundColor(BuildContext context) {
    if (homePresenter.currentUiState.activeWaqtType == WaqtType.sunrise) {
      return context.color.errorColor100;
    }
    return context.color.primaryColor100;
  }
}
