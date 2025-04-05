import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/external_libs/svg_image.dart';
import 'package:prayer_times/core/static/svg_path.dart';
import 'package:prayer_times/domain/entities/payment_entity.dart';

enum PaymentMethod {
  bkash(SvgPath.bkash),
  rocket(SvgPath.rocket),
  upay(SvgPath.upay),
  nagad(SvgPath.nagad),
  unknown('');

  final String iconPath;
  const PaymentMethod(this.iconPath);

  static PaymentMethod fromBankName(String bankName) {
    final lowerName = bankName.toLowerCase();
    return values.firstWhere(
      (method) => lowerName.contains(method.name),
      orElse: () => PaymentMethod.unknown,
    );
  }
}

class PaymentIconRow extends StatelessWidget {
  final MobilePaymentEntity mobilePaymentEntity;

  const PaymentIconRow({
    super.key,
    required this.mobilePaymentEntity,
  });

  @override
  Widget build(BuildContext context) {
    final paymentMethod =
        PaymentMethod.fromBankName(mobilePaymentEntity.bankName);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        paymentMethod != PaymentMethod.unknown
            ? SvgImage(
                paymentMethod.iconPath,
                width: thirtyTwoPx,
                height: thirtyTwoPx,
              )
            : SvgPicture.network(
                mobilePaymentEntity.iconPath,
                width: thirtyTwoPx,
                height: thirtyTwoPx,
              ),
        SvgImage(
          SvgPath.icCopy,
          color: mobilePaymentEntity.cardColor,
        ),
      ],
    );
  }
}
