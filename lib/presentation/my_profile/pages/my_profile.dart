import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WalletGuruLayout(
      showSafeArea: true,
      showAppBar: true,
      showBottomNavigationBar: true,
      pageAppBarTitle: 'My Profile',
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

class MyProfileMainView extends StatelessWidget {
  const MyProfileMainView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String name = 'John Doe';
    String imgURL =
        'https://pbs.twimg.com/profile_images/725013638411489280/4wx8EcIA_400x400.jpg';
    return Padding(
      padding: EdgeInsets.only(top: size.height * .015),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildProfileHeaderWidget(size, name: name, avatarImage: imgURL),
          SizedBox(height: size.height * .1),
          _buildTileOption(
            size,
            optionTitle: 'My Info',
            assetPath: Assets.userIcon,
          ),
          _buildTileOption(
            size,
            optionTitle: 'Notification Settings',
            assetPath: Assets.settingsIcon,
          ),
          _buildTileOption(
            size,
            optionTitle: 'Change Password',
            assetPath: Assets.changePasswordIcon,
          ),
          _buildTileOption(
            size,
            optionTitle: 'Lock Account',
            assetPath: Assets.lockedIcon,
          ),
          SizedBox(height: size.height * .065),
          _buildLogoutButton(size),
        ],
      ),
    );
  }

  Widget _buildTileOption(
    Size size, {
    required String optionTitle,
    required String assetPath,
  }) {
    return Column(
      children: [
        Row(children: [
          SizedBox(
            width: size.width * .08,
            child: SvgPicture.asset(assetPath),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextBase(text: optionTitle, fontSize: 16)),
        ]),
        Divider(height: size.height * .06, thickness: .5),
      ],
    );
  }

  Widget _buildProfileHeaderWidget(
    Size size, {
    required name,
    required String avatarImage,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextBase(text: 'John Doe'),
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

  Widget _buildLogoutButton(Size size) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          SizedBox(
            width: size.width * .08,
            child: SvgPicture.asset(Assets.logoutIcon),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextBase(text: 'Log Out', fontSize: 16),
          ),
        ],
      ),
    );
  }
}
