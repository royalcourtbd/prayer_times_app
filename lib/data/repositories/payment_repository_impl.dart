import 'package:fpdart/fpdart.dart';
import 'package:salat_times/data/datasources/remote/payment_remote_data_source.dart';
import 'package:salat_times/domain/entities/payment_entity.dart';
import 'package:salat_times/domain/repositories/payment_repository.dart';
import 'package:salat_times/domain/service/error_message_handler.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource _paymentRemoteDataSource;
  final ErrorMessageHandler _errorMessageHandler;

  PaymentRepositoryImpl(
    this._paymentRemoteDataSource,
    this._errorMessageHandler,
  );

  @override
  Stream<Either<String, List<BankPaymentEntity>>> getBankPaymentsStream() {
    return _paymentRemoteDataSource
        .getBankPaymentsStream()
        .map(
          (bankPayments) =>
              right<String, List<BankPaymentEntity>>(bankPayments),
        )
        .handleError((error) {
      final String errorMessage =
          _errorMessageHandler.generateErrorMessage(error);
      return left<String, List<BankPaymentEntity>>(errorMessage);
    });
  }

  @override
  Stream<Either<String, List<MobilePaymentEntity>>> getMobilePaymentsStream() {
    return _paymentRemoteDataSource
        .getMobilePaymentsStream()
        .map(
          (mobilePayments) =>
              right<String, List<MobilePaymentEntity>>(mobilePayments),
        )
        .handleError((error) {
      final String errorMessage =
          _errorMessageHandler.generateErrorMessage(error);
      return left<String, List<MobilePaymentEntity>>(errorMessage);
    });
  }
}
