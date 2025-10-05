import 'package:salat_times/core/utility/trial_utility.dart';
import 'package:salat_times/data/services/backend_as_a_service.dart';

class InfoRemoteDataSourse {
  InfoRemoteDataSourse(this._backendAsAService);
  final BackendAsAService _backendAsAService;

  Future<void> getPromotionalMessage({
    required void Function(String) onPromotionalMessage,
  }) async {
    _backendAsAService.getRemoteNotice(
        onNotification: (Map<String, Object?> map) async {
      await catchFutureOrVoid(() async {
        final Map<String, Object?> remoteNotice = map.map(MapEntry.new);
        final String? promotionalMessage =
            remoteNotice['promotional_message'] as String?;
        if (promotionalMessage != null) {
          onPromotionalMessage(promotionalMessage);
        }
      });
    });
  }
}
