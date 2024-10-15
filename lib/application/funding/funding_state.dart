part of 'funding_cubit.dart';

class FundingState extends Equatable {
  final String customCode;
  final String customMessage;
  final FormSubmissionStatus formStatus;
  final String customMessageEs;

  const FundingState({
    this.customCode = '',
    this.customMessage = '',
    this.formStatus = const InitialFormStatus(),
    this.customMessageEs = '',
  });

  FundingState copyWith({
    String? customCode,
    String? customMessage,
    FormSubmissionStatus? formStatus,
    final String? customMessageEs,
  }) =>
      FundingState(
        customCode: customCode ?? this.customCode,
        customMessage: customMessage ?? this.customMessage,
        formStatus: formStatus ?? this.formStatus,
        customMessageEs: customMessageEs ?? this.customMessageEs,
      );

  FundingState initialState() => const FundingState(
        customCode: '',
        customMessage: '',
        formStatus: InitialFormStatus(),
        customMessageEs: '',
      );

  @override
  List<Object> get props => [
        customCode,
        customMessage,
        formStatus,
        customMessageEs,
      ];
}
