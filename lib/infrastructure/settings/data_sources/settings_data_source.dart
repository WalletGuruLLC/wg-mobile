import 'dart:convert';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/domain/settings/entities/setting_entity.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/settings/network/settings_network.dart';

class SettingsDataSource {
  Future<List<SettingEntity>> fetchSettings() async {
    final response = await HttpDataSource.get(
      SettingsNetwork.getSetting,
    );
    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final translationsList = result['data'] as List;
      return translationsList
          .map((json) => SettingEntity.fromJson(json))
          .toList();
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }
}
