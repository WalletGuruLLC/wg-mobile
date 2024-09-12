import 'package:either_dart/either.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/settings/entities/setting_entity.dart';
import 'package:wallet_guru/domain/settings/repositories/settings_repository.dart';
import 'package:wallet_guru/infrastructure/settings/data_sources/settings_data_source.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsDataSource settingsDataSource;

  SettingsRepositoryImpl({
    required this.settingsDataSource,
  });

  @override
  Future<Either<InvalidData, List<SettingEntity>>> fetchSettings() async {
    try {
      final List<SettingEntity> response =
          await settingsDataSource.fetchSettings();
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
