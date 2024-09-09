import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class PetitionResponseModal extends StatelessWidget {
  final Locale locale;
  final bool isSuccessful;

  const PetitionResponseModal({
    super.key,
    required this.locale,
    required this.isSuccessful,
  });

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return BaseModal(
      isSucefull: isSuccessful,
      buttonWidth: locale.languageCode == 'en'
          ? MediaQuery.of(context).size.width * 0.40
          : MediaQuery.of(context).size.width * 0.42,
      content: Column(
        children: [
          SizedBox(height: size * 0.010),
          TextBase(
            textAlign: TextAlign.center,
            text: 'Your Profile is All Set!',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColorSchema.of(context).secondaryText,
          ),
          SizedBox(height: size * 0.010),
          TextBase(
            textAlign: TextAlign.center,
            text: 'Your profile is updated. Take a Look!',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColorSchema.of(context).secondaryText,
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context).pop(); // Cierra el modal

        Future.delayed(Duration(milliseconds: 100), () {
          BlocProvider.of<UserCubit>(context)
              .resetFormStatus(); // Resetea el estado del formulario
          GoRouter.of(context).pushReplacementNamed(
              Routes.dashboardWallet.name); // Navega a la nueva ruta
        });
      },
    );
  }
}
