import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/core/state_provider.dart';
import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/infrastructure/core/routes/router_provider.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

void main() {
  Injector.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WalletGuruStateProvider(
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
    );
  }
}
