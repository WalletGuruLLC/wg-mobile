import 'package:wallet_guru/domain/push_notifications/repositories/push_notification_repository.dart';

class InitializePushNotifications {
  final PushNotificationRepository repository;

  InitializePushNotifications(this.repository);

  Future<void> call() async {
    await repository.initialize();
  }
}