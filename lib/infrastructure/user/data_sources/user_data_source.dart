import 'dart:convert';
import 'dart:io';
import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';
import 'package:wallet_guru/infrastructure/user/network/user_network.dart';

class UserDataSource {
  Future<ResponseModel> getCurrentUserInformation() async {
    var response =
        await HttpDataSource.get(UserNetwork.getCurrentUserInformation);

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
        '${UserNetwork.updateCreatedUser}$userId', changedUser);

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

  Future<ResponseModel> lockAccount(String userIdRole) async {
    var response = await HttpDataSource.patch(
        '${UserNetwork.lockAccount}$userIdRole/toggle', {});

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

  Future<ResponseModel> getWalletInformation() async {
    var response = await HttpDataSource.get(UserNetwork.getWalletInformation);

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

  Future<ResponseModel> updateUserPicture(File picture, String userId) async {
    var response = await HttpDataSource.putMultipart(
        '${UserNetwork.updateUserPicture}$userId', picture);

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
