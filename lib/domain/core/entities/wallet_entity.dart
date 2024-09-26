import 'package:wallet_guru/domain/core/models/response_model.dart';

class WalletEntity {
  final String id;
  final String walletAddress;
  final bool active;

  WalletEntity({
    required this.id,
    required this.walletAddress,
    required this.active,
  });

  WalletEntity copyWith({
    String? id,
    String? walletAddress,
    bool? active,
  }) {
    return WalletEntity(
      id: id ?? this.id,
      walletAddress: walletAddress ?? this.walletAddress,
      active: active ?? this.active,
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
      walletAddress: wallet.walletAddress ?? '',
      active: wallet.active,
    );
  }
}
