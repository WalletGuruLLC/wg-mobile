import '../entities/push_notification.dart';

abstract class PushNotificationRepository {
  Future<void> initialize();
  Future<String?> getToken();
  Stream<PushNotification> get notificationStream;
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
  //Future<void> handleNotificationTap(Map<String, dynamic> payload);
}