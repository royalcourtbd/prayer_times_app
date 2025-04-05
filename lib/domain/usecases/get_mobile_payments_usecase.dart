import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/core/base/base_use_case.dart';
import 'package:qibla_and_prayer_times/domain/entities/payment_entity.dart';
import 'package:qibla_and_prayer_times/domain/repositories/payment_repository.dart';
import 'package:qibla_and_prayer_times/domain/service/error_message_handler.dart';

class GetMobilePaymentsUseCase extends BaseUseCase<List<MobilePaymentEntity>> {
  final PaymentRepository _paymentRepository;

  GetMobilePaymentsUseCase(
    this._paymentRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Stream<Either<String, List<MobilePaymentEntity>>> execute() {
    return _paymentRepository.getMobilePaymentsStream();
  }
}
