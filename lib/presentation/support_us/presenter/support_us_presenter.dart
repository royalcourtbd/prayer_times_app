import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/payment_entity.dart';
import 'package:qibla_and_prayer_times/presentation/support_us/presenter/support_us_ui_state.dart';

class SupportUsPresenter extends BasePresenter<SupportUsUiState> {
  final Obs<SupportUsUiState> uiState = Obs(SupportUsUiState.empty());
  SupportUsUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    loadPayments();
    super.onInit();
  }

  void loadPayments() {
    uiState.value = currentUiState.copyWith(
      bankPayments: bankPayments,
      mobilePayments: mobilePayments,
    );
  }

  Future<void> copyBankInfo({required BankPaymentEntity bankPayment}) async {
    final String bankInfo = '''
Account Name: ${bankPayment.accountHolderName}
Account Number: ${bankPayment.accountNumber}
Bank Name: ${bankPayment.bankName}
Branch Name: ${bankPayment.branchName}
Routing Number: ${bankPayment.routingNumber}
Swift Code: ${bankPayment.swiftCode}
''';

    await copyText(text: bankInfo);
    addUserMessage('Bank information copied to clipboard');
  }

  Future<void> copyMobilePaymentInfo(
      {required MobilePaymentEntity mobilePayment}) async {
    await copyText(text: mobilePayment.mobileNumber);
    addUserMessage('Mobile number copied to clipboard');
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
      mobileNumber: '+88016422943211',
      cardColor: Colors.red,
    ),
    const MobilePaymentEntity(
      bankName: 'Nagad',
      iconPath: SvgPath.nagad,
      mobileNumber: '+8801842081997',
      cardColor: Colors.green,
    ),
  ];

  void updateBuildContext(BuildContext context) {
    uiState.value = currentUiState.copyWith(context: context);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(message: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
