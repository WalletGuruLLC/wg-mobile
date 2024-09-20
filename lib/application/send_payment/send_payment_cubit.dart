import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/domain/receive_payment/repositories/receive_payment_repository.dart';
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
        .verifyWalletExistence(state.receiverWalletAddress);
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
  }) {
    emit(
      state.copyWith(
        receiverWalletAddress: receiverWalletAddress,
      ),
    );
    showButton();
  }

  void showButton() {
    bool shouldShowButton =
        Validators.regExpressionForWallet.hasMatch(state.receiverWalletAddress);
    emit(
      state.copyWith(
        showButton: shouldShowButton,
      ),
    );
  }
}
