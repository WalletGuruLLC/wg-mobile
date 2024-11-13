import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/utils/screen_util.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

AppBar appBarLogoWidget(BuildContext context, bool kycAppBar) {
  bool smallScreen = ScreenUtils.isSmallScreen(context);

  final l10n = AppLocalizations.of(context)!;
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColorSchema.of(context).scaffoldColor,
    elevation: 0,
    title: kycAppBar
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: smallScreen ? 10 : 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.iconLogo,
                ),
                SizedBox(width: smallScreen ? 20 : 40),
                TextBase(
                  text: l10n.identityVerification,
                  fontSize: smallScreen ? 18 : 20,
                )
              ],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                Assets.iconLogo,
              ),
            ],
          ),
  );
}
