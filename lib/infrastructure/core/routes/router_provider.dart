import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash.path,
  debugLogDiagnostics: true,
  routes: WalletGuruRouter.routes,
);
