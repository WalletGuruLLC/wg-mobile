import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;

    // Configuración para Android
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuración para iOS
    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        // Manejar la interacción con la notificación
        handleNotificationTap(details);
      },
    );

    // Configurar handlers de Firebase Messaging
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationOpen);

    _initialized = true;
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    await showNotification(message);
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    await showNotification(message);
  }

  static void _handleNotificationOpen(RemoteMessage message) {
    // Implementar la navegación según los datos de la notificación
    if (message.data.containsKey('route')) {
      // Implementar navegación
    }
  }

  static void handleNotificationTap(NotificationResponse details) {
    // Implementar la navegación según los datos de la notificación local
    final payload = details.payload;
    if (payload != null) {
      // Implementar navegación
    }
  }

  static Future<void> showNotification(RemoteMessage message) async {
    final androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
    );

    final iOSDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      details,
      payload: message.data.toString(),
    );
  }

  static Future<String?> getToken() async {
    print(FirebaseMessaging.instance.getToken());
    return await FirebaseMessaging.instance.getToken();
  }

  static Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }
}
