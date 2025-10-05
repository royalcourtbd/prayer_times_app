import 'package:flutter/material.dart';
import 'package:salat_times/core/base/base_ui_state.dart';
import 'package:salat_times/domain/entities/payment_entity.dart';

class SupportUsUiState extends BaseUiState {
  final List<BankPaymentEntity> bankPayments;
  final List<MobilePaymentEntity> mobilePayments;

  const SupportUsUiState({
    required super.isLoading,
    required super.userMessage,
    required this.bankPayments,
    required this.mobilePayments,
  });

  factory SupportUsUiState.empty() {
    return const SupportUsUiState(
      isLoading: false,
      userMessage: '',
      bankPayments: [],
      mobilePayments: [],
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        bankPayments,
        mobilePayments,
      ];

  SupportUsUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<BankPaymentEntity>? bankPayments,
    List<MobilePaymentEntity>? mobilePayments,
    BuildContext? context,
  }) {
    return SupportUsUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      bankPayments: bankPayments ?? this.bankPayments,
      mobilePayments: mobilePayments ?? this.mobilePayments,
    );
  }
}
