import 'dart:math';

import 'package:wallet_guru/domain/core/models/response_model.dart';

class SendPaymentEntity {
  final String receiverWalletAddress;
  final String receiverAmount;
  final String currency;
  final int assetScale;

  SendPaymentEntity({
    required this.receiverWalletAddress,
    required this.receiverAmount,
    required this.currency,
    required this.assetScale,
  });

  SendPaymentEntity copyWith({
    String? receiverWalletAddress,
    String? receiverAmount,
    String? currency,
    int? assetScale,
  }) {
    return SendPaymentEntity(
      receiverWalletAddress:
          receiverWalletAddress ?? this.receiverWalletAddress,
      receiverAmount: receiverAmount ?? this.receiverAmount,
      currency: currency ?? this.currency,
      assetScale: assetScale ?? this.assetScale,
    );
  }

  SendPaymentEntity.empty()
      : receiverWalletAddress = '',
        receiverAmount = '',
        currency = '',
        assetScale = 0;

  Map<String, dynamic> toMap() {
    return {
      "receiverWalletAddress": receiverWalletAddress,
      "receiverAmount": receiverAmount,
      "currency": currency,
      "assetScale": assetScale,
    };
  }

  double calculateAmountWithScale() {
    double x = double.tryParse(receiverAmount.replaceAll(',', '.')) ?? 0.0;
    return pow(x, assetScale).toDouble();
  }
}

class WalletForPaymentEntity {
  final WalletDb walletDb;
  final WalletAsset walletAsset;

  WalletForPaymentEntity({
    required this.walletDb,
    required this.walletAsset,
  });

  WalletForPaymentEntity copyWith({
    WalletDb? walletDb,
    WalletAsset? walletAsset,
  }) {
    return WalletForPaymentEntity(
      walletDb: walletDb ?? this.walletDb,
      walletAsset: walletAsset ?? this.walletAsset,
    );
  }

  factory WalletForPaymentEntity.fromWallet(Wallet wallet) {
    return WalletForPaymentEntity(
      walletDb: wallet.walletDb,
      walletAsset: wallet.walletAsset!,
    );
  }
}
