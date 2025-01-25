import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/domain/entities/payment_entity.dart';

class MobilePaymentModel extends MobilePaymentModel {
  const MobilePaymentModel({
    required super.bankName,
    required super.iconPath,
    required super.mobileNumber,
    super.cardColor,
  });

  factory MobilePaymentModel.fromJson(Map<String, dynamic> json) {
    return MobilePaymentModel(
      bankName: json['bankName'] as String,
      iconPath: json['iconPath'] as String,
      mobileNumber: json['mobileNumber'] as String,
      cardColor: json['cardColor'] as Color?,
    );
  }

  MobilePaymentModel copyWith({
    String? bankName,
    String? iconPath,
    String? mobileNumber,
    Color? cardColor,
  }) {
    return MobilePaymentModel(
      bankName: bankName ?? this.bankName,
      iconPath: iconPath ?? this.iconPath,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      cardColor: cardColor ?? this.cardColor,
    );
  }

  @override
  List<Object?> get props => [
        bankName,
        iconPath,
        mobileNumber,
        cardColor,
      ];
}

class BankPaymentModel extends BankPaymentEntity {
  const BankPaymentModel({
    required super.bankName,
    required super.iconPath,
    required super.accountNumber,
    required super.accountHolderName,
    required super.branchName,
    super.routingNumber,
    super.swiftCode,
  });

  factory BankPaymentModel.fromJson(Map<String, dynamic> json) {
    return BankPaymentModel(
      bankName: json['bankName'] as String,
      iconPath: json['iconPath'] as String,
      accountNumber: json['accountNumber'] as String,
      accountHolderName: json['accountHolderName'] as String,
      branchName: json['branchName'] as String,
      routingNumber: json['routingNumber'] as String,
      swiftCode: json['swiftCode'] as String,
    );
  }

  @override
  List<Object?> get props => [
        bankName,
        iconPath,
        accountNumber,
        accountHolderName,
        branchName,
        routingNumber,
        swiftCode,
      ];

  BankPaymentModel copyWith({
    String? bankName,
    String? iconPath,
    String? accountNumber,
    String? accountHolderName,
    String? branchName,
    String? routingNumber,
    String? swiftCode,
  }) {
    return BankPaymentModel(
      bankName: bankName ?? this.bankName,
      iconPath: iconPath ?? this.iconPath,
      accountNumber: accountNumber ?? this.accountNumber,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      branchName: branchName ?? this.branchName,
      routingNumber: routingNumber ?? this.routingNumber,
      swiftCode: swiftCode ?? this.swiftCode,
    );
  }
}
