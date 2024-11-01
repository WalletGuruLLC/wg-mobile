import '../repositories/push_notification_repository.dart';

class InitializePushNotifications {
  final PushNotificationRepository repository;

  InitializePushNotifications(this.repository);

  Future<void> call() async {
    await repository.initialize();
  }
}

class GetPushNotificationToken {
  final PushNotificationRepository repository;

  GetPushNotificationToken(this.repository);

  Future<String?> call() async {
    return await repository.getToken();
  }
}

class SubscribeToTopic {
  final PushNotificationRepository repository;

  SubscribeToTopic(this.repository);

  Future<void> call(String topic) async {
    await repository.subscribeToTopic(topic);
  }
}

class UnsubscribeFromTopic {
  final PushNotificationRepository repository;

  UnsubscribeFromTopic(this.repository);

  Future<void> call(String topic) async {
    await repository.unsubscribeFromTopic(topic);
  }
}

/*class HandleNotificationTap {
  final PushNotificationRepository repository;

  HandleNotificationTap(this.repository);

  Future<void> call(Map<String, dynamic> payload) async {
    await repository.handleNotificationTap(payload);
  }
}*/