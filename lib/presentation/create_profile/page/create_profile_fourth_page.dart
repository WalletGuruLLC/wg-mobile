import 'package:flutter/material.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/create_profile/widgets/create_profile_fourth_form.dart';

class CreateProfileFourthPage extends StatelessWidget {
  final String? id;
  final String? email;
  const CreateProfileFourthPage({super.key, this.id, this.email});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: WalletGuruLayout(
        showSafeArea: true,
        showNotLoggedAppBar: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SizedBox(
              width: size.width * 0.90,
              height: size.height,
              child: CreateProfileFourthForm(id: id, email: email),
            ),
          ),
        ],
      ),
    );
  }
}
