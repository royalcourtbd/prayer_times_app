import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/font_family.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/home_presenter.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({
    super.key,
    required this.theme,
    required this.onBuildContainer,
    required this.presenter,
  });

  final ThemeData theme;
  final HomePresenter presenter;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgImage(
                SvgPath.icLocation,
                height: twentyPx,
                width: twentyPx,
              ),
              gapW5,
              Expanded(
                child: Text(
                  presenter.currentUiState.location?.placeName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: twelvePx,
                    fontFamily: FontFamily.poppins,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            presenter.currentUiState.hijriDate ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: twelvePx,
              fontWeight: FontWeight.w600,
            ),
          ),
          gapH3,
          Text(
            'July 20, 2025',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: twelvePx,
              color: context.color.subTitleColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
