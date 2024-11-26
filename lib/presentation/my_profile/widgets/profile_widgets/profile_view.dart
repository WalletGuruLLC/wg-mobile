import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';

import 'package:wallet_guru/presentation/my_profile/widgets/profile_widgets/profile_header.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_widgets/profile_logout.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_widgets/profile_options.dart';

class MyProfileMainView extends StatefulWidget {
  const MyProfileMainView({super.key});

  @override
  State<MyProfileMainView> createState() => _MyProfileMainViewState();
}

class _MyProfileMainViewState extends State<MyProfileMainView> {
  late UserCubit userCubit;
  late bool isBiometricAvailable;

  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.resetInitialUser();
    userCubit.resetFormStatus();
    userCubit.resetFormStatusLockAccount();
    _getIsBiometricAvailable();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
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
              isBiometricAvailable: isBiometricAvailable,
              optionTitle: isBiometricAvailable
                  ? l10n.deactivateBiometrics
                  : l10n.activateBiometrics,
              profileOrder: 2,
            ),
            ProfileOption(
              optionTitle: l10n.changePassword,
              profileOrder: 3,
            ),
            ProfileOption(
              optionTitle: state.wallet!.walletDb.active
                  ? l10n.lockWallet
                  : l10n.unLockWallet,
              profileOrder: 4,
            ),
            SizedBox(height: size.height * .065),
            LogoutButton(
              text: l10n.logOut,
            ),
          ],
        );
      },
    );
  }

  Future<void> _getIsBiometricAvailable() async {
    final storage = await SharedPreferences.getInstance();
    bool? isBiometricAvailable = storage.getBool('isBiometricAvailable');
    setState(() {
      this.isBiometricAvailable = isBiometricAvailable ?? false;
    });
  }
}
