import 'dart:convert';

import 'package:wallet_guru/domain/core/entities/funding_entity.dart';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/funding/network/funding_network.dart';
import 'package:wallet_guru/presentation/core/utils/global_error_translations.dart';

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
      throw InvalidData(
          errorModel.customCode,
          GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
          GlobalErrorTranslations.getErrorMessage(errorModel.customCode));
    }
  }

  Future<ResponseModel> linkServerProvider(FundingEntity fundingEntity) async {
    var body = {
      "walletAddressUrl": fundingEntity.getWalletAddressWithoutQueryParams(),
      "sessionId": fundingEntity.sessionId,
      "walletAddressId": fundingEntity.rafikiWalletAddress,
    };
    var response =
        await HttpDataSource.post(FundingNetwork.linkServerProvider, body);
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel registerModel = ResponseModel.fromJson(result);
      return registerModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(
          errorModel.customCode,
          GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
          GlobalErrorTranslations.getErrorMessage(errorModel.customCode));
    }
  }

  Future<ResponseModel> createIncomingPayment(
      FundingEntity fundingEntity) async {
    var body = {
      "walletAddressUrl": fundingEntity.getWalletAddressWithoutQueryParams(),
      "incomingAmount": fundingEntity.convertAmountToNumber(),
      "walletAddressId": fundingEntity.rafikiWalletAddress,
    };
    var response =
        await HttpDataSource.post(FundingNetwork.createIncomingPayment, body);
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel registerModel = ResponseModel.fromJson(result);
      return registerModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(
          errorModel.customCode,
          GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
          GlobalErrorTranslations.getErrorMessage(errorModel.customCode));
    }
  }

  Future<ResponseModel> unlinkedServiceProvider(String sessionId) async {
    var body = {
      "sessionId": sessionId,
    };
    var response =
        await HttpDataSource.post(FundingNetwork.unlinkedServiceProvider, body);
    final result = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ResponseModel registerModel = ResponseModel.fromJson(result);
      return registerModel;
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
