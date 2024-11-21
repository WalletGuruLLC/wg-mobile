import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    }, (settings) async {
      final urlSetting = settings.firstWhere(
        (setting) => setting.key == "url-wallet",
      );

      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('urlWallet', urlSetting.value);
      print('URL guardada: ${urlSetting.value}');
      emit(SettingsLoaded(settings));
    });
  }
}
