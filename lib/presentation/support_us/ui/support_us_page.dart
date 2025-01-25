import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/payment_entity.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_container.dart';
import 'package:qibla_and_prayer_times/presentation/support_us/widgets/mobile_payment_card_item.dart';

class SupportUsPage extends StatelessWidget {
  const SupportUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Support Us',
        theme: theme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding15,
          child: Column(
            spacing: sixteenPx,
            children: [
              const SizedBox(
                height: 150,
                width: double.infinity,
                child: SvgImage(SvgPath.imgCurrency),
              ),
              CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: twelvePx,
                  children: [
                    Text(
                      'Tap to copy number - ',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: eighteenPx,
                      ),
                    ),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: mobilePayments.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.2 / 1,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final MobilePaymentEntity mobilePaymentEntity =
                            mobilePayments[index];

                        return MobilePaymentCardItem(
                          theme: theme,
                          mobilePaymentEntity: mobilePaymentEntity,
                        );
                      },
                    ),
                    gapH20,
                    Text(
                      'Bank Payment',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: eighteenPx,
                      ),
                    ),
                    ListView.builder(
                      itemCount: bankPayments.length,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final BankPaymentEntity bankPaymentEntity =
                            bankPayments[index];

                        return BankPaymentCardItem(
                          theme: theme,
                          bankPaymentEntity: bankPaymentEntity,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BankPaymentCardItem extends StatelessWidget {
  const BankPaymentCardItem({
    super.key,
    required this.theme,
    required this.bankPaymentEntity,
  });

  final ThemeData theme;
  final BankPaymentEntity bankPaymentEntity;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: padding15,
      color: bankPaymentEntity.cardColor!.withOpacityInt(0.07),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                SvgPath.logoIbbl,
                width: 50,
                height: 50,
              ),
              SvgImage(
                SvgPath.icCopy,
                color: bankPaymentEntity.cardColor,
              )
            ],
          ),
          gapH20,
          Text(bankPaymentEntity.accountNumber),
          gapH20,
          Text(bankPaymentEntity.accountHolderName),
          gapH20,
          Text(bankPaymentEntity.branchName),
          gapH20,
          Text(bankPaymentEntity.routingNumber!),
          gapH20,
          Text(bankPaymentEntity.swiftCode!),
        ],
      ),
    );
  }
}

final List<BankPaymentEntity> bankPayments = [
  const BankPaymentEntity(
    bankName: 'Bank Asia',
    iconPath: SvgPath.bkash,
    accountNumber: '1234567890',
    accountHolderName: 'John Doe',
    branchName: 'Dhaka',
    routingNumber: '1234567890',
    swiftCode: '1234567890',
    cardColor: Colors.blue,
  ),
];

final List<MobilePaymentEntity> mobilePayments = [
  const MobilePaymentEntity(
    bankName: 'bKash',
    iconPath: SvgPath.bkash,
    mobileNumber: '+8801749247855',
    cardColor: Colors.blue,
  ),
  const MobilePaymentEntity(
    bankName: 'Rocket',
    iconPath: SvgPath.rocket,
    mobileNumber: '+8801749247855',
    cardColor: Colors.red,
  ),
  const MobilePaymentEntity(
    bankName: 'Nagad',
    iconPath: SvgPath.nagad,
    mobileNumber: '+8801749247855',
    cardColor: Colors.green,
  ),
];
