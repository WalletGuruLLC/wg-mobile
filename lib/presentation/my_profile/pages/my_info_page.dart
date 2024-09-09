// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/my_info_view.dart';

class MyInfoPage extends StatelessWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final l10n = AppLocalizations.of(context)!;

    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showSafeArea: true,
      showAppBar: true,
      showBottomNavigationBar: true,
      pageAppBarTitle: 'My info',
      children: [
        SizedBox(
          width: size.width * 0.90,
          height: size.height,
          child: const MyInfoView(),
        ),
      ],
    );
  }
}
