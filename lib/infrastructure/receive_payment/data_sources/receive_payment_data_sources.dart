import 'dart:convert';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/receive_payment/network/receive_payment_network.dart';

class ReceivePaymentDataSource {
  Future<ResponseModel> verifyWalletExistence(String walletAddress) async {
    var response = await HttpDataSource.post(
      ReceivePaymentNetwork.verifyWalletExistence,
      {
        "walletAddress": walletAddress,
      },
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
