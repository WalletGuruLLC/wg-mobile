import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String avatarImage;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextBase(text: name),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: size.height * .1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                avatarImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
