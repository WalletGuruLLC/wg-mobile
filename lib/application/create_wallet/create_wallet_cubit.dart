import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/domain/create_wallet/repositories/create_wallet_repository.dart';

import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';

part 'create_wallet_state.dart';

class CreateWalletCubit extends Cubit<CreateWalletState> {
  CreateWalletCubit() : super(const CreateWalletState());
  final createWalletRepository = Injector.resolve<CreateWalletRepository>();

  void emitCreateWallet() async {
    emit(
      state.copyWith(formStatus: FormSubmitting()),
    );
    final verifyEmailOtp = await createWalletRepository.createWallet(
      state.addressName,
      state.assetId,
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
          customMessage: createdWallet.customCode,
          customMessageEs: createdWallet.customMessageEs,
          customCode: createdWallet.customCode,
          formStatus: SubmissionSuccess(),
        ));
      },
    );
  }

  void setUserWalletName(String? walletName) async {
    emit(state.copyWith(addressName: walletName));
  }

  void emitFetchWalletAssetId() async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    final assetId = await createWalletRepository.fetchWalletAssetId();
    assetId.fold(
      (error) {
        emit(state.copyWith(
          formStatus: SubmissionFailed(exception: Exception(error.messageEn)),
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (assetId) {
        emit(state.copyWith(
          assetId: assetId.data!.rafikiAssets![0].id,
        ));
        emitCreateWallet();
      },
    );
  }

  void emitInitialStatus() async {
    emit(state.initialState());
  }
}
