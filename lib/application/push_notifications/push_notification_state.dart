abstract class PushNotificationState {}

class PushNotificationInitial extends PushNotificationState {}

class PushNotificationInitialized extends PushNotificationState {}

class PushNotificationError extends PushNotificationState {
  final String message;

  PushNotificationError(this.message);
}