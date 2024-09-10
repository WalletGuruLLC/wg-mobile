import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SecurityModal extends StatelessWidget {
  const SecurityModal({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context)!;
    final UserCubit userCubit = BlocProvider.of<UserCubit>(context);

    return BaseModal(
      isSucefull: false,
      content: Column(
        children: [
          SizedBox(height: size * 0.010),
          TextBase(
            textAlign: TextAlign.center,
            text: l10n.exitWithoutSaving,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColorSchema.of(context).secondaryText,
          ),
          SizedBox(height: size * 0.010),
          TextBase(
            textAlign: TextAlign.center,
            text: l10n.changesMayNotBeSaved,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColorSchema.of(context).secondaryText,
          ),
        ],
      ),
      hasDoubleButton: true,
      doubleButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
            width: Localizations.localeOf(context).languageCode == 'en'
                ? size * 0.12
                : size * 0.15,
            text: l10n.exit,
            onPressed: () {
              Navigator.of(context).pop();
              userCubit.resetInitialUser();
              GoRouter.of(context).pushNamed(
                Routes.myProfile.name,
              );
            },
          ),
          CustomButton(
            color: AppColorSchema.of(context).buttonTertiaryColor,
            buttonTextColor: Colors.black,
            width: Localizations.localeOf(context).languageCode == 'en'
                ? size * 0.12
                : size * 0.15,
            text: l10n.cancel,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
