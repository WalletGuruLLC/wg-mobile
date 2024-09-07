import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';

import 'package:wallet_guru/presentation/my_profile/widgets/profile_header.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_logout.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_options.dart';

class MyProfileMainView extends StatelessWidget {
  const MyProfileMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    final userFullName =
        BlocProvider.of<UserCubit>(context).state.user!.fullName;
    String imgURL =
        'https://pbs.twimg.com/profile_images/725013638411489280/4wx8EcIA_400x400.jpg';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProfileHeaderWidget(name: userFullName, avatarImage: imgURL),
        SizedBox(height: size.height * .1),
        ProfileOption(
          optionTitle: l10n.myInfo,
          profileOrder: 1,
        ),
        ProfileOption(
          optionTitle: l10n.notificationSettings,
          profileOrder: 2,
        ),
        ProfileOption(
          optionTitle: l10n.changePassword,
          profileOrder: 3,
        ),
        ProfileOption(
          optionTitle: l10n.lockAccount,
          profileOrder: 4,
        ),
        SizedBox(height: size.height * .065),
        LogoutButton(
          text: l10n.logOut,
        )
      ],
    );
  }
}
