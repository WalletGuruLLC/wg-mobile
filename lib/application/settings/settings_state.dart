import 'package:wallet_guru/domain/settings/entities/setting_entity.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final List<SettingEntity> settings;
  SettingsLoaded(this.settings);
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}
