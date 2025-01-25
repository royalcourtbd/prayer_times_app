import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';
import 'package:qibla_and_prayer_times/domain/entities/payment_entity.dart';

class SupportUsUiState extends BaseUiState {
  final List<BankPaymentEntity> bankPayments;
  final List<MobilePaymentEntity> mobilePayments;
  final BuildContext? context;

  const SupportUsUiState({
    required super.isLoading,
    required super.userMessage,
    required this.bankPayments,
    required this.mobilePayments,
    this.context,
  });

  factory SupportUsUiState.empty() {
    return const SupportUsUiState(
      isLoading: false,
      userMessage: '',
      bankPayments: [],
      mobilePayments: [],
      context: null,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        bankPayments,
        mobilePayments,
        context,
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
      context: context ?? this.context,
    );
  }
}
