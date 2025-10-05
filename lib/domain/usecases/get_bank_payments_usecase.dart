import 'package:fpdart/fpdart.dart';
import 'package:salat_times/core/base/base_use_case.dart';
import 'package:salat_times/domain/entities/payment_entity.dart';
import 'package:salat_times/domain/repositories/payment_repository.dart';
import 'package:salat_times/domain/service/error_message_handler.dart';

class GetBankPaymentsUseCase extends BaseUseCase<List<BankPaymentEntity>> {
  final PaymentRepository _paymentRepository;

  GetBankPaymentsUseCase(
    this._paymentRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Stream<Either<String, List<BankPaymentEntity>>> execute() {
    return _paymentRepository.getBankPaymentsStream();
  }
}
