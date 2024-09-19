part of 'receive_payment_cubit.dart';

class ReceivePaymentState extends Equatable {
  final String receiverWalletAddress;
  final FormSubmissionStatus formStatus;
  final String customMessage;
  final String customMessageEs;
  final String customCode;

  const ReceivePaymentState({
    this.receiverWalletAddress = '',
    this.customMessage = '',
    this.customMessageEs = '',
    this.customCode = '',
    this.formStatus = const InitialFormStatus(),
  });

  ReceivePaymentState copyWith({
    String? receiverWalletAddress,
    FormSubmissionStatus? formStatus,
    String? customMessage,
    String? customMessageEs,
    String? customCode,
  }) =>
      ReceivePaymentState(
        receiverWalletAddress:
            receiverWalletAddress ?? this.receiverWalletAddress,
        formStatus: formStatus ?? this.formStatus,
        customMessage: customMessage ?? this.customMessage,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        customCode: customCode ?? this.customCode,
      );

  ReceivePaymentState initialState() => const ReceivePaymentState(
        receiverWalletAddress: '',
        formStatus: InitialFormStatus(),
        customMessage: '',
        customMessageEs: '',
        customCode: '',
      );

  @override
  List<Object> get props => [
        receiverWalletAddress,
        formStatus,
        customMessage,
        customMessageEs,
      ];
}
