import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/domain/core/entities/send_payment_entity.dart';
import 'package:wallet_guru/domain/send_payment/repositories/send_payment_repository.dart';
import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';

part 'send_payment_state.dart';

class SendPaymentCubit extends Cubit<SendPaymentState> {
  SendPaymentCubit() : super(const SendPaymentState());
  final receivePaymentRepository = Injector.resolve<SendPaymentRepository>();

  void emitVerifyWalletExistence() async {
    emit(
      state.copyWith(formStatus: FormSubmitting()),
    );
    final verifyEmailOtp = await receivePaymentRepository
        .verifyWalletExistence(state.sendPaymentEntity!.receiverWalletAddress);
    verifyEmailOtp.fold(
      (error) {
        emit(state.copyWith(
          formStatus: SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (singInUser) {
        emit(state.copyWith(
          customMessage: singInUser.customCode,
          customMessageEs: singInUser.customMessageEs,
          formStatus: SubmissionSuccess(),
        ));
      },
    );
  }

  void updateSendPaymentInformation({
    String? receiverWalletAddress,
    String? receiverAmount,
    String? currency,
  }) {
    final updatedSendPaymentEntity = _getOrCreateSendPaymentEntity().copyWith(
      receiverWalletAddress: receiverWalletAddress,
      receiverAmount: receiverAmount,
      currency: currency,
    );
    emit(
      state.copyWith(
        sendPaymentEntity: updatedSendPaymentEntity,
      ),
    );
    showButton();
    showPaymentButton();
  }

  SendPaymentEntity _getOrCreateSendPaymentEntity() {
    return state.sendPaymentEntity ??
        SendPaymentEntity(
          receiverWalletAddress: '',
          receiverAmount: '',
          currency: '',
          assetScale: 0,
        );
  }

  void showButton() {
    String address = state.sendPaymentEntity!.receiverWalletAddress;
    bool shouldShowButton = Validators.regExpressionForWallet.hasMatch(address);
    emit(
      state.copyWith(
        showNextButton: shouldShowButton,
      ),
    );
  }

  void showPaymentButton() {
    bool shouldShowButton =
        state.sendPaymentEntity!.receiverAmount.isNotEmpty &&
            state.sendPaymentEntity!.currency.isNotEmpty;
    emit(
      state.copyWith(
        showPaymentButton: shouldShowButton,
      ),
    );
  }

  void resetPaymentEntity() {
    emit(
      state.copyWith(
        sendPaymentEntity: SendPaymentEntity.empty(),
      ),
    );
  }

  void resetSendPaymentInformation() {
    emit(
      state.copyWith(
        showNextButton: false,
        showPaymentButton: false,
      ),
    );
  }

  void emitGetWalletInformation() async {
    emit(
      state.copyWith(),
    );
    final walletInfo = await receivePaymentRepository.getWalletInformation();
    walletInfo.fold(
      (error) {
        emit(state.copyWith(
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (walletInfo) {
        emit(
          state.copyWith(
            walletForPaymentEntity:
                WalletForPaymentEntity.fromWallet(walletInfo.data!.wallet!),
          ),
        );
      },
    );
  }

  void createTransaction() async {
    emit(
      state.copyWith(formStatus: FormSubmitting()),
    );
    final transaction = await receivePaymentRepository.createTransaction(
        state.walletForPaymentEntity!, state.sendPaymentEntity!);
    transaction.fold(
      (error) {
        emit(state.copyWith(
          formStatus: SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (transaction) {
        emit(state.copyWith(
          customMessage: transaction.customCode,
          customMessageEs: transaction.customMessageEs,
          formStatus: SubmissionSuccess(),
        ));
      },
    );
  }
}
