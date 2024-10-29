import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class CreateProfileButtons extends StatelessWidget {
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;
  const CreateProfileButtons(
      {super.key, required this.onPressed1, required this.onPressed2});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          border: Border.all(
              color: AppColorSchema.of(context).secondaryButtonBorderColor),
          color: Colors.transparent,
          text: l10n.back,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          onPressed: onPressed1,
          width: width * 0.40,
        ),
        BlocConsumer<CreateProfileCubit, CreateProfileState>(
          listener: (context, state) {
            if (state.formStatusOne is SubmissionSuccess) {
              GoRouter.of(context).pushNamed(Routes.createProfile2.name);
              BlocProvider.of<CreateProfileCubit>(context).cleanFormStatusOne();
            } else if (state.formStatusTwo is SubmissionSuccess) {
              GoRouter.of(context).pushNamed(Routes.createProfile3.name);
              BlocProvider.of<CreateProfileCubit>(context).cleanFormStatusTwo();
            } else if (state.formStatusOne is SubmissionFailed ||
                state.formStatusTwo is SubmissionFailed) {
              buildErrorModal(
                state.customMessage,
                state.customMessageEs,
                state.customCode,
                locale,
                context,
              );
            }
          },
          builder: (context, state) {
            if (state.formStatusOne is FormSubmitting ||
                state.formStatusTwo is FormSubmitting ||
                state.formStatusThree is FormSubmitting) {
              return Center(
                child: Container(
                  width: width * 0.40,
                  height: 50, // Altura del botón
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              );
            } else if (state.formStatusOne is InitialFormStatus) {
              return CustomButton(
                border: Border.all(
                    color:
                        AppColorSchema.of(context).secondaryButtonBorderColor),
                color: Colors.transparent,
                text: l10n.next,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                width: width * 0.40,
                onPressed: onPressed2,
              );
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }

  Future<dynamic> buildErrorModal(
    String descriptionEn,
    String descriptionEs,
    String codeError,
    Locale locale,
    BuildContext context,
  ) {
    String description =
        locale.languageCode == 'en' ? descriptionEn : descriptionEs;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          content: Column(
            children: [
              SizedBox(height: size * 0.025),
              TextBase(
                textAlign: TextAlign.center,
                text: description,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.025),
              TextBase(
                textAlign: TextAlign.center,
                text: codeError,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            BlocProvider.of<CreateProfileCubit>(context).cleanFormStatusOne();
            BlocProvider.of<CreateProfileCubit>(context).cleanFormStatusTwo();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
