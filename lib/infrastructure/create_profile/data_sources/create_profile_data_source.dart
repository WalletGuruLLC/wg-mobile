import 'dart:convert';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';
import 'package:wallet_guru/infrastructure/create_profile/network/create_profile_network.dart';

class CreateProfileDataSource {
  Future<ResponseModel> updateUser<T extends BaseProfileEntity>(
      T entity) async {
    var response = await HttpDataSource.put(
      "${CreateProfileNetwork.updateUser}${entity.id}",
      entity.toJson(),
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel createProfileModel = ResponseModel.fromJson(result);
      return createProfileModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage);
    }
  }
}
