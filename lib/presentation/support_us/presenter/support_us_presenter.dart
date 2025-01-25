import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/payment_entity.dart';
import 'package:qibla_and_prayer_times/presentation/support_us/presenter/support_us_ui_state.dart';

class SupportUsPresenter extends BasePresenter<SupportUsUiState> {
  final Obs<SupportUsUiState> uiState = Obs(SupportUsUiState.empty());
  SupportUsUiState get currentUiState => uiState.value;

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

  void updateBuildContext(BuildContext context) {
    uiState.value = currentUiState.copyWith(context: context);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(message: message, context: currentUiState.context);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
