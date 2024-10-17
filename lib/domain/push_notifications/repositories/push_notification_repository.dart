import 'package:wallet_guru/domain/push_notifications/entities/push_notification.dart';

abstract class PushNotificationRepository {
  Future<void> initialize();
  Future<String?> getToken();
  Stream<PushNotification> get notificationStream;
}