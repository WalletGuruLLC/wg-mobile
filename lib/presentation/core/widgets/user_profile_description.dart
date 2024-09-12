import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/core/widgets/auth_login_divider.dart';

class UserProfileDescription extends StatelessWidget {
  const UserProfileDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AuthLoginDivider(),
        TextBase(
          text: l10n.userProfile,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: size * 0.005),
        TextBase(
          text: l10n.userProfileMessage,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
