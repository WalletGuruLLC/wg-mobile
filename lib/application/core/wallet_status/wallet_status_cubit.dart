import 'package:flutter_bloc/flutter_bloc.dart';

class WalletStatusState {
  final bool isWalletActive;
  final bool isBiometricAvailable;

  WalletStatusState({
    required this.isWalletActive,
    this.isBiometricAvailable = false,
  });

  WalletStatusState copyWith({
    bool? isWalletActive,
    bool? isBiometricAvailable,
  }) {
    return WalletStatusState(
      isWalletActive: isWalletActive ?? this.isWalletActive,
      isBiometricAvailable: isBiometricAvailable ?? this.isBiometricAvailable,
    );
  }
}

class WalletStatusCubit extends Cubit<WalletStatusState> {
  WalletStatusCubit()
      : super(WalletStatusState(
          isWalletActive: true,
          isBiometricAvailable: false,
        ));

  void updateWalletStatus(bool isActive) {
    emit(state.copyWith(isWalletActive: isActive));
  }

  void updateBiometricStatus(bool isBiometricAvailable) {
    emit(state.copyWith(isBiometricAvailable: isBiometricAvailable));
  }
}
