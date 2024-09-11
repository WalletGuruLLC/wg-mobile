import 'package:wallet_guru/domain/core/models/response_model.dart';

class WalletEntity {
  final String id;
  final String walletAddress;

  WalletEntity({
    required this.id,
    required this.walletAddress,
  });

  WalletEntity copyWith({
    String? id,
    String? walletAddress,
  }) {
    return WalletEntity(
      id: id ?? this.id,
      walletAddress: walletAddress ?? this.walletAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'walletAddress': walletAddress,
    };
  }

  factory WalletEntity.fromWallet(Wallet wallet) {
    return WalletEntity(
      id: wallet.id,
      walletAddress: wallet.walletAddress,
    );
  }
}
