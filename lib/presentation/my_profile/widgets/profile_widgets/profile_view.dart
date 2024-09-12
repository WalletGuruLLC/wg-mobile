import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';

import 'package:wallet_guru/presentation/my_profile/widgets/profile_widgets/profile_header.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_widgets/profile_logout.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_widgets/profile_options.dart';

class MyProfileMainView extends StatelessWidget {
  const MyProfileMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.resetInitialUser();
    userCubit.resetFormStatus();
    userCubit.resetFormStatusLockAccount();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ProfileHeaderWidget(),
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
