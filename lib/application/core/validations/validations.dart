import 'package:flutter/material.dart';

class Validators {
  static String? validateName(String? value, [BuildContext? context]) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
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
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
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
}
