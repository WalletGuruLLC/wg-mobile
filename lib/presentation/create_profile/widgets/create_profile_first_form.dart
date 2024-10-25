import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/application/register/register_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/progress_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/last_name_form.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/first_name_form.dart';
import 'package:wallet_guru/presentation/core/widgets/create_profile_buttons.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/phone_number_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/country_code_form.dart';
import 'package:wallet_guru/presentation/core/widgets/user_profile_description.dart';
import 'package:flutter_idensic_mobile_sdk_plugin/flutter_idensic_mobile_sdk_plugin.dart';

class CreateProfileFirstForm extends StatefulWidget {
  const CreateProfileFirstForm({
    super.key,
    required this.id,
    required this.email,
  });

  final String id;
  final String email;

  @override
  State<CreateProfileFirstForm> createState() => CreateProfileFirstFormState();
}

class CreateProfileFirstFormState extends State<CreateProfileFirstForm> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  late CreateProfileCubit createProfileCubit;
  late String _sumSubToken;
  late String _sumSubUserId;

  @override
  void initState() {
    BlocProvider.of<LoginCubit>(context).cleanFormStatus();

    BlocProvider.of<RegisterCubit>(context).initialStatus();
    createProfileCubit = BlocProvider.of<CreateProfileCubit>(context);
    _sumSubToken = createProfileCubit.state.sumSubToken;
    _sumSubUserId = createProfileCubit.state.sumSubUserId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: _buildProfileBasicInfoView(
        size,
        context,
        l10n,
      ),
    );
  }

  Widget _buildProfileBasicInfoView(
      double size, BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const UserProfileDescription(),
          const ProgressBar(currentStep: 1),
          SizedBox(height: size * 0.030),
          FormLabel(label: l10n.firstName),
          FirstNameForm(
            initialValue: _firstName,
            onChanged: (value) => _onFormChanged('firstName', value),
          ),
          const SizedBox(height: 30),
          FormLabel(label: l10n.lastName),
          LastNameForm(
            initialValue: _lastName,
            onChanged: (value) => _onFormChanged('lastName', value),
          ),
          const SizedBox(height: 30),
          FormLabel(label: l10n.phoneNumber),
          SizedBox(
            //width: size * 0.9,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<CreateProfileCubit, CreateProfileState>(
                  builder: (context, state) {
                    final uniqueCountriesCode =
                        state.countriesCode.toSet().toList();
                    return CountryCodeFormAutoComplete(
                      initialValue: '+00',
                      items: uniqueCountriesCode,
                      onChanged: (value) {
                        if (value != null) {
                          createProfileCubit.selectCountryCode(value);
                        }
                      },
                    );
                    // return CountryCodeForm(
                    //   items: uniqueCountriesCode,
                    //   onChanged: (value) {
                    //     if (value != null) {
                    //       createProfileCubit.selectCountryCode(value);
                    //     }
                    //   },
                    // );
                  },
                ),
                Expanded(
                  child: PhoneNumberForm(
                    initialValue: _phoneNumber,
                    onChanged: (value) => _onFormChanged('phoneNumber', value),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size * 0.12),
          CreateProfileButtons(
            onPressed1: _onBackButtonPressed,
            onPressed2: _onNextButtonPressed,
          ),
          const SizedBox(height: 10),
          BlocBuilder<CreateProfileCubit, CreateProfileState>(
            builder: (context, state) {
              if (state.formStatusGetToken is FormSubmitting) {
                return const CircularProgressIndicator();
              } else if (state.formStatusGetToken is SubmissionFailed) {
                return Text(state.customMessage);
              }
              return CustomButton(
                onPressed: () =>
                    launchSDK(state.sumSubToken, state.sumSubUserId),
                text: 'Verify Identity',
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> launchSDK(String accessToken, String userId) async {
    final onTokenExpiration = () async {
      // Lógica para obtener un nuevo token de tu backend
      //TODO: IMPLEMENTAR CASO DE USO PARA OBTENER UN NUEVO TOKEN
      return Future<String>.delayed(
          Duration(seconds: 2), () => "your new access token");
    };

    final SNSStatusChangedHandler onStatusChanged =
        (SNSMobileSDKStatus newStatus, SNSMobileSDKStatus prevStatus) {
      print("The SDK status was changed: $prevStatus -> $newStatus");
    };

    final snsMobileSDK = SNSMobileSDK.init(accessToken, onTokenExpiration)
        .withHandlers(
          onStatusChanged: onStatusChanged,
        )
        .withDebug(true)
        .withLocale(Locale("en"))
        .build();

    final SNSMobileSDKResult result = await snsMobileSDK.launch();

    print("Completed with result: $result");
  }

  void _onFormChanged(String formType, String? value) {
    setState(() {
      switch (formType) {
        case 'firstName':
          _firstName = value!;
          createProfileCubit.setUserFirstName(_firstName);
          break;
        case 'lastName':
          _lastName = value!;
          createProfileCubit.setUserLastName(_lastName);
          break;
        case 'phoneNumber':
          _phoneNumber = value!;
          createProfileCubit.setUserPhone(_phoneNumber);
          break;
      }
    });
  }

  void _onBackButtonPressed() {
    Navigator.of(context).pop();
  }

  // Method to handle button actions
  void _onNextButtonPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      GoRouter.of(context).pushNamed(Routes.createProfile2.name);
    }
  }
}
