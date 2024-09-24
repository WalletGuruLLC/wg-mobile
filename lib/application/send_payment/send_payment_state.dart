part of 'send_payment_cubit.dart';

class SendPaymentState extends Equatable {
  final SendPaymentEntity? sendPaymentEntity;
  final FormSubmissionStatus formStatus;
  final String customMessage;
  final String customMessageEs;
  final String customCode;
  final bool showNextButton;
  final bool showPaymentButton;

  const SendPaymentState({
    this.sendPaymentEntity,
    this.customMessage = '',
    this.customMessageEs = '',
    this.customCode = '',
    this.formStatus = const InitialFormStatus(),
    this.showNextButton = false,
    this.showPaymentButton = false,
  });

  SendPaymentState copyWith({
    FormSubmissionStatus? formStatus,
    String? customMessage,
    String? customMessageEs,
    String? customCode,
    bool? showNextButton,
    SendPaymentEntity? sendPaymentEntity,
    bool? showPaymentButton,
  }) =>
      SendPaymentState(
        formStatus: formStatus ?? this.formStatus,
        customMessage: customMessage ?? this.customMessage,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        customCode: customCode ?? this.customCode,
        showNextButton: showNextButton ?? this.showNextButton,
        sendPaymentEntity: sendPaymentEntity ?? this.sendPaymentEntity,
        showPaymentButton: showPaymentButton ?? this.showPaymentButton,
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
      ];
}
