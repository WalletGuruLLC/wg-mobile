import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/address_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/zip_code_form.dart';
import 'package:wallet_guru/presentation/core/widgets/petition_response_modal.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/activator_field_widget.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/city_section.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/country_section.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/phone_number_section.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/save_button.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/state_section.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_widgets/profile_header.dart';

class MyInfoView extends StatefulWidget {
  const MyInfoView({super.key});

  @override
  State<MyInfoView> createState() => _MyInfoViewState();
}

class _MyInfoViewState extends State<MyInfoView> {
  late UserCubit userCubit;
  late CreateProfileCubit createProfileCubit;

  bool readOnly = true;

  @override
  void initState() {
    super.initState();
    createProfileCubit = BlocProvider.of<CreateProfileCubit>(context);
    createProfileCubit.loadCountryCodeAndCountry();
    userCubit = BlocProvider.of<UserCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionFailed) {
          final error = (state.formStatus as SubmissionFailed).exception;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        } else if (state.formStatus is SubmissionSuccess) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return _buildSuccessModal(context, l10n);
              });
        }
      },
      builder: (context, state) {
        final user = state.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeaderWidget(
              name: user?.fullName ?? '',
              avatarImage:
                  'https://pbs.twimg.com/profile_images/725013638411489280/4wx8EcIA_400x400.jpg',
            ),
            SizedBox(height: size * 0.015),
            FormLabel(label: l10n.phoneNumber),
            PhoneNumberFormSection(
              initialValue: user?.phone ?? '',
              readOnly: readOnly,
              onChanged: (value) {
                userCubit.updateUser(phone: value);
              },
              fieldActivatorWidget: _buildFieldActivatorWidget(),
            ),
            SizedBox(height: size * 0.015),
            FormLabel(label: l10n.country),
            CountryFormSection(
              initialValue: user?.country ?? '',
              onChanged: (value) {
                userCubit.updateUser(country: value);
              },
            ),
            SizedBox(height: size * 0.015),
            FormLabel(label: l10n.state),
            StateFormSection(
              initialValue: user?.stateLocation ?? '',
              onChanged: (value) {
                userCubit.updateUser(stateLocation: value);
              },
            ),
            SizedBox(height: size * 0.015),
            FormLabel(label: l10n.city),
            CityFormSection(
              initialValue: user?.city ?? '',
              onChanged: (value) {
                userCubit.updateUser(city: value);
              },
            ),
            SizedBox(height: size * 0.015),
            FormLabel(label: l10n.zipCode),
            ZipCodeForm(
              readOnly: readOnly,
              initialValue: user?.zipCode ?? '',
              onChanged: (value) {
                userCubit.updateUser(zipCode: value);
              },
              fieldActivatorWidget: _buildFieldActivatorWidget(),
            ),
            SizedBox(height: size * 0.015),
            FormLabel(label: l10n.address),
            AddressForm(
              readOnly: readOnly,
              initialValue: user?.address ?? '',
              onChanged: (value) {
                userCubit.updateUser(address: value);
              },
              fieldActivatorWidget: _buildFieldActivatorWidget(),
            ),
            SizedBox(height: size * 0.025),
            const SaveButton(),
          ],
        );
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
          GoRouter.of(context)
              .pushReplacementNamed(Routes.dashboardWallet.name);
        });
      },
    );
  }

  Widget _buildFieldActivatorWidget() {
    return ActivatorFieldWidget(
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
