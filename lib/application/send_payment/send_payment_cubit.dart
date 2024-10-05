import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/domain/core/entities/send_payment_entity.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';
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
        if (singInUser.data!.message == "don’t found") {
          emit(state.copyWith(
            formStatus: SubmissionFailed(
                exception: Exception(singInUser.data!.message)),
            customCode: singInUser.customCode,
            customMessage: singInUser.customMessageEs,
            customMessageEs: singInUser.customMessageEs,
          ));
        } else {
          emit(state.copyWith(
            customMessage: singInUser.customCode,
            customMessageEs: singInUser.customMessageEs,
            formStatus: SubmissionSuccess(),
          ));
        }
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

  void emitFetchWalletAsset() async {
    final asset = await receivePaymentRepository.fetchWalletAsset();
    asset.fold(
      (error) {
        emit(state.copyWith(
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (asset) {
        emit(state.copyWith(
          rafikiAssets: asset.data!.rafikiAssets!,
          fetchWalletAsset: true,
        ));
      },
    );
  }

  void emitGetExchangeRate() async {
    final asset = await receivePaymentRepository
        .getExchangeRate(state.walletForPaymentEntity!.walletAsset.code);
    asset.fold(
      (error) {
        emit(state.copyWith(
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (asset) {
        emit(state.copyWith(
          eurExchangeRate: asset.rates!.eur == 0.0 ? 1.0 : asset.rates!.eur,
          usdExchangeRate: asset.rates!.usd == 0.0 ? 1.0 : asset.rates!.usd,
          mxnExchangeRate: asset.rates!.mxn == 0.0 ? 1.0 : asset.rates!.mxn,
          jpyExchangeRate: asset.rates!.jpy == 0.0 ? 1.0 : asset.rates!.jpy,
        ));
      },
    );
  }

  double getExchangeRate(String currency) {
    switch (currency) {
      case 'EUR':
        return state.eurExchangeRate!;
      case 'USD':
        return state.usdExchangeRate!;
      case 'MXN':
        return state.mxnExchangeRate!;
      case 'JPY':
        return state.jpyExchangeRate!;
      default:
        return 1.0;
    }
  }

  double getAmountInCurrency(String currency) {
    String cleanedAmount = state.sendPaymentEntity!.receiverAmount
        .replaceAll(RegExp(r'[^\d.]'), '');
    double amount = double.tryParse(cleanedAmount) ?? 0.0;
    return amount * getExchangeRate(currency).toDouble();
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
