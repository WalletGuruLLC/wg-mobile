import 'package:flutter/material.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/core/widgets/appbar/appbar_logo_widget.dart';
import 'package:wallet_guru/presentation/create_profile/widgets/create_profile_second_form.dart';

class CreateProfileSecondPage extends StatelessWidget {
  const CreateProfileSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showSafeArea: true,
      appBar: appBarLogoWidget(context),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SizedBox(
            width: size.width * 0.90,
            height: size.height,
            child: const CreateProfileSecondForm(),
          ),
        ),
      ],
    );
  }
}
