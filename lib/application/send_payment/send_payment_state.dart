part of 'send_payment_cubit.dart';

class SendPaymentState extends Equatable {
  final SendPaymentEntity? sendPaymentEntity;
  final FormSubmissionStatus formStatus;
  final String customMessage;
  final String customMessageEs;
  final String customCode;
  final bool showNextButton;
  final bool showPaymentButton;
  final WalletForPaymentEntity? walletForPaymentEntity;
  final List<RafikiAssets>? rafikiAssets;
  final bool fetchWalletAsset;
  final double? eurExchangeRate;
  final double? usdExchangeRate;
  final double? mxnExchangeRate;
  final double? jpyExchangeRate;
  final FormSubmissionStatus? isWalletExistForm;
  final FormSubmissionStatus? isWalletExistQr;

  const SendPaymentState({
    this.sendPaymentEntity,
    this.customMessage = '',
    this.customMessageEs = '',
    this.customCode = '',
    this.formStatus = const InitialFormStatus(),
    this.showNextButton = false,
    this.showPaymentButton = false,
    this.walletForPaymentEntity,
    this.rafikiAssets,
    this.fetchWalletAsset = false,
    this.eurExchangeRate,
    this.usdExchangeRate,
    this.mxnExchangeRate,
    this.jpyExchangeRate,
    this.isWalletExistForm = const InitialFormStatus(),
    this.isWalletExistQr = const InitialFormStatus(),
  });

  SendPaymentState copyWith({
    FormSubmissionStatus? formStatus,
    String? customMessage,
    String? customMessageEs,
    String? customCode,
    bool? showNextButton,
    SendPaymentEntity? sendPaymentEntity,
    bool? showPaymentButton,
    WalletForPaymentEntity? walletForPaymentEntity,
    List<RafikiAssets>? rafikiAssets,
    bool? fetchWalletAsset,
    double? eurExchangeRate,
    double? usdExchangeRate,
    double? mxnExchangeRate,
    double? jpyExchangeRate,
    FormSubmissionStatus? isWalletExistForm,
    FormSubmissionStatus? isWalletExistQr,
  }) =>
      SendPaymentState(
        formStatus: formStatus ?? this.formStatus,
        customMessage: customMessage ?? this.customMessage,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        customCode: customCode ?? this.customCode,
        showNextButton: showNextButton ?? this.showNextButton,
        sendPaymentEntity: sendPaymentEntity ?? this.sendPaymentEntity,
        showPaymentButton: showPaymentButton ?? this.showPaymentButton,
        walletForPaymentEntity:
            walletForPaymentEntity ?? this.walletForPaymentEntity,
        rafikiAssets: rafikiAssets ?? this.rafikiAssets,
        fetchWalletAsset: fetchWalletAsset ?? this.fetchWalletAsset,
        eurExchangeRate: eurExchangeRate ?? this.eurExchangeRate,
        usdExchangeRate: usdExchangeRate ?? this.usdExchangeRate,
        mxnExchangeRate: mxnExchangeRate ?? this.mxnExchangeRate,
        jpyExchangeRate: jpyExchangeRate ?? this.jpyExchangeRate,
        isWalletExistForm: isWalletExistForm ?? this.isWalletExistForm,
        isWalletExistQr: isWalletExistQr ?? this.isWalletExistQr,
      );

  @override
  List<Object?> get props => [
        formStatus,
        customMessage,
        customMessageEs,
        customCode,
        showNextButton,
        sendPaymentEntity,
        showPaymentButton,
        walletForPaymentEntity,
        rafikiAssets,
        fetchWalletAsset,
        eurExchangeRate,
        usdExchangeRate,
        mxnExchangeRate,
        jpyExchangeRate,
        isWalletExistForm,
        isWalletExistQr,
      ];
}
