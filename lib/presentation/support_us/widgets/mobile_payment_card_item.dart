import 'package:flutter/material.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/domain/entities/payment_entity.dart';
import 'package:salat_times/presentation/common/custom_container.dart';
import 'package:salat_times/presentation/support_us/widgets/payment_icon_row.dart';

class MobilePaymentCardItem extends StatelessWidget {
  const MobilePaymentCardItem({
    super.key,
    required this.theme,
    required this.mobilePaymentEntity,
    this.onCopy,
  });

  final ThemeData theme;
  final MobilePaymentEntity mobilePaymentEntity;
  final Function(MobilePaymentEntity)? onCopy;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onCopy?.call(mobilePaymentEntity),
      child: CustomContainer(
        padding: padding15,
        color: mobilePaymentEntity.cardColor!.withOpacityInt(0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentIconRow(mobilePaymentEntity: mobilePaymentEntity),
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
      ),
    );
  }
}
