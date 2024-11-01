import 'package:flutter_bloc/flutter_bloc.dart';

import '../../infrastructure/core/injector/injector.dart';
import '../../application/push_notifications/push_notification_state.dart';
import '../../domain/push_notifications/usecases/initialize_push_notifications.dart';

class PushNotificationCubit extends Cubit<PushNotificationState> {
  PushNotificationCubit() : super(PushNotificationInitial());

  final initializePushNotifications =
      Injector.resolve<InitializePushNotifications>();
  final _getPushNotificationToken =
      Injector.resolve<GetPushNotificationToken>();
  final _subscribeToTopic = Injector.resolve<SubscribeToTopic>();
  final _unsubscribeFromTopic = Injector.resolve<UnsubscribeFromTopic>();
  //final _handleNotificationTap = Injector.resolve<HandleNotificationTap>();

  Future<void> initialize() async {
    try {
      await initializePushNotifications();
      final token = await _getPushNotificationToken();
      print("token: $token");
      emit(PushNotificationInitialized(token: token));
    } catch (e) {
      emit(PushNotificationError(e.toString()));
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _subscribeToTopic(topic);
      emit(TopicSubscribed(topic));
    } catch (e) {
      emit(PushNotificationError(e.toString()));
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _unsubscribeFromTopic(topic);
      emit(TopicUnsubscribed(topic));
    } catch (e) {
      emit(PushNotificationError(e.toString()));
    }
  }

  /*Future<void> handleNotificationTap(Map<String, dynamic> payload) async {
    try {
      await _handleNotificationTap(payload);
      emit(NotificationHandled(payload));
    } catch (e) {
      emit(PushNotificationError(e.toString()));
    }
  }*/
}
