import 'dart:convert';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/domain/translations_error/models/translation_error_model.dart';
import 'package:wallet_guru/infrastructure/translations_error/network/translations_error_network.dart';

class TranslationsErrorDataSources {
  Future<List<TranslationErrorModel>> getTranslationsErrors(String lang) async {
    var response = await HttpDataSource.get(
      "${TranslationsErrorNetwork.getCodesByLanguage}/$lang",
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final translationsList = result['data']['translations'] as List;
      return translationsList
          .map((json) => TranslationErrorModel.fromJson(json))
          .toList();
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }
}
