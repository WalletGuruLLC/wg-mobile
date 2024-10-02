class SendPaymentEntity {
  final String receiverWalletAddress;
  final String receiverAmount;
  final String currency;

  SendPaymentEntity({
    required this.receiverWalletAddress,
    required this.receiverAmount,
    required this.currency,
  });

  SendPaymentEntity copyWith({
    String? receiverWalletAddress,
    String? receiverAmount,
    String? amount,
    String? currency,
  }) {
    return SendPaymentEntity(
      receiverWalletAddress:
          receiverWalletAddress ?? this.receiverWalletAddress,
      receiverAmount: receiverAmount ?? this.receiverAmount,
      currency: currency ?? this.currency,
    );
  }

  SendPaymentEntity.empty()
      : receiverWalletAddress = '',
        receiverAmount = '',
        currency = '';

  Map<String, dynamic> toMap() {
    return {
      "receiverWalletAddress": receiverWalletAddress,
      "receiverAmount": receiverAmount,
      "currency": currency,
    };
  }
}
