import '../services/push_notification_service.dart';
import '../datasources/firebase_messaging_datasource.dart';
import '../../../domain/push_notifications/entities/push_notification.dart';
import '../../../domain/push_notifications/repositories/push_notification_repository.dart';

class PushNotificationRepositoryImpl implements PushNotificationRepository {
  final FirebaseMessagingDatasource _datasource;

  PushNotificationRepositoryImpl(this._datasource);

  @override
  Future<void> initialize() async {
    await _datasource.initialize();
  }

  @override
  Future<String?> getToken() async {
    return await _datasource.getToken();
  }

  @override
  Stream<PushNotification> get notificationStream =>
      _datasource.notificationStream;

  @override
  Future<void> subscribeToTopic(String topic) async {
    await PushNotificationService.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    await PushNotificationService.unsubscribeFromTopic(topic);
  }
}
