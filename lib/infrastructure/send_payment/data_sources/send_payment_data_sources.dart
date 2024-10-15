import 'dart:convert';

import 'package:wallet_guru/application/core/formatter/formatter.dart';
import 'package:wallet_guru/domain/core/entities/send_payment_entity.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/send_payment/network/send_payment_network.dart';

class SendPaymentDataSource {
  Future<ResponseModel> verifyWalletExistence(String walletAddress) async {
    var url =
        '${SendPaymentNetwork.verifyWalletExistence}?address=$walletAddress';

    var response = await HttpDataSource.get(url);
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel signInSignInResponseModel = ResponseModel.fromJson(result);
      return signInSignInResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }

  Future<ResponseModel> getWalletInformation() async {
    var response =
        await HttpDataSource.get(SendPaymentNetwork.getWalletInformation);

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel walletInfo = ResponseModel.fromJson(result);
      return walletInfo;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }

  Future<ResponseModel> createTransaction(WalletForPaymentEntity walletEntity,
      SendPaymentEntity sendPaymentEntity) async {
    var response = await HttpDataSource.post(
      SendPaymentNetwork.createTransaction,
      {
        "amount":
            Formatter.parseDoubleWithComma(sendPaymentEntity.receiverAmount),
        "walletAddressUrl": sendPaymentEntity.receiverWalletAddress,
        "walletAddressId": walletEntity.walletDb.rafikiId,
      },
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel transactionResponseModel = ResponseModel.fromJson(result);
      return transactionResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }

  Future<ResponseModel> fetchWalletAsset() async {
    var response = await HttpDataSource.get(SendPaymentNetwork.getRafikiAssets);
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel signInSignInResponseModel = ResponseModel.fromJson(result);
      return signInSignInResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }

  Future<ResponseModel> getExchangeRate(String currency) async {
    var response = await HttpDataSource.get(
      '${SendPaymentNetwork.getExchangeRate}?base=$currency',
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel signInSignInResponseModel = ResponseModel.fromJson(result);
      return signInSignInResponseModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }
}
