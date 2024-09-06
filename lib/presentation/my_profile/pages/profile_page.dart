import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_view.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showSafeArea: true,
      showAppBar: true,
      showBottomNavigationBar: true,
      pageAppBarTitle: l10n.myProfile,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SizedBox(
            width: size.width * 0.90,
            height: size.height,
            child: const MyProfileMainView(),
          ),
        ),
      ],
    );
  }
}
