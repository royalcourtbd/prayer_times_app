import 'package:flutter/material.dart';
import 'package:prayer_times/core/base/base_entity.dart';

class MobilePaymentEntity extends BaseEntity {
  final String paymentType;
  final String bankName;
  final String iconPath;
  final String mobileNumber;
  final bool isActive;
  final Color? cardColor;

  const MobilePaymentEntity({
    required this.paymentType,
    required this.bankName,
    required this.iconPath,
    required this.mobileNumber,
    required this.isActive,
    this.cardColor,
  });

  @override
  List<Object?> get props => [
        paymentType,
        bankName,
        iconPath,
        mobileNumber,
        isActive,
        cardColor,
      ];
}

class BankPaymentEntity extends BaseEntity {
  final String paymentType;
  final String bankName;
  final String iconPath;
  final String accountNumber;
  final String accountHolderName;
  final String branchName;
  final bool isActive;
  final String? routingNumber;
  final String? district;
  final String? swiftCode;
  final Color? cardColor;

  const BankPaymentEntity({
    required this.paymentType,
    required this.bankName,
    required this.iconPath,
    required this.accountNumber,
    required this.accountHolderName,
    required this.isActive,
    required this.branchName,
    required this.routingNumber,
    required this.swiftCode,
    this.cardColor,
    this.district,
  });

  @override
  List<Object?> get props => [
        paymentType,
        bankName,
        iconPath,
        accountNumber,
        isActive,
        accountHolderName,
        branchName,
        routingNumber,
        swiftCode,
        cardColor,
        district,
      ];
}
