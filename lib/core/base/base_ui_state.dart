import 'package:equatable/equatable.dart';

/// This abstract class is used as a base for all UI states in the app.
///
/// By making each UI state extend Equatable, the developer is forced to
/// implement value equality, which can help prevent bugs related to state
/// management.
///
/// Additionally, the class includes fields for isLoading and userMessage, which
/// are common to many UI states in the app, helping to keep the code more
/// organized and consistent.
///
/// This class helps to improve code readability, maintainability, and
/// reduces the risk of errors in the UI.
abstract class BaseUiState extends Equatable {
  const BaseUiState({
    required this.isLoading,
    required this.userMessage,
  });

  final bool isLoading;
  final String? userMessage;
}
