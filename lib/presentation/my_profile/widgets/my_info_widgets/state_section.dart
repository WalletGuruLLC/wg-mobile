import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/state_form.dart';

class StateFormSection extends StatelessWidget {
  final String? initialValue;
  final void Function(String?) onChanged;

  const StateFormSection({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileCubit, CreateProfileState>(
      builder: (context, state) {
        final createProfileCubit = context.read<CreateProfileCubit>();
        return StateForm(
          initialValue: initialValue,
          enabled: state.states.isNotEmpty,
          items: state.states.isNotEmpty ? state.states : [''],
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
              createProfileCubit.selectState(value);
            }
          },
        );
      },
    );
  }
}

class StateFormSection2 extends StatelessWidget {
  final String? initialValue;
  final void Function(String?) onChanged;

  const StateFormSection2({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileCubit, CreateProfileState>(
      builder: (context, state) {
        final createProfileCubit = context.read<CreateProfileCubit>();
        return StateForm(
          initialValue: initialValue,
          items: state.states.isNotEmpty ? state.states : [''],
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
              createProfileCubit.selectState(value);
            }
          },
        );
      },
    );
  }
}
