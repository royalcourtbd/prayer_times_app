import 'package:flutter/material.dart';
import 'package:salat_times/core/utility/color_utility.dart';
import 'package:salat_times/domain/entities/payment_entity.dart';

class MobilePaymentModel extends MobilePaymentEntity {
  const MobilePaymentModel({
    required super.paymentType,
    required super.isActive,
    required super.bankName,
    required super.iconPath,
    required super.mobileNumber,
    super.cardColor,
  });

  factory MobilePaymentModel.fromJson(Map<String, dynamic> json) {
    return MobilePaymentModel(
      paymentType: json['paymentType'] as String,
      isActive: json['isActive'] as bool,
      bankName: json['bankName'] as String,
      iconPath: json['iconPath'] as String,
      mobileNumber: json['mobileNumber'] as String,
      cardColor: json['cardColor'] as Color?,
    );
  }

  factory MobilePaymentModel.fromFirestore(Map<String, dynamic> data) {
    return MobilePaymentModel(
      paymentType: data['payment_type'] ?? '',
      isActive: data['is_active'] ?? false,
      bankName: data['bank_name'] ?? '',
      iconPath: data['icon_path'] ?? '',
      mobileNumber: data['number'] ?? '',
      cardColor: getColorFromHex(data['card_color']),
    );
  }

  MobilePaymentModel copyWith({
    String? paymentType,
    String? bankName,
    String? iconPath,
    String? mobileNumber,
    Color? cardColor,
    bool? isActive,
  }) {
    return MobilePaymentModel(
      paymentType: paymentType ?? this.paymentType,
      bankName: bankName ?? this.bankName,
      iconPath: iconPath ?? this.iconPath,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      cardColor: cardColor ?? this.cardColor,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        paymentType,
        bankName,
        iconPath,
        mobileNumber,
        cardColor,
      ];
}

class BankPaymentModel extends BankPaymentEntity {
  const BankPaymentModel({
    required super.paymentType,
    required super.bankName,
    required super.iconPath,
    required super.accountNumber,
    required super.accountHolderName,
    required super.branchName,
    required super.isActive,
    super.routingNumber,
    super.swiftCode,
    super.district,
    super.cardColor,
  });

  factory BankPaymentModel.fromJson(Map<String, dynamic> json) {
    return BankPaymentModel(
      paymentType: json['paymentType'] as String,
      bankName: json['bankName'] as String,
      iconPath: json['iconPath'] as String,
      accountNumber: json['accountNumber'] as String,
      accountHolderName: json['accountHolderName'] as String,
      branchName: json['branchName'] as String,
      isActive: json['isActive'] as bool,
      routingNumber: json['routingNumber'] as String,
      swiftCode: json['swiftCode'] as String,
      district: json['district'] as String?,
      cardColor: json['cardColor'] as Color?,
    );
  }

  factory BankPaymentModel.fromFirestore(Map<String, dynamic> data) {
    return BankPaymentModel(
      paymentType: data['payment_type'] ?? '',
      bankName: data['bank_name'] ?? '',
      iconPath: data['icon_path'] ?? '',
      isActive: data['is_active'] ?? false,
      accountNumber: data['account_number'] ?? '',
      accountHolderName: data['account_holder_name'] ?? '',
      branchName: data['branch_name'] ?? '',
      routingNumber: data['routing_number'],
      swiftCode: data['swift_code'],
      district: data['district'],
      cardColor: getColorFromHex(data['card_color']),
    );
  }

  @override
  List<Object?> get props => [
        paymentType,
        bankName,
        iconPath,
        accountNumber,
        accountHolderName,
        branchName,
        isActive,
        routingNumber,
        swiftCode,
        cardColor,
        district,
      ];

  BankPaymentModel copyWith({
    String? paymentType,
    String? bankName,
    String? iconPath,
    String? accountNumber,
    String? accountHolderName,
    String? branchName,
    String? routingNumber,
    bool? isActive,
    String? swiftCode,
    Color? cardColor,
    String? district,
  }) {
    return BankPaymentModel(
      paymentType: paymentType ?? this.paymentType,
      bankName: bankName ?? this.bankName,
      iconPath: iconPath ?? this.iconPath,
      accountNumber: accountNumber ?? this.accountNumber,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      branchName: branchName ?? this.branchName,
      routingNumber: routingNumber ?? this.routingNumber,
      isActive: isActive ?? this.isActive,
      swiftCode: swiftCode ?? this.swiftCode,
      cardColor: cardColor ?? this.cardColor,
      district: district ?? this.district,
    );
  }
}
