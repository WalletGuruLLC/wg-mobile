class GlobalErrorTranslations {
  static Map<String, String> errorMessages = {};

  static void updateTranslations(Map<String, String> newTranslations) {
    errorMessages = newTranslations;
  }

  static String getErrorMessage(String errorCode) {
    return errorMessages[errorCode] ?? 'Unknown error';
  }
}
