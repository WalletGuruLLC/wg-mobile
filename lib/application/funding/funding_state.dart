part of 'funding_cubit.dart';

class FundingState extends Equatable {
  final List<IncomingPaymentEntity>? incomingPayments;
  final FormSubmissionStatus scannedQrStatus;
  final String customCode;
  final String customMessage;
  final FormSubmissionStatus formStatus;
  final String customMessageEs;
  final FundingEntity? fundingEntity;

  const FundingState({
    this.incomingPayments,
    this.customCode = '',
    this.customMessage = '',
    this.formStatus = const InitialFormStatus(),
    this.customMessageEs = '',
    this.scannedQrStatus = const InitialFormStatus(),
    this.fundingEntity,
  });

  FundingState copyWith({
    List<IncomingPaymentEntity>? incomingPayments,
    String? customCode,
    String? customMessage,
    FormSubmissionStatus? formStatus,
    final String? customMessageEs,
    final FormSubmissionStatus? scannedQrStatus,
    final FundingEntity? fundingEntity,
  }) =>
      FundingState(
        customCode: customCode ?? this.customCode,
        customMessage: customMessage ?? this.customMessage,
        formStatus: formStatus ?? this.formStatus,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        scannedQrStatus: scannedQrStatus ?? this.scannedQrStatus,
        incomingPayments: incomingPayments ?? this.incomingPayments,
        fundingEntity: fundingEntity ?? this.fundingEntity,
      );

  FundingState initialState() => const FundingState(
        customCode: '',
        customMessage: '',
        formStatus: InitialFormStatus(),
        customMessageEs: '',
        scannedQrStatus: InitialFormStatus(),
        incomingPayments: null,
        fundingEntity: null,
      );

  @override
  List<Object?> get props => [
        customCode,
        customMessage,
        formStatus,
        customMessageEs,
        scannedQrStatus,
        incomingPayments,
        fundingEntity,
      ];
}
