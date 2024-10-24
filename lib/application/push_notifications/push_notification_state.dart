abstract class PushNotificationState {}

class PushNotificationInitial extends PushNotificationState {}

class PushNotificationInitialized extends PushNotificationState {
  final String? token;
  PushNotificationInitialized({this.token});
}

class TopicSubscribed extends PushNotificationState {
  final String topic;
  TopicSubscribed(this.topic);
}

class TopicUnsubscribed extends PushNotificationState {
  final String topic;
  TopicUnsubscribed(this.topic);
}

class NotificationHandled extends PushNotificationState {
  final Map<String, dynamic> payload;
  NotificationHandled(this.payload);
}

class PushNotificationError extends PushNotificationState {
  final String message;
  PushNotificationError(this.message);
}