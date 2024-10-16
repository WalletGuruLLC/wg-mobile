import 'dart:convert';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/create_wallet/network/create_wallet_network.dart';

import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/presentation/core/utils/global_error_translations.dart';

class CreateWalletDataSource {
  Future<ResponseModel> createWallet(String addressName, String assetId) async {
    var response = await HttpDataSource.post(
      CreateWalletNetwork.createWallet,
      {
        "addressName": addressName,
        "assetId": assetId,
      },
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 201) {
      ResponseModel signInSignInResponseModel = ResponseModel.fromJson(result);
      return signInSignInResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(
        errorModel.customCode,
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
      );
    }
  }

  Future<ResponseModel> fetchWalletAssetId() async {
    var response =
        await HttpDataSource.get(CreateWalletNetwork.getRafikiAssets);
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel signInSignInResponseModel = ResponseModel.fromJson(result);
      return signInSignInResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(
        errorModel.customCode,
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
      );
    }
  }
}
