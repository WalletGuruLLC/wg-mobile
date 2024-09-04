import 'package:flutter/material.dart';

class Validators {
  static String? validateEmpty(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'Please enter the appropriate value';
    }
    return null;
  }

  static String? validateName(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    const pattern = r'^[a-zA-Z\s]+$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid';
    }
    return null;
  }

  static String? validateNumberId(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'Please enter your identification number';
    }
    const pattern = r'^\d{5,11}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid identification number';
    }
    return null;
  }

  static String? validateEmail(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    const pattern = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    const pattern =
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#\$&*~`%^&*()_+\-=\[\]{};:"\\|,.<>\/?]).{8,12}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Password must be 8-12 characters long and include at least one number, one uppercase letter, one lowercase letter, and one special character';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password,
      [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateMaxLength(String? value, int maxLength,
      [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'You must submit some information';
    }
    if (value.length > maxLength) {
      return 'The maximum message length is $maxLength words';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    const pattern = r'^[0-9]{10}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? validateSSN(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'Please enter your SSN number';
    }
    const pattern = r'^\d{9}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid SSN number XXX-XX-XXXX';
    }
    return null;
  }

  static String? validateOtp(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Otp number';
    }
    const pattern = r'^[0-9]{6}$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid Otp number';
    }
    return null;
  }

  static String? validateAddress(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    if (value.length < 3 || value.length > 20) {
      return 'Address must be between 3 and 20 characters long';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*\d)[a-z\d]+$').hasMatch(value)) {
      return 'Address must contain at least one letter, one number, and be entirely lowercase';
    }
    return null;
  }
}
