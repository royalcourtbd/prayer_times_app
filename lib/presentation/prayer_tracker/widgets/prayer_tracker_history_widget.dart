import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/data/models/prayer_tracker_model.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_tracker_entity.dart';
import 'package:qibla_and_prayer_times/presentation/home/models/waqt.dart';

class PrayerTrackerHistoryWidget extends StatelessWidget {
  const PrayerTrackerHistoryWidget({
    super.key,
    required this.theme,
    required this.trackerHistory,
  });

  final ThemeData theme;
  final Map<DateTime, List<PrayerTrackerModel>> trackerHistory;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> dates = trackerHistory.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // সর্বশেষ তারিখ থেকে শুরু

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHistoryHeader(context),
        gapH10,
        ...dates.map((date) => _buildHistoryRow(context, date)),
      ],
    );
  }

  Widget _buildHistoryHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: tenPx),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Date',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: elevenPx,
                color: context.color.titleColor,
              ),
            ),
          ),
          ..._buildPrayerColumns()
        ],
      ),
    );
  }

  List<Widget> _buildPrayerColumns() {
    final List<WaqtType> prayerTypes =
        WaqtType.values.where((type) => type.shouldShowInTracker).toList();

    return List.generate(
      prayerTypes.length,
      (index) => Expanded(
        child: Center(
          child: Text(
            _getPrayerColumnName(prayerTypes[index]),
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: elevenPx,
            ),
          ),
        ),
      ),
    );
  }

  String _getPrayerColumnName(WaqtType type) {
    switch (type) {
      case WaqtType.fajr:
        return 'Fajr';
      case WaqtType.dhuhr:
        return 'Dhuhr';
      case WaqtType.asr:
        return 'Asr';
      case WaqtType.maghrib:
        return 'Maghrib';
      case WaqtType.isha:
        return 'Isha';
      default:
        return '';
    }
  }

  Widget _buildHistoryRow(BuildContext context, DateTime date) {
    final List<PrayerTrackerModel> trackers = trackerHistory[date] ?? [];
    final List<WaqtType> prayerTypes =
        WaqtType.values.where((type) => type.shouldShowInTracker).toList();

    return Container(
      padding: EdgeInsets.symmetric(vertical: twelvePx),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getWeekdayName(date),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: twelvePx,
                    color: context.color.subTitleColor,
                  ),
                ),
                Text(
                  getFormattedDate(date),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: fourteenPx,
                  ),
                ),
              ],
            ),
          ),
          ...prayerTypes.map((type) => Expanded(
                child: Center(
                  child: _buildStatusIcon(
                    context,
                    trackers.firstWhere(
                      (tracker) => tracker.type == type,
                      orElse: () => PrayerTrackerModel(
                        id: type.toString(),
                        type: type,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  String _getWeekdayName(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  Widget _buildStatusIcon(BuildContext context, PrayerTrackerModel tracker) {
    return tracker.status == PrayerStatus.completed
        ? SvgImage(
            SvgPath.icCheckMarkBlue,
            width: twentyFivePx,
            height: twentyFivePx,
          )
        : SvgImage(
            SvgPath.icUncheckMark,
            width: twentyFivePx,
            height: twentyFivePx,
          );
  }
}
