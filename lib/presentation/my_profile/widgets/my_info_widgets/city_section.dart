import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/city_form.dart';

class CityFormSection extends StatelessWidget {
  final String? initialValue;
  final void Function(String?) onChanged;

  const CityFormSection({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileCubit, CreateProfileState>(
      builder: (context, state) {
        final createProfileCubit = context.read<CreateProfileCubit>();
        return CityForm(
          enabled: state.cities.isNotEmpty,
          initialValue: initialValue,
          items: state.countries,
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
              createProfileCubit.selectCity(value);
            }
          },
        );
      },
    );
  }
}
