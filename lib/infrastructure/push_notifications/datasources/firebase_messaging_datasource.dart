import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wallet_guru/domain/push_notifications/entities/push_notification.dart';

class FirebaseMessagingDatasource {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await Firebase.initializeApp();
    await _firebaseMessaging.requestPermission();
    // Configurar manejadores de mensajes aquí
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
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
}