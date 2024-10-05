import 'package:wallet_guru/domain/core/models/response_model.dart';

class WalletEntity {
  final WalletDb walletDb;
  final WalletAsset walletAsset;

  WalletEntity({
    required this.walletDb,
    required this.walletAsset,
  });

  Wallet copyWith({
    WalletDb? walletDb,
    WalletAsset? walletAsset,
  }) =>
      Wallet(
        walletDb: walletDb ?? this.walletDb,
        walletAsset: walletAsset ?? this.walletAsset,
      );

  factory WalletEntity.fromWallet(Wallet wallet) {
    return WalletEntity(
      walletDb: wallet.walletDb,
      walletAsset: wallet.walletAsset ?? WalletAsset.initialState(),
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
