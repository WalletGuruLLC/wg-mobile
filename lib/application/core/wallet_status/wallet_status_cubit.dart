import 'package:flutter_bloc/flutter_bloc.dart';

class WalletStatusState {
  final bool isWalletActive;

  WalletStatusState({required this.isWalletActive});
}

class WalletStatusCubit extends Cubit<WalletStatusState> {
  WalletStatusCubit() : super(WalletStatusState(isWalletActive: true));

  void updateWalletStatus(bool isActive) {
    emit(WalletStatusState(isWalletActive: isActive));
  }
}
