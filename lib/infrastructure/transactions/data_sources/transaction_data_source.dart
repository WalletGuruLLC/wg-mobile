import 'dart:convert';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/presentation/core/utils/global_error_translations.dart';
import 'package:wallet_guru/infrastructure/transactions/network/transaction_network.dart';

class TransactionDataSource {
  Future<ResponseModel> fetchTransactions() async {
    final response = await HttpDataSource.get(
      "${TransactionNetwork.getListUserTransactions}?page=1&items=1000",
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel listUserTransaction = ResponseModel.fromJson(result);
      return listUserTransaction;
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
