import 'package:wallet_guru/domain/push_notifications/entities/push_notification.dart';
import 'package:wallet_guru/domain/push_notifications/repositories/push_notification_repository.dart';
import 'package:wallet_guru/infrastructure/push_notifications/datasources/firebase_messaging_datasource.dart';

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
  Stream<PushNotification> get notificationStream => _datasource.notificationStream;
}