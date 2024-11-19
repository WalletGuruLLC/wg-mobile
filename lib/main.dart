import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/application/push_notifications/push_notification_cubit.dart';
import 'package:wallet_guru/infrastructure/dynamic_links/data_sources/dynamic_links_data_sources.dart';
import 'package:wallet_guru/presentation/core/widgets/wallet_guru_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  Injector.setup();
  DynamicLinksDataSources.initDynamicLink();
  DynamicLinksDataSources.listenDynamicLinks();

  final pushNotificationCubit = Injector.resolve<PushNotificationCubit>();
  await pushNotificationCubit.initialize();

  runApp(const MyApp());
}
