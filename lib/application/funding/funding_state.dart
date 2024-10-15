part of 'funding_cubit.dart';

class FundingState extends Equatable {
  final FormSubmissionStatus scannedQrStatus;
  final String customCode;
  final String customMessage;
  final FormSubmissionStatus formStatus;
  final String customMessageEs;

  const FundingState({
    this.customCode = '',
    this.customMessage = '',
    this.formStatus = const InitialFormStatus(),
    this.customMessageEs = '',
    this.scannedQrStatus = const InitialFormStatus(),
  });

  FundingState copyWith({
    String? customCode,
    String? customMessage,
    FormSubmissionStatus? formStatus,
    final String? customMessageEs,
    final FormSubmissionStatus? scannedQrStatus,
  }) =>
      FundingState(
        customCode: customCode ?? this.customCode,
        customMessage: customMessage ?? this.customMessage,
        formStatus: formStatus ?? this.formStatus,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        scannedQrStatus: scannedQrStatus ?? this.scannedQrStatus,
      );

  FundingState initialState() => const FundingState(
        customCode: '',
        customMessage: '',
        formStatus: InitialFormStatus(),
        customMessageEs: '',
        scannedQrStatus: InitialFormStatus(),
      );

  @override
  List<Object> get props => [
        customCode,
        customMessage,
        formStatus,
        customMessageEs,
        scannedQrStatus,
      ];
}
