import 'dart:convert';
import 'dart:io';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/env/env.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/domain/create_profile/entities/base_profile_entity.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http_sum_sub.dart';
import 'package:wallet_guru/infrastructure/create_profile/network/create_profile_network.dart';
import 'package:wallet_guru/infrastructure/user/network/user_network.dart';
import 'package:wallet_guru/presentation/core/utils/global_error_translations.dart';

class CreateProfileDataSource {
  Future<ResponseModel> updateUser<T extends BaseProfileEntity>(
      T entity) async {
    var response = await HttpDataSource.put(
      "${CreateProfileNetwork.updateUser}${entity.id}",
      entity.toJson(),
    );
    print(entity.toJson());
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel createProfileModel = ResponseModel.fromJson(result);
      return createProfileModel;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(
        errorModel.customCode,
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
        GlobalErrorTranslations.getErrorMessage(errorModel.customCode),
      );
    }
  }

  Future<ResponseModel> updateUserPicture(File picture, String userId) async {
    var response = await HttpDataSource.putMultipart(
        '${UserNetwork.updateUserPicture}$userId', picture);

    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
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

  Future<ResponseModel> generateSumSubAccessToken(String userId) async {
    var response = await SumSubAPI.postSumSub(
      CreateProfileNetwork.getAccessToken,
      {
        'userId': userId,
        'levelName': Env.sumSubLevelName,
        "ttlInSecs": 600,
      },
    );
    final result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel createProfileModel = ResponseModel.fromJson(result);
      return createProfileModel;
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
