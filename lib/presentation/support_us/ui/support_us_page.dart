import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/domain/entities/payment_entity.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_container.dart';
import 'package:qibla_and_prayer_times/presentation/support_us/presenter/support_us_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/support_us/widgets/bank_payment_card_item.dart';
import 'package:qibla_and_prayer_times/presentation/support_us/widgets/mobile_payment_card_item.dart';

class SupportUsPage extends StatelessWidget {
  SupportUsPage({super.key});

  final SupportUsPresenter _supportUsPresenter = locate<SupportUsPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _supportUsPresenter.updateBuildContext(context);
    return PresentableWidgetBuilder(
        presenter: _supportUsPresenter,
        builder: () {
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
                            itemCount: _supportUsPresenter
                                .currentUiState.mobilePayments.length,
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
                                  _supportUsPresenter
                                      .currentUiState.mobilePayments[index];

                              return MobilePaymentCardItem(
                                theme: theme,
                                mobilePaymentEntity: mobilePaymentEntity,
                                onCopy: (mobilePaymentEntity) {
                                  _supportUsPresenter.copyMobilePaymentInfo(
                                      mobilePayment: mobilePaymentEntity);
                                },
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
                            itemCount: _supportUsPresenter
                                .currentUiState.bankPayments.length,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final BankPaymentEntity bankPaymentEntity =
                                  _supportUsPresenter
                                      .currentUiState.bankPayments[index];

                              return BankPaymentCardItem(
                                theme: theme,
                                bankPaymentEntity: bankPaymentEntity,
                                onCopy: (bankPaymentEntity) {
                                  _supportUsPresenter.copyBankInfo(
                                      bankPayment: bankPaymentEntity);
                                },
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
        });
  }
}
