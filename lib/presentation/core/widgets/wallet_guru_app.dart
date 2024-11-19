import 'package:flutter/material.dart';
import 'package:wallet_guru/application/core/state_provider.dart';
import 'package:wallet_guru/domain/core/auth/inactivity_service.dart';
import 'package:wallet_guru/infrastructure/core/routes/router_provider.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final InactivityService _inactivityService = InactivityService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addObserver(_inactivityService);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (navigatorKey.currentContext != null) {
        _inactivityService.startTimer(context);
      }
    });
  }

  @override
  void dispose() {
    _inactivityService.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycleState: $state');
    _inactivityService.handleAppLifecycleStateChange(state, context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _inactivityService.resetTimer(context),
      onPanDown: (_) => _inactivityService.resetTimer(context),
      child: WalletGuruStateProvider(
        child: MaterialApp.router(
          routerConfig: router,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: AppColorSchema.of(context).primary,
            scaffoldBackgroundColor: AppColorSchema.of(context).scaffoldColor,
            cardColor: AppColorSchema.of(context).cardColor,
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: AppColorSchema.of(context).primary,
            ),
            bottomAppBarTheme: BottomAppBarTheme(
              color: AppColorSchema.of(context).scaffoldColor,
            ),
          ),
          color: AppColorSchema.of(context).primary,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
