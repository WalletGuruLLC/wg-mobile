import 'package:wallet_guru/domain/core/models/response_model.dart';

class WalletEntity {
  final WalletDb walletDb;
  final WalletAsset walletAsset;
  final double balance;
  final double reserved;

  WalletEntity({
    required this.walletDb,
    required this.walletAsset,
    required this.balance,
    required this.reserved,
  });

  Wallet copyWith({
    WalletDb? walletDb,
    WalletAsset? walletAsset,
    double? balance,
    double? reserved,
  }) =>
      Wallet(
        walletDb: walletDb ?? this.walletDb,
        walletAsset: walletAsset ?? this.walletAsset,
        balance: balance ?? this.balance,
        reserved: reserved ?? this.reserved,
      );

  factory WalletEntity.fromWallet(Wallet wallet) {
    return WalletEntity(
      walletDb: wallet.walletDb,
      walletAsset: wallet.walletAsset,
      balance: wallet.balance,
      reserved: wallet.reserved,
    );
  }
}

class WalletAssetEntity {
  final String typename;
  final String code;
  final String id;
  final String liquidity;
  final int scale;

  WalletAssetEntity({
    required this.typename,
    required this.code,
    required this.id,
    required this.liquidity,
    required this.scale,
  });

  factory WalletAssetEntity.fromJson(Map<String, dynamic> json) =>
      WalletAssetEntity(
        typename: json["_Typename"],
        code: json["code"],
        id: json["id"],
        liquidity: json["liquidity"],
        scale: json["scale"],
      );

  factory WalletAssetEntity.initialState() => WalletAssetEntity(
        typename: '',
        code: '',
        id: '',
        liquidity: '',
        scale: 0,
      );
}

class WalletDbEntity {
  final String userId;
  final String walletType;
  final String id;
  final bool active;
  final String name;

  WalletDbEntity({
    required this.userId,
    required this.walletType,
    required this.id,
    required this.active,
    required this.name,
  });

  factory WalletDbEntity.fromJson(Map<String, dynamic> json) => WalletDbEntity(
        userId: json["userId"],
        walletType: json["walletType"],
        id: json["id"],
        active: json["active"],
        name: json["name"],
      );

  factory WalletDbEntity.initialState() => WalletDbEntity(
        userId: '',
        walletType: '',
        id: '',
        active: false,
        name: '',
      );
}
