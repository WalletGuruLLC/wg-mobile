import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/address_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/zip_code_form.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/petition_response_modal.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/save_button.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_widgets/profile_header.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/phone_number_section.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/activator_field_widget.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/city_form_auto_complete.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/country_form_auto_complete.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/state_form_auto_complete.dart';

class MyInfoView extends StatefulWidget {
  const MyInfoView({super.key});

  @override
  State<MyInfoView> createState() => _MyInfoViewState();
}

class _MyInfoViewState extends State<MyInfoView> {
  final _formKey = GlobalKey<FormState>();
  late UserCubit userCubit;
  late CreateProfileCubit createProfileCubit;

  bool readOnly = true;

  @override
  void initState() {
    super.initState();
    userCubit = BlocProvider.of<UserCubit>(context);
    createProfileCubit = BlocProvider.of<CreateProfileCubit>(context);
    createProfileCubit.loadCountryCodeAndCountry();
    createProfileCubit.selectCountry(userCubit.state.initialUser!.country);
    createProfileCubit.selectState(userCubit.state.initialUser!.country);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionSuccess) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return _buildSuccessModal(context, l10n);
              });
        }
      },
      builder: (context, state) {
        if (state.getCurrentUserInformationStatus is FormSubmitting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final user = state.user;
          final initialUser = state.initialUser;
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileHeaderWidget(
                  isOnTapAvailable: true,
                ),
                SizedBox(height: size * 0.015),
                FormLabel(label: l10n.phoneNumber),
                if (state.user!.phoneCode.isNotEmpty)
                  PhoneNumberFormSection(
                    codeInitialValue: user!.phoneCode,
                    phoneInitialValue: user!.phone ?? '',
                    readOnly: readOnly,
                    onPhoneChanged: (value) {
                      userCubit.updateUser(phone: value);
                    },
                    onCodeChanged: (value) {
                      userCubit.updateUser(phoneCode: value);
                    },
                    fieldActivatorWidget: _buildFieldActivatorWidget(true),
                  ),
                SizedBox(height: size * 0.015),
                FormLabel(label: l10n.country),
                CountryFormAutoComplete(
                    readOnly: readOnly,
                    fieldActivatorWidget: _buildFieldActivatorWidget(true),
                    initialValue: user?.country,
                    onChanged: (value) {
                      userCubit.updateUser(
                          country: value, stateLocation: '', city: '');
                    }),
                SizedBox(height: size * 0.015),
                FormLabel(label: l10n.state),
                if (user?.stateLocation == initialUser?.stateLocation &&
                    initialUser?.stateLocation != '' &&
                    initialUser?.stateLocation != null &&
                    initialUser!.stateLocation.isNotEmpty)
                  StateFormAutoComplete(
                    readOnly: readOnly,
                    fieldActivatorWidget: _buildFieldActivatorWidget(true),
                    initialValue: user?.stateLocation ?? '',
                    onChanged: (value) {
                      userCubit.updateUser(stateLocation: value, city: '');
                    },
                  ),
                if (user?.stateLocation != initialUser?.stateLocation)
                  StateFormAutoComplete(
                    readOnly: readOnly,
                    fieldActivatorWidget: _buildFieldActivatorWidget(true),
                    initialValue: user?.stateLocation ?? '',
                    onChanged: (value) {
                      userCubit.updateUser(stateLocation: value, city: '');
                    },
                  ),
                SizedBox(height: size * 0.015),
                FormLabel(label: l10n.city),
                if (user?.city == initialUser?.city &&
                    initialUser?.city != '' &&
                    initialUser?.city != null &&
                    initialUser!.city.isNotEmpty)
                  CityFormAutocomplete(
                    readOnly: readOnly,
                    initialValue: initialUser?.city ?? '',
                    onChanged: (value) {
                      userCubit.updateUser(city: value);
                    },
                    fieldActivatorWidget: _buildFieldActivatorWidget(true),
                  ),
                if (user?.city != initialUser?.city)
                  CityFormAutocomplete(
                    readOnly: readOnly,
                    initialValue: user?.city ?? '',
                    onChanged: (value) {
                      userCubit.updateUser(city: value);
                    },
                    fieldActivatorWidget: _buildFieldActivatorWidget(true),
                  ),
                SizedBox(height: size * 0.015),
                FormLabel(label: l10n.zipCode),
                ZipCodeForm(
                  readOnly: readOnly,
                  initialValue: user?.zipCode ?? '',
                  onChanged: (value) {
                    userCubit.updateUser(zipCode: value);
                  },
                  fieldActivatorWidget: _buildFieldActivatorWidget(true),
                ),
                SizedBox(height: size * 0.015),
                FormLabel(label: l10n.address),
                AddressForm(
                  readOnly: readOnly,
                  initialValue: user?.address ?? '',
                  onChanged: (value) {
                    userCubit.updateUser(address: value);
                  },
                  fieldActivatorWidget: _buildFieldActivatorWidget(true),
                ),
                SizedBox(height: size * 0.025),
                SaveButton(
                  formKey: _formKey,
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildSuccessModal(BuildContext context, AppLocalizations l10n) {
    return PetitionResponseModal(
      locale: Localizations.localeOf(context),
      isSuccessful: true,
      title: l10n.profileChangedSuccess,
      content: l10n.profileChangedSuccessBody,
      onPressed: () {
        Navigator.of(context).pop();
        Future.delayed(const Duration(milliseconds: 100), () {
          BlocProvider.of<UserCubit>(context).resetFormStatus();
          GoRouter.of(context).pushReplacementNamed(Routes.home.name);
        });
      },
    );
  }

  Widget _buildFieldActivatorWidget(bool isIconPencil) {
    return ActivatorFieldWidget(
      isIconPencil: isIconPencil,
      onTap: () {
        if (readOnly) {
          setState(() {
            readOnly = !readOnly;
          });
        }
      },
    );
  }
}
