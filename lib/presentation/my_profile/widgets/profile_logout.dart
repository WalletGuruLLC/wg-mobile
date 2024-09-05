import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const LogoutButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: size.width * .08,
            child: SvgPicture.asset(Assets.logoutIcon),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextBase(text: text, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
