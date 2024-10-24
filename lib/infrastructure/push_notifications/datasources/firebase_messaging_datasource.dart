import 'package:firebase_messaging/firebase_messaging.dart';

import '../services/push_notification_service.dart';
import '../../../domain/push_notifications/entities/push_notification.dart';

class FirebaseMessagingDatasource {
  Future<void> initialize() async {
    await PushNotificationService.initialize();
  }

  Future<String?> getToken() async {
    return await PushNotificationService.getToken();
  }

  Stream<PushNotification> get notificationStream {
    return FirebaseMessaging.onMessage.map((RemoteMessage message) {
      return PushNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        data: message.data,
      );
    });
  }

  Future<void> subscribeToTopic(String topic) async {
    await PushNotificationService.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await PushNotificationService.unsubscribeFromTopic(topic);
  }
}