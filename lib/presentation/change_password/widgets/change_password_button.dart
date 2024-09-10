import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/widgets/petition_response_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

class ChangePasswordButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const ChangePasswordButton({
    super.key,
    required this.formKey,
  });

  @override
  State<ChangePasswordButton> createState() => _ChangePasswordButtonState();
}

class _ChangePasswordButtonState extends State<ChangePasswordButton> {
  late UserCubit userCubit;

  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
  }

  @override
  void dispose() {
    userCubit.resetFormStatus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionSuccess) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String description = locale.languageCode == 'en'
                  ? state.customMessage
                  : state.customMessageEs;
              return PetitionResponseModal(
                locale: locale,
                isSuccessful: true,
                onPressed: () {
                  userCubit.resetFormStatus();
                  Navigator.of(context).pop();
                  GoRouter.of(context).pushReplacementNamed(
                    Routes.dashboardWallet.name,
                  );
                },
                title: l10n.changeSuccessful,
                content: description,
              );
            },
          );
        } else if (state.formStatus is SubmissionFailed) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String description = locale.languageCode == 'en'
                  ? state.customMessage
                  : state.customMessageEs;
              return PetitionResponseModal(
                locale: locale,
                isSuccessful: false,
                onPressed: () {
                  Navigator.of(context).pop();
                  userCubit.resetFormStatus();
                },
                title: l10n.changeFailure,
                content: description,
                errorCode: 'Error code: ${state.customCode}',
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state.formStatus is FormSubmitting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return CustomButton(
            border: Border.all(
              color: !state.isSubmittable
                  ? AppColorSchema.of(context).secondaryButtonBorderColor
                  : Colors.transparent,
            ),
            color: !state.isSubmittable
                ? Colors.transparent
                : AppColorSchema.of(context).buttonColor,
            text: l10n.title_register,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            onPressed: state.isSubmittable
                ? () => _onButtonPressed(context, userCubit)
                : null,
          );
        }
      },
    );
  }

  void _onButtonPressed(BuildContext context, UserCubit userCubit) {
    final isValid = widget.formKey.currentState?.validate() ?? false;
    if (isValid) {
      userCubit.emitChangePassword();
    }
  }
}
