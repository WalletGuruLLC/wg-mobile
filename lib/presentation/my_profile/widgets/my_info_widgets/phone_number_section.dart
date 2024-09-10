import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/country_code_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/phone_number_form.dart';

class PhoneNumberFormSection extends StatelessWidget {
  final String codeInitialValue;
  final String phoneInitialValue;
  final bool readOnly;
  final void Function(String?) onChanged;
  final Widget fieldActivatorWidget;

  const PhoneNumberFormSection({
    required this.phoneInitialValue,
    required this.codeInitialValue,
    required this.readOnly,
    required this.onChanged,
    required this.fieldActivatorWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<CreateProfileCubit, CreateProfileState>(
          builder: (context, state) {
            final uniqueCountriesCode = state.countriesCode.toSet().toList();
            String adjustedCodeInitialValue =
                uniqueCountriesCode.contains(codeInitialValue)
                    ? codeInitialValue
                    : uniqueCountriesCode.isNotEmpty
                        ? uniqueCountriesCode.first
                        : '';

            return CountryCodeForm(
              initialValue: adjustedCodeInitialValue,
              items: uniqueCountriesCode,
              onChanged: (value) {
                if (value != null) {
                  BlocProvider.of<UserCubit>(context)
                      .updateUser(phoneCode: value);
                  BlocProvider.of<CreateProfileCubit>(context)
                      .selectCountryCode(value);
                  onChanged(value);
                }
              },
            );
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: PhoneNumberForm(
              readOnly: readOnly,
              initialValue: phoneInitialValue,
              onChanged: onChanged,
              fieldActivatorWidget: fieldActivatorWidget,
            ),
          ),
        ),
      ],
    );
  }
}
