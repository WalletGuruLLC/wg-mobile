import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/domain/deposit/repositories/deposit_repository.dart';

part 'deposit_state.dart';

class DepositCubit extends Cubit<DepositState> {
  DepositCubit() : super(const DepositState());
  final depositRepository = Injector.resolve<DepositRepository>();

  void emitCreateDepositWallet() async {
    emit(
      state.copyWith(formStatus: FormSubmitting()),
    );
    final verifyEmailOtp = await depositRepository.createDepositWallet(
      state.walletAddressId,
      10,
    );
    verifyEmailOtp.fold(
      (error) {
        emit(state.copyWith(
          formStatus: SubmissionFailed(exception: Exception(error.messageEn)),
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
          customCode: error.code,
        ));
      },
      (createdWallet) {
        emit(state.copyWith(
          customMessage: createdWallet.customMessage,
          customMessageEs: createdWallet.customMessageEs,
          customCode: createdWallet.customCode,
          formStatus: SubmissionSuccess(),
        ));
      },
    );
  }

  void emitwalletId(String walletAddress) async {
    emit(state.copyWith(walletAddressId: walletAddress));
  }
}
