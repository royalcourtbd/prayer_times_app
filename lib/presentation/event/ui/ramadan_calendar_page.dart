import 'package:flutter/material.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/di/service_locator.dart';
import 'package:prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:prayer_times/core/static/svg_path.dart';
import 'package:prayer_times/core/static/ui_const.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/domain/entities/ramadan_day_entity.dart';
import 'package:prayer_times/presentation/common/custom_app_bar.dart';

import 'package:prayer_times/presentation/event/pesenter/ramadan_calendar_presenter.dart';

class RamadanCalendarPage extends StatelessWidget {
  final RamadanCalendarPresenter _presenter =
      locate<RamadanCalendarPresenter>();

  RamadanCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PresentableWidgetBuilder<RamadanCalendarPresenter>(
      presenter: _presenter,
      builder: () {
        final calendarState = _presenter.currentUiState;

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(SvgPath.appBgJpg),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              theme: theme,
              backgroundColor: Colors.transparent,
            ),
            body: CustomScrollView(
              key: Key('ramadan_calendar_page'),
              slivers: [
                // Title Section
                SliverToBoxAdapter(
                  key: Key('ramadan_calendar_title_section'),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Ramadan Calendar 2025',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: twentyTwoPx,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        gapH10,
                        Text(
                          calendarState.location != null
                              ? 'Ramadan Time Schedule in ${calendarState.location?.placeName}\n(GMT +6) Hijri 1446'
                              : 'Ramadan Time Schedule in Dhaka\nDistrict (GMT +6) Hijri 1446',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: thirteenPx,
                          ),
                        ),
                        gapH30,
                      ],
                    ),
                  ),
                ),

                // Rounded Container with Sticky Title Header
                SliverPersistentHeader(
                  key: Key('ramadan_calendar_title_header'),
                  pinned: true,
                  delegate: _StickyHeaderDelegate(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        top: sixteenPx,
                        left: sixteenPx,
                        right: sixteenPx,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(twentyFourPx),
                          topRight: Radius.circular(twentyFourPx),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: paddingH10,
                            height: fourPx,
                            width: sixtyPx,
                            decoration: BoxDecoration(
                              color: context.color.primaryColor200,
                              borderRadius: radius3,
                            ),
                          ),
                          gapH15,
                          Text(
                            'Ramadan 2025 Timetable',
                            style: theme.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: sixteenPx,
                            ),
                          ),
                        ],
                      ),
                    ),
                    minHeight: 70,
                    maxHeight: 70,
                  ),
                ),

                // Small gap before table header
                SliverToBoxAdapter(
                  key: Key('ramadan_calendar_table_header_gap'),
                  child: Container(
                    color: Colors.white,
                    height: 20,
                  ),
                ),

                // Sticky Table Header
                SliverPersistentHeader(
                  key: Key('ramadan_calendar_table_header'),
                  pinned: true,
                  delegate: _StickyHeaderDelegate(
                    child: Container(
                      key: Key('ramadan_calendar_table_header_container'),
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: sixteenPx),
                      child: _buildTableHeader(theme),
                    ),
                    minHeight: 45,
                    maxHeight: 45,
                  ),
                ),
                // Wrap gapH10 with SliverToBoxAdapter
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    child: gapH10,
                  ),
                ),

                // Calendar Content (Table Body Only)
                SliverToBoxAdapter(
                  key: Key('ramadan_calendar_table_body'),
                  child: Container(
                    key: Key('ramadan_calendar_table_body_container'),
                    padding: EdgeInsets.symmetric(horizontal: sixteenPx),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        calendarState.isLoading
                            ? _buildLoadingIndicator()
                            : _buildTableBody(
                                calendarState.ramadanCalendar,
                                theme,
                                calendarState.currentRamadanDay - 1,
                              ),
                        gapH20,
                        Text(
                          'Follow the Sehri and Iftar timing according to your local mosque or authorities during Ramadan.',
                          style: theme.textTheme.bodySmall!.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        gapH20,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildTableHeader(ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: twelvePx, horizontal: eightPx),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacityInt(0.1),
        borderRadius: radius8,
      ),
      child: Row(
        children: [
          _headerCell('Ramadan', 0.28, theme),
          _headerCell('Date', 0.25, theme),
          _headerCell('Day', 0.25, theme),
          _headerCell('Sehri', 0.2, theme),
          _headerCell('Iftar', 0.2, theme),
        ],
      ),
    );
  }

  Widget _headerCell(String text, double flex, ThemeData theme) {
    return Expanded(
      flex: (flex * 100).toInt(),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: twelvePx,
        ),
      ),
    );
  }

  Widget _buildTableBody(
      List<RamadanDayEntity> data, ThemeData theme, int currentDay) {
    // if data is empty
    if (data.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Loading failed, please try again',
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      );
    }

    // show all 30 days of Ramadan
    return Column(
      children: List.generate(
        data.length,
        (index) => _buildTableRow(
          data[index],
          index,
          theme,
          isHighlighted: currentDay >= 0 && currentDay < 30
              ? index == currentDay
              : false, // highlight current day
          isLastRow: index == data.length - 1,
        ),
      ),
    );
  }

  Widget _buildTableRow(
    RamadanDayEntity data,
    int index,
    ThemeData theme, {
    bool isHighlighted = false,
    bool isLastRow = false,
  }) {
    final Color rowColor = isHighlighted
        ? theme.primaryColor
        : index % 2 == 0
            ? Colors.transparent
            : theme.primaryColor.withOpacityInt(0.1);

    return Container(
      padding: EdgeInsets.symmetric(vertical: eightPx),
      decoration: BoxDecoration(
        color: rowColor,
        borderRadius: radius8,
      ),
      child: Row(
        children: [
          _tableCell(data.day, 0.28, theme, isHighlighted: isHighlighted),
          _tableCell(data.date, 0.25, theme, isHighlighted: isHighlighted),
          _tableCell(data.weekday, 0.25, theme, isHighlighted: isHighlighted),
          _tableCell(data.sehriTime, 0.2, theme, isHighlighted: isHighlighted),
          _tableCell(data.iftarTime, 0.2, theme, isHighlighted: isHighlighted),
        ],
      ),
    );
  }

  Widget _tableCell(String text, double flex, ThemeData theme,
      {bool isHighlighted = false}) {
    return Expanded(
      flex: (flex * 100).toInt(),
      child: Padding(
        padding: paddingV8,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: elevenPx,
            color: isHighlighted ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}

// Custom SliverPersistentHeaderDelegate for the sticky header
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  _StickyHeaderDelegate({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Ensure the child takes the full height to avoid layout/paint discrepancy
    return SizedBox(
      height: maxExtent,
      child: child,
    );
  }

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return child != oldDelegate.child ||
        minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight;
  }
}
