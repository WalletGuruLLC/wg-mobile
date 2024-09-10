import 'dart:convert';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/user/network/user_network.dart';

class UserDataSource {
  Future<ResponseModel> getCurrentUserInformation() async {
    var response = await HttpDataSource.get(UserNetwork.updateUser);

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

  Future<ResponseModel> updateUserInformation(
      Map<String, dynamic> changedUser, String userId) async {
    var response = await HttpDataSource.put(
        '${UserNetwork.updateUser}$userId', changedUser);

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

  Future<ResponseModel> changePassword(
      String email, String currentPassword, String newPassword) async {
    var response = await HttpDataSource.post(UserNetwork.changePassword, {
      'email': email,
      'currentPassword': currentPassword,
      'newPassword': newPassword
    });

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
}
