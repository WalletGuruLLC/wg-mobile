import 'dart:convert';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/create_wallet/network/create_wallet_network.dart';

import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';

class CreateWalletDataSource {
  Future<ResponseModel> createWallet(
      String walletName, String walletAddress, String walletType) async {
    var response = await HttpDataSource.post(
      CreateWalletNetwork.createWallet,
      {
        "name": walletName,
        "walletType": walletType,
        "walletAddress": walletAddress,
      },
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel signInSignInResponseModel = ResponseModel.fromJson(result);
      return signInSignInResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessageEs);
    }
  }
}
