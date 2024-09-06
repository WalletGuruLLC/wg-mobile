import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class ProfileOption extends StatelessWidget {
  final String optionTitle;
  final int profileOrder;

  const ProfileOption({
    super.key,
    required this.optionTitle,
    required this.profileOrder,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => GoRouter.of(context).pushNamed(Routes.myInfo.name),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: size.width * .08,
                child: _showAsset(profileOrder),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextBase(text: optionTitle, fontSize: 16),
              ),
            ],
          ),
          Divider(height: size.height * .06, thickness: .5),
        ],
      ),
    );
  }

  Widget _showAsset(int profileOrder) {
    // Depending on the profile order, return the correct asset
    switch (profileOrder) {
      case 1:
        return SvgPicture.asset(
          Assets.userIcon,
        );
      case 2:
        return SvgPicture.asset(
          Assets.settingsIcon,
        );
      case 3:
        return SvgPicture.asset(
          Assets.changePasswordIcon,
        );
      default:
        return SvgPicture.asset(
          Assets.lockedIcon,
        );
    }
  }
}
