import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        bool hasValuesChanged = state.userHasChanged;
        if (state.formStatus is FormSubmitting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return CustomButton(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            borderRadius: 12,
            color: hasValuesChanged
                ? AppColorSchema.of(context).buttonColor
                : Colors.transparent,
            border: Border.all(
                width: hasValuesChanged ? 0 : .75,
                color: hasValuesChanged ? Colors.transparent : Colors.white),
            text: 'Save',
            onPressed: () {
              if (hasValuesChanged) {
                context.read<UserCubit>().submitUserChanges();
              }
            },
          );
        }
      },
    );
  }
}
