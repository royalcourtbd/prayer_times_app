import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/payment_entity.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_container.dart';

class BankPaymentCardItem extends StatelessWidget {
  const BankPaymentCardItem({
    super.key,
    required this.theme,
    required this.bankPaymentEntity,
    this.onCopy,
  });

  final ThemeData theme;
  final BankPaymentEntity bankPaymentEntity;
  final Function(BankPaymentEntity)? onCopy;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: padding15,
      color: bankPaymentEntity.cardColor!.withOpacityInt(0.07),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: thirteenPx,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                SvgPath.logoIbbl,
                width: fiftyFivePx,
                height: fiftyFivePx,
              ),
              InkWell(
                onTap: () {
                  onCopy?.call(bankPaymentEntity);
                },
                child: SvgImage(
                  SvgPath.icCopy,
                  color: bankPaymentEntity.cardColor,
                ),
              )
            ],
          ),
          _buildLabelValueText(
            label: 'Account Name: ',
            value: bankPaymentEntity.accountHolderName,
          ),
          _buildLabelValueText(
            label: 'Account Number: ',
            value: bankPaymentEntity.accountNumber,
          ),
          _buildLabelValueText(
            label: 'Bank Name: ',
            value: bankPaymentEntity.bankName,
          ),
          _buildLabelValueText(
            label: 'Branch Name: ',
            value: bankPaymentEntity.branchName,
          ),
          _buildLabelValueText(
            label: 'Routing Number: ',
            value: bankPaymentEntity.routingNumber!,
          ),
          _buildLabelValueText(
            label: 'Swift Code: ',
            value: bankPaymentEntity.swiftCode!,
          ),
        ],
      ),
    );
  }

  RichText _buildLabelValueText({
    required String label,
    required String value,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: thirteenPx,
            ),
          ),
          TextSpan(
            text: value,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: fourteenPx,
            ),
          ),
        ],
      ),
    );
  }
}
