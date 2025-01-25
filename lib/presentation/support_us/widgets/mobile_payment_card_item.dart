import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/payment_entity.dart';

class MobilePaymentCardItem extends StatelessWidget {
  const MobilePaymentCardItem({
    super.key,
    required this.theme,
    required this.mobilePaymentEntity,
  });

  final ThemeData theme;
  final MobilePaymentEntity mobilePaymentEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding15,
      decoration: BoxDecoration(
        color: mobilePaymentEntity.cardColor!.withOpacityInt(0.07),
        borderRadius: radius15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgImage(
                mobilePaymentEntity.iconPath,
                width: 30,
                height: 30,
              ),
              SvgImage(
                SvgPath.icCopy,
                color: mobilePaymentEntity.cardColor,
              )
            ],
          ),
          gapH22,
          Text(
            mobilePaymentEntity.bankName,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: thirteenPx,
            ),
          ),
          Text(
            mobilePaymentEntity.mobileNumber,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: fifteenPx,
            ),
          ),
        ],
      ),
    );
  }
}
