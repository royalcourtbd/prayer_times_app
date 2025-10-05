import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/external_libs/svg_image.dart';
import 'package:salat_times/core/static/svg_path.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/domain/entities/payment_entity.dart';
import 'package:salat_times/presentation/common/custom_container.dart';

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
              CachedNetworkImage(
                imageUrl: bankPaymentEntity.iconPath,
                width: fiftyFivePx,
                height: fiftyFivePx,
                placeholder: (context, url) =>
                    const Icon(Icons.image, color: Colors.grey),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
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
            label: 'District: ',
            value: bankPaymentEntity.district!,
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
