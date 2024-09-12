import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_state.dart';
import 'package:wallet_guru/domain/settings/repositories/settings_repository.dart';
import 'package:wallet_guru/infrastructure/core/injector/injector.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository =
      Injector.resolve<SettingsRepository>();

  SettingsCubit() : super(SettingsInitial());

  Future<void> loadSettings() async {
    emit(SettingsLoading());
    final settings = await settingsRepository.fetchSettings();
    settings.fold((error) {
      emit(SettingsError("Failed to load settings"));
    }, (settings) {
      emit(SettingsLoaded(settings));
    });
  }
}
