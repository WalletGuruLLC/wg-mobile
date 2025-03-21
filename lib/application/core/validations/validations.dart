import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Validators {
  static Future<RegExp> getDynamicRegExpForWallet() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final urlWallet = sharedPreferences.getString('urlWallet');
    final escapedUrlWallet = RegExp.escape(urlWallet!);
    return RegExp(r'^' + escapedUrlWallet + r'\/[a-zA-Z0-9]{4,}$');
  }

  static Future<bool> validateWalletUrl(String? value) async {
    if (value == null || value.isEmpty) {
      return false;
    }

    final regExp = await getDynamicRegExpForWallet();
    return regExp.hasMatch(value);
  }

  static String? validateEmpty(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);

    if (value == null || value.isEmpty) {
      return l10n!.pleaseSelectGenericValue;
    }
    return null;
  }

  static String? validateName(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.nameValidation;
    }
    const pattern = r'^[a-zA-Z\s]+$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return l10n!.nameValidation;
    }
    return null;
  }

  static String? validateLastName(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.lastNameValidation;
    }
    const pattern = r'^[a-zA-Z\s]+$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return l10n!.lastNameValidation;
    }
    return null;
  }

  static String? validateNumberId(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.enterIdNumberValidation;
    }
    const pattern = r'^\d{5,11}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return l10n!.enterValidIdNumberValidation;
    }
    return null;
  }

  static String? validateEmail(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);

    if (value == null || value.isEmpty) {
      return l10n!.enterEmailValidation;
    }

    // Regex con todas las reglas
    const pattern =
        r"^(?!.*\.{2})[a-zA-Z0-9!#$%&'*+/=?^_`{|}~.-]{1,64}@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$";
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value) || value.length > 254) {
      return l10n!.enterValidEmailValidation;
    }

    // Validaciones adicionales
    final parts = value.split('@');
    if (parts.length != 2) return l10n!.enterValidEmailValidation;

    final localPart = parts[0];
    final domainPart = parts[1];

    // La parte local no debe iniciar o terminar con un punto.
    if (localPart.startsWith('.') || localPart.endsWith('.')) {
      return l10n!.enterValidEmailValidation;
    }

    // El dominio no debe iniciar o terminar con un punto.
    if (domainPart.startsWith('.') || domainPart.endsWith('.')) {
      return l10n!.enterValidEmailValidation;
    }
    return null;
  }

  static String? validatePassword(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.enterPasswordValidation;
    }
    const pattern =
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#\$&*~`%^&*()_+\-=\[\]{};:"\\|,.<>\/?]).{8,12}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return l10n!.enterValidPasswordValidation;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password,
      [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.enterConfirmPassword;
    }
    if (value != password) {
      return l10n!.enterValidConfirmPassword;
    }
    return null;
  }

  static String? validatePhoneNumber(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.enterPhoneNumber;
    }
    const pattern = r'^[0-9]{8,}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return l10n!.enterValidPhoneNumber;
    }
    return null;
  }

  static String? validateSSN(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.enterSSN;
    }
    const pattern = r'^\d{3}-\d{2}-\d{4}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return l10n!.enterValidSSN;
    }
    return null;
  }

  static String? validateOtp(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.enterOTP;
    }
    const pattern = r'^[0-9]{6}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return l10n!.enterValidOTP;
    }
    return null;
  }

  static String? validateWalletAddress(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.enterWalletAddress;
    }
    if (value.length < 3 || value.length > 20) {
      return l10n!.enterMinLengthWalletAddress;
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*\d)[a-z\d]+$').hasMatch(value)) {
      return l10n!.enterValidWalletAddress;
    }
    return null;
  }

  static String? validateAddress(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.enterAddress;
    }
    if (value.length < 4) {
      return l10n!.enterValidAddress;
    }
    const pattern = r'^[a-zA-Z0-9\s,.\-#/&]+$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return l10n!.enterValidAddress;
    }
    const specialCharsPattern = r'[#/&.,\s\-]{3,}';
    final specialCharsRegex = RegExp(specialCharsPattern);
    if (specialCharsRegex.hasMatch(value)) {
      return l10n!.enterValidAddress;
    }
    return null;
  }

  static String? validateZipCode(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.enterZipCode;
    }
    if (value.length < 3) {
      return l10n!.enterValidZipCode;
    }
    const pattern = r'^[a-zA-Z0-9]+$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return l10n!.enterValidZipCode;
    }
    return null;
  }

  static String? validateEmptyDate(String? value, [BuildContext? context]) {
    final l10n = AppLocalizations.of(context!);
    if (value == null || value.isEmpty) {
      return l10n!.selectBirthDateValidation;
    }
    return null;
  }
}
