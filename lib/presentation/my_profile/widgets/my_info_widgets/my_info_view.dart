import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/domain/core/entities/user_entity.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/address_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/city_form.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/form_label.dart';
import 'package:wallet_guru/presentation/core/widgets/forms/zip_code_form.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/activator_field_widget.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/country_section.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/phone_number_section.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/state_section.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_header.dart';

class MyInfoView extends StatefulWidget {
  const MyInfoView({super.key});

  @override
  State<MyInfoView> createState() => _MyInfoViewState();
}

class _MyInfoViewState extends State<MyInfoView> {
  late UserCubit userCubit;
  late UserEntity user;
  final _formKey = GlobalKey<FormState>();
  late CreateProfileCubit createProfileCubit;
  late String userName;
  late String userPhoneNumber;
  String imgURLHC =
      'https://pbs.twimg.com/profile_images/725013638411489280/4wx8EcIA_400x400.jpg';
  late String userZipCode;
  late String userAddress;
  late String userCountry;
  late String userStateLocation;
  late String userCity;

  bool readOnly = true;
  bool hasValuesChanged = false;

  String? currentPhoneNumber;
  String? currentZipCode;
  String? currentAddress;
  String? currentCountry;
  String? currentStateLocation;
  String? currentCity;

  @override
  void initState() {
    createProfileCubit = BlocProvider.of<CreateProfileCubit>(context);
    createProfileCubit.loadCountryCodeAndCountry();
    userCubit = BlocProvider.of<UserCubit>(context);
    user = userCubit.state.user!;
    userName = '${user.firstName} ${user.lastName}';
    userPhoneNumber = user.phone;
    userZipCode = user.zipCode;
    userAddress = user.address;
    userAddress = user.address;
    userCountry = user.country;
    userStateLocation = user.stateLocation;
    userCity = user.city;
    currentPhoneNumber = userPhoneNumber;
    currentZipCode = userZipCode;
    currentAddress = userAddress;
    currentCountry = userCountry;
    currentStateLocation = userStateLocation;
    currentCity = userCity;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double size = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: _buildMyInfoForm(size, l10n),
    );
  }

  Widget _buildMyInfoForm(
    double size,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileHeaderWidget(name: userName, avatarImage: imgURLHC),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.phoneNumber),
        PhoneNumberFormSection(
          initialValue: userPhoneNumber,
          readOnly: readOnly,
          onChanged: (value) {
            currentPhoneNumber = value;
            _checkValuesChanged();
          },
          fieldActivatorWidget: _buildFieldActivatorWidget(),
        ),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.country),
        CountryFormSection(
          initialValue: currentCountry,
          onChanged: (value) {
            currentCountry = value;
            currentStateLocation = null;
            _checkValuesChanged();
          },
        ),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.state),
        StateFormSection(
          initialValue: currentStateLocation,
          onChanged: (value) {
            print('value');
            print('value');
            print('value');
            print(value);
            currentStateLocation = value;
            currentCity = null;
            _checkValuesChanged();
          },
        ),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.city),
        BlocBuilder<CreateProfileCubit, CreateProfileState>(
          builder: (context, state) {
            return CityForm(
              initialValue: currentCity,
              enabled: state.stateLocation.isNotEmpty,
              items: state.cities.isNotEmpty ? state.cities : [''],
              onChanged: (value) {
                if (value != null) {
                  currentCity = value;
                  createProfileCubit.selectCity(value);
                  _checkValuesChanged();
                }
              },
            );
          },
        ),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.zipCode),
        ZipCodeForm(
          readOnly: readOnly,
          initialValue: userZipCode,
          onChanged: (value) {
            currentZipCode = value;
            _checkValuesChanged();
          },
          fieldActivatorWidget: _buildFieldActivatorWidget(),
        ),
        SizedBox(height: size * 0.015),
        FormLabel(label: l10n.address),
        AddressForm(
          readOnly: readOnly,
          initialValue: userAddress,
          onChanged: (value) {
            currentAddress = value;
            _checkValuesChanged();
          },
          fieldActivatorWidget: _buildFieldActivatorWidget(),
        ),
        SizedBox(height: size * 0.025),
        _buildSaveButton(hasValuesChanged),
      ],
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

  void _checkValuesChanged() {
    if (currentPhoneNumber != userPhoneNumber ||
        currentZipCode != userZipCode ||
        currentAddress != userAddress ||
        currentCountry != userCountry ||
        currentStateLocation != userStateLocation ||
        currentCity != userCity) {
      setState(() {
        hasValuesChanged = true;
      });
    }
  }

  Widget _buildSaveButton(
    bool hasValuesChanged,
  ) {
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
        print(currentCountry);
      },
    );
  }
}
