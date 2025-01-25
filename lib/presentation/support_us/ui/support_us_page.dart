import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/domain/entities/payment_entity.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_container.dart';
import 'package:qibla_and_prayer_times/presentation/support_us/support_us_page.dart';

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
      body: Padding(
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
                    itemCount: mobilePayments.length,
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
