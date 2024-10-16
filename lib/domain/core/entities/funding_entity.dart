class FundingEntity {
  final String amountToAddFund;
  final String rafikiWalletAddress;
  final String walletAddressUrl;
  String? sessionId;

  FundingEntity({
    required this.amountToAddFund,
    required this.rafikiWalletAddress,
    required this.walletAddressUrl,
    this.sessionId,
  }) {
    sessionId ??= extractSessionIdFromUrl(walletAddressUrl);
  }

  FundingEntity copyWith({
    String? amountToAddFund,
    String? rafikiWalletAddress,
    String? walletAddressUrl,
    String? sessionId,
  }) {
    return FundingEntity(
      amountToAddFund: amountToAddFund ?? this.amountToAddFund,
      rafikiWalletAddress: rafikiWalletAddress ?? this.rafikiWalletAddress,
      walletAddressUrl: walletAddressUrl ?? this.walletAddressUrl,
      sessionId: sessionId ??
          extractSessionIdFromUrl(walletAddressUrl ?? this.walletAddressUrl),
    );
  }

  FundingEntity.empty()
      : amountToAddFund = '',
        rafikiWalletAddress = '',
        walletAddressUrl = '',
        sessionId = '';

  Map<String, dynamic> toMap() => {
        "amountToAddFund": amountToAddFund,
        "rafikiWalletAddress": rafikiWalletAddress,
        "walletAddressUrl": walletAddressUrl,
        "sessionId": sessionId,
      };

  // Método para extraer el sessionId de la URL (ahora es público)
  static String? extractSessionIdFromUrl(String url) {
    Uri uri = Uri.parse(url);
    return uri.queryParameters['sessionId'];
  }

  String getWalletAddressWithoutQueryParams() {
    Uri uri = Uri.parse(walletAddressUrl);
    return uri.origin + uri.path;
  }

  dynamic convertAmountToNumber() {
    // Eliminar signos de dólar y convertir comas en puntos solo si no hay puntos en la cadena
    String cleanedAmount = amountToAddFund.replaceAll('\$', '');
    if (!cleanedAmount.contains('.')) {
      cleanedAmount = cleanedAmount.replaceAll(',', '.');
    } else {
      cleanedAmount = cleanedAmount.replaceAll(',', '');
    }
    double result = double.tryParse(cleanedAmount) ?? 0.0;
    // Verifica si el resultado es un número entero y devuelve como int si es posible
    return result == result.roundToDouble() ? result.toInt() : result;
  }
}
