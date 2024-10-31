import 'package:flutter/material.dart';

import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/create_profile/widgets/create_profile_second_form.dart';

class CreateProfile2Page extends StatelessWidget {
  final String? id;
  final String? email;
  const CreateProfile2Page({this.id, this.email, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showSafeArea: true,
      showNotLoggedAppBar: true,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SizedBox(
            width: size.width * 0.90,
            height: size.height,
            child: CreateProfile2Form(id: id, email: email),
          ),
        ),
      ],
    );
  }
}
