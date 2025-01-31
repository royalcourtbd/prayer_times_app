import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_button.dart';
import 'package:qibla_and_prayer_times/presentation/notification/presenter/notification_preenter.dart';
import 'package:qibla_and_prayer_times/presentation/notification/presenter/notification_ui_state.dart';

import 'package:qibla_and_prayer_times/domain/entities/notification_entity.dart';
import 'package:qibla_and_prayer_times/presentation/notification/ui/notification_details_page.dart';

class NotificationPage extends StatelessWidget {
  final NotificationPresenter _presenter = locate<NotificationPresenter>();

  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _presenter.updateContext(context);

    return PresentableWidgetBuilder(
      presenter: _presenter,
      onInit: () {},
      builder: () {
        final NotificationUiState currentUiState = _presenter.currentUiState;

        return Scaffold(
          appBar: CustomAppBar(
            title: 'Notifications',
            theme: theme,
          ),
          body: currentUiState.notifications.isEmpty
              ? _buildEmptyState(theme, context)
              : _buildNotificationList(
                  currentUiState.notifications, theme, context),
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SvgImage(SvgPath.icNotificationOutline),
          gapH16,
          Text(
            'No Notifications Yet',
            style: theme.textTheme.titleMedium!.copyWith(
              color: context.color.titleColor,
            ),
          ),
          gapH8,
          Text(
            'You\'ll receive notifications about prayer times and updates here',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: context.color.subTitleColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(
    List<NotificationEntity> notifications,
    ThemeData theme,
    BuildContext context,
  ) {
    return ListView.separated(
      padding: padding15,
      itemCount: notifications.length,
      separatorBuilder: (_, __) => gapH16,
      itemBuilder: (context, index) {
        final NotificationEntity notification = notifications[index];
        return InkWell(
          borderRadius: radius15,
          onTap: () {
            _presenter.markAsRead(notification.id);
            context.navigatorPush(
                NotificationDetailsPage(notification: notification));
          },
          child: Container(
            padding: padding15,
            decoration: BoxDecoration(
              color: notification.isRead
                  ? context.color.scaffoldBachgroundColor
                  : context.color.primaryColor25,
              borderRadius: radius10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: twentyTwoPx,
                  backgroundColor: generateAvatarColor(
                    index: index,
                  ),
                  child: SvgImage(
                    notification.imageUrl ?? '',
                    color: context.color.whiteColor,
                  ),
                ),
                gapW14,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium!.copyWith(
                          color: context.color.titleColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapH8,
                      Text(
                        notification.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: context.color.subTitleColor,
                        ),
                      ),
                      gapH8,
                      if (notification.actionUrl != null) ...[
                        gapH8,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            height: fortyTwoPx,
                            width: 42.percentWidth,
                            child: CustomButton(
                              key: UniqueKey(),
                              horizontalPadding: 0,
                              title: 'Support Now',
                              onPressed: () {},
                              iconPath: SvgPath.icLovely,
                            ),
                          ),
                        ),
                        gapH16,
                      ],
                      Text(
                        _getFormattedTime(notification.timestamp),
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: context.color.captionColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getFormattedTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} Days Ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} Hours Ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} Minutes Ago';
    } else {
      return 'Just Now';
    }
  }

  Color generateAvatarColor(
      {required int index, Color baseColor = const Color(0xFF417360)}) {
    // বেস কালার থেকে HSL ভ্যালু নিয়ে নতুন কালার জেনারেট করা
    final HSLColor hslColor = HSLColor.fromColor(baseColor);

    // প্রতি ইনডেক্সে হিউ ভ্যালু পরিবর্তন (30 ডিগ্রি করে)
    final double newHue = (hslColor.hue + (index * 30)) % 360;

    // স্যাচুরেশন এবং লাইটনেস মডিফাই করা
    final double saturation = 0.3 + (index % 3) * 0.2; // 0.3 থেকে 0.7 এর মধ্যে
    final double lightness = 0.4 + (index % 2) * 0.1; // 0.4 থেকে 0.5 এর মধ্যে

    // নতুন HSL কালার তৈরি
    final HSLColor newHslColor = HSLColor.fromAHSL(
      1.0,
      newHue,
      saturation,
      lightness,
    );

    return newHslColor.toColor();
  }
}
