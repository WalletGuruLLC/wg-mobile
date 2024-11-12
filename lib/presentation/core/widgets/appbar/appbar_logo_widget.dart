import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

AppBar appBarLogoWidget(BuildContext context, bool kycAppBar) {
  final l10n = AppLocalizations.of(context)!;
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColorSchema.of(context).scaffoldColor,
    elevation: 0,
    title: kycAppBar
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  Assets.iconLogo,
                ),
                const SizedBox(width: 40),
                TextBase(
                  text: l10n.identityVerification,
                  fontSize: 20,
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
