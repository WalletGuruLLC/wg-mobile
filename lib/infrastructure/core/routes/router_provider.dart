import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guru/application/login/login_cubit.dart';

import 'package:wallet_guru/infrastructure/core/routes/router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: Routes.splash.path,
  debugLogDiagnostics: true,
  navigatorKey: navigatorKey,
  routes: WalletGuruRouter.routes,
);
