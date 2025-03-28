import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/create_profile/widgets/create_profile_first_form.dart';

class CreateProfileFirstPage extends StatelessWidget {
  const CreateProfileFirstPage({
    super.key,
    required this.id,
    required this.email,
  });
  final String id;
  final String email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: WalletGuruLayout(
        kycAppBar: true,
        showSafeArea: true,
        showNotLoggedAppBar: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SizedBox(
              width: size.width * 0.85,
              height: size.height * 0.7,
              child: CreateProfileFirstForm(
                id: id,
                email: email,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
