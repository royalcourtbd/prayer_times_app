import 'package:fpdart/fpdart.dart';
import 'package:prayer_times/domain/entities/payment_entity.dart';

abstract class PaymentRepository {
  Stream<Either<String, List<BankPaymentEntity>>> getBankPaymentsStream();
  Stream<Either<String, List<MobilePaymentEntity>>> getMobilePaymentsStream();
}
