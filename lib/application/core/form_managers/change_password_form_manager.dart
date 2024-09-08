import 'package:wallet_guru/application/user/user_cubit.dart';

class ChangePasswordFormManager {
  String? _currentPassword;
  String? _newPassword;
  String? _confirmNewPassword;

  final UserCubit userCubit;

  ChangePasswordFormManager(this.userCubit);

  // Métodos para gestionar el estado de las contraseñas
  void updateCurrentPassword(String? value) {
    _currentPassword = value;
    userCubit.setCurrentPassword(value);
    validatePasswords();
  }

  void updateNewPassword(String? value) {
    _newPassword = value;
    userCubit.setNewPassword(value);
    validatePasswords();
  }

  void updateConfirmNewPassword(String? value) {
    _confirmNewPassword = value;
    userCubit.setConfirmNewPassword(value);
    validatePasswords();
  }

  // Validación de contraseñas
  void validatePasswords() {
    // Aquí iría la lógica de validación personalizada
    userCubit.validatePasswords();
  }

  // Obtener los valores actuales
  String? get currentPassword => _currentPassword;
  String? get newPassword => _newPassword;
  String? get confirmNewPassword => _confirmNewPassword;
}
