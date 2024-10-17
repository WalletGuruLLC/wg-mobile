import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/application/push_notifications/push_notification_state.dart';
import 'package:wallet_guru/domain/push_notifications/usecases/initialize_push_notifications.dart';

class PushNotificationCubit extends Cubit<PushNotificationState> {
  PushNotificationCubit() : super(PushNotificationInitial());

  final initializePushNotifications = Injector.resolve<InitializePushNotifications>();

  Future<void> initialize() async {
    try {
      await initializePushNotifications();
      emit(PushNotificationInitialized());
    } catch (e) {
      emit(PushNotificationError(e.toString()));
    }
  }
}