import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/payment_entity.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_bank_payments_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_mobile_payments_usecase.dart';
import 'package:qibla_and_prayer_times/presentation/support_us/presenter/support_us_ui_state.dart';

class SupportUsPresenter extends BasePresenter<SupportUsUiState> {
  final Obs<SupportUsUiState> uiState = Obs(SupportUsUiState.empty());
  SupportUsUiState get currentUiState => uiState.value;

  final GetBankPaymentsUseCase _getBankPaymentsUseCase;
  final GetMobilePaymentsUseCase _getMobilePaymentsUseCase;
  StreamSubscription<Either<String, List<BankPaymentEntity>>>?
      _bankPaymentsSubscription;
  StreamSubscription<Either<String, List<MobilePaymentEntity>>>?
      _mobilePaymentsSubscription;

  SupportUsPresenter(
    this._getBankPaymentsUseCase,
    this._getMobilePaymentsUseCase,
  );

  @override
  void onInit() {
    loadPaymentsStreams();
    super.onInit();
  }

  @override
  void onClose() {
    _bankPaymentsSubscription?.cancel();
    _mobilePaymentsSubscription?.cancel();
    super.onClose();
  }

  Future<void> loadPaymentsStreams() async {
    await toggleLoading(loading: true);
    _listenToBankPaymentsStream();
    _listenToMobilePaymentsStream();
    await toggleLoading(loading: false);
  }

  void _listenToBankPaymentsStream() {
    _bankPaymentsSubscription?.cancel();
    _bankPaymentsSubscription = _getBankPaymentsUseCase.execute().listen(
      (Either<String, List<BankPaymentEntity>> result) {
        result.fold(
          (error) => addUserMessage(error),
          (bankPayments) {
            uiState.value = currentUiState.copyWith(bankPayments: bankPayments);
          },
        );
      },
      onError: (error) {
        addUserMessage('পেমেন্ট তথ্য লোড করতে সমস্যা হয়েছে');
      },
    );
  }

  void _listenToMobilePaymentsStream() {
    _mobilePaymentsSubscription?.cancel();
    _mobilePaymentsSubscription = _getMobilePaymentsUseCase.execute().listen(
      (Either<String, List<MobilePaymentEntity>> result) {
        result.fold(
          (error) => addUserMessage(error),
          (mobilePayments) {
            uiState.value = currentUiState.copyWith(
              mobilePayments: mobilePayments,
            );
          },
        );
      },
      onError: (error) {
        addUserMessage('পেমেন্ট তথ্য লোড করতে সমস্যা হয়েছে');
      },
    );
  }

  Future<void> copyBankInfo({required BankPaymentEntity bankPayment}) async {
    final String bankInfo = '''
Account Name: ${bankPayment.accountHolderName}
Account Number: ${bankPayment.accountNumber}
Bank Name: ${bankPayment.bankName}
District: ${bankPayment.district}
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
