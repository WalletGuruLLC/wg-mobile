import 'package:either_dart/either.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/settings/entities/setting_entity.dart';

abstract class SettingsRepository {
  Future<Either<InvalidData, List<SettingEntity>>>
      fetchSettings();
}
