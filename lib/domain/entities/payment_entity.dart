import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_entity.dart';

class MobilePaymentEntity extends BaseEntity {
  final String bankName;
  final String iconPath;
  final String mobileNumber;
  final Color? cardColor;

  const MobilePaymentEntity({
    required this.bankName,
    required this.iconPath,
    required this.mobileNumber,
    this.cardColor,
  });

  @override
  List<Object?> get props => [
        bankName,
        iconPath,
        mobileNumber,
        cardColor,
      ];
}

class BankPaymentEntity extends BaseEntity {
  final String bankName;
  final String iconPath;
  final String accountNumber;
  final String accountHolderName;
  final String branchName;
  final String? routingNumber;
  final String? swiftCode;
  final Color? cardColor;

  const BankPaymentEntity({
    required this.bankName,
    required this.iconPath,
    required this.accountNumber,
    required this.accountHolderName,
    required this.branchName,
    required this.routingNumber,
    required this.swiftCode,
    this.cardColor,
  });

  @override
  List<Object?> get props => [
        bankName,
        iconPath,
        accountNumber,
        accountHolderName,
        branchName,
        routingNumber,
        swiftCode,
        cardColor,
      ];
}
