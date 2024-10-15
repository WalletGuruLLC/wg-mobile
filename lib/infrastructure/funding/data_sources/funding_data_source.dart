import 'dart:convert';
import 'dart:math';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/funding/network/funding_network.dart';

class FundingDataSource {
  Future<ResponseModel> getListOfIncomingPayments() async {
    var response = await HttpDataSource.get(
      FundingNetwork.getListOfIncomingPayments,
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel registerModel = ResponseModel.fromJson(result);
      return registerModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }

  Future<ResponseModel> linkServerProvider(
      String walletAddressUrl, String walletAddressId) async {
    var response = await HttpDataSource.post(
      FundingNetwork.linkServerProvider,
      {
        "walletAddressUrl": walletAddressUrl,
        "walletAddressId": walletAddressId,
        "amount": 0.10 + Random().nextDouble() * (0.20 - 0.10),
      },
    );

    final result = jsonDecode(response.body);
    if (response.statusCode == 201) {
      ResponseModel registerModel = ResponseModel.fromJson(result);
      return registerModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }
}
