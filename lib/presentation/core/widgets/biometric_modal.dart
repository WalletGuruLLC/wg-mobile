// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guru/application/register/register_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/router_provider.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class BiometricModal extends StatelessWidget {
  final bool? isUserLogged;
  final String? email;
  const BiometricModal({
    super.key,
    this.isUserLogged = false,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;
    return BaseModal(
      hasDoubleButton: true,
      hasActions: true,
      isSucefull: true,
      content: Column(
        children: [
          SizedBox(height: size * 0.020),
          TextBase(
            textAlign: TextAlign.center,
            text: l10n.biometricAccessTitle,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColorSchema.of(context).secondaryText,
          ),
          SizedBox(height: size * 0.010),
          TextBase(
            textAlign: TextAlign.center,
            text: l10n.biometricAccessText,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColorSchema.of(context).secondaryText,
          ),
        ],
      ),
      doubleButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
            width: size * 0.1,
            text: l10n.yes,
            onPressed: () async {
              final storage = await SharedPreferences.getInstance();
              storage.setBool('isBiometricAvailable', true);

              BlocProvider.of<RegisterCubit>(navigatorKey.currentContext!)
                  .cleanFormStatus();
              Navigator.of(navigatorKey.currentContext!).pop();
              isUserLogged == true
                  ? GoRouter.of(navigatorKey.currentContext!)
                      .pushReplacementNamed(Routes.myProfile.name)
                  : GoRouter.of(navigatorKey.currentContext!)
                      .pushNamed(Routes.doubleFactorAuth.name, extra: email);
            },
          ),
          CustomButton(
            color: AppColorSchema.of(context).buttonTertiaryColor,
            buttonTextColor: Colors.black,
            width: size * 0.1,
            text: 'No',
            onPressed: () async {
              Navigator.of(context).pop();
              BlocProvider.of<RegisterCubit>(context).cleanFormStatus();
              final storage = await SharedPreferences.getInstance();
              storage.setBool('isBiometricAvailable', false);
              isUserLogged == true
                  ? GoRouter.of(navigatorKey.currentContext!)
                      .pushNamed(Routes.myProfile.name)
                  : GoRouter.of(navigatorKey.currentContext!)
                      .pushNamed(Routes.doubleFactorAuth.name, extra: email);
            },
          ),
        ],
      ),
    );
  }
}
