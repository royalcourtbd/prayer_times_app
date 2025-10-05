import 'package:flutter/material.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/external_libs/dashed_progress_bar/dashed_progress_bar.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/presentation/home/presenter/home_presenter.dart';

class RamadanTrackerSection extends StatelessWidget {
  const RamadanTrackerSection({
    super.key,
    required this.theme,
    required this.homePresenter,
  });

  final ThemeData theme;
  final HomePresenter homePresenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding15,
      decoration: BoxDecoration(
        color: context.color.primaryColor.withOpacityInt(0.05),
        borderRadius: radius18,
      ),
      child: Column(
        children: [
          _buildProgressBar(context),
          Divider(
            color: context.color.primaryColor.withOpacityInt(0.1),
          ),
          _buildTimingsRow(context)
        ],
      ),
    );
  }

  Row _buildTimingsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTimeColumn(
          context: context,
          title: 'Suhoor',
          time: homePresenter.getSehriTime(),
        ),
        _buildTimeColumn(
          context: context,
          title: 'Iftar',
          time: homePresenter.getIftarTime(),
        ),
      ],
    );
  }

  Expanded _buildTimeColumn({
    required BuildContext context,
    required String title,
    required String time,
  }) {
    return Expanded(
      child: Container(
        padding: padding10,
        decoration: BoxDecoration(),
        child: Column(
          children: [
            Text(
              title,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: context.color.subTitleColor,
                fontSize: thirteenPx,
              ),
            ),
            Text(
              time,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: fifteenPx,
              ),
            ),
          ],
        ),
      ),
    );
  }

  DashedCircularProgressBar _buildProgressBar(BuildContext context) {
    return DashedCircularProgressBar.aspectRatio(
      aspectRatio: 2, // width ÷ height
      progress: homePresenter.currentUiState.fastingProgress,
      startAngle: 270,
      sweepAngle: 180,
      circleCenterAlignment: Alignment.bottomCenter,
      foregroundColor: context.color.primaryColor,
      backgroundColor: context.color.primaryColor.withOpacityInt(0.1),
      foregroundStrokeWidth: 2,
      backgroundStrokeWidth: 2,
      backgroundGapSize: 1,
      seekColor: context.color.primaryColor,
      seekSize: 22,
      animation: true,
      foregroundGapSize: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Remaining ${homePresenter.currentUiState.fastingState.displayName}',
            style: theme.textTheme.bodyMedium!.copyWith(
              color: context.color.subTitleColor,
              fontSize: thirteenPx,
            ),
          ),
          Text(
            homePresenter.getFormattedFastingRemainingTime(),
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: twentySevenPx,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
