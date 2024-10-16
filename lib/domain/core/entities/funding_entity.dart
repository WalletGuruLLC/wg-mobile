class FundingEntity {
  final double amountToAddFund;
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
    double? amountToAddFund,
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
      : amountToAddFund = 0,
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
}
