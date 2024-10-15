import 'dart:convert';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/deposit/network/deposit_network.dart';

class DepositDataSource {
  Future<ResponseModel> createDepositWallet(
      String walletAddressId, int amount) async {
    var response = await HttpDataSource.post(
      DepositNetwork.createDepostiWallet,
      {
        "walletAddressId": walletAddressId,
        "amount": amount,
      },
    );

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
}
