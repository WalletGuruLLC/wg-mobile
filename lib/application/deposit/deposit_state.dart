part of 'deposit_cubit.dart';

class DepositState extends Equatable {
  final String walletAddressId;
  final int assetId;
  final FormSubmissionStatus formStatus;
  final String customMessage;
  final String customMessageEs;
  final String customCode;
  
  const DepositState({
    this.walletAddressId = '',
    this.customMessage = '',
    this.customMessageEs = '',
    this.formStatus = const InitialFormStatus(),
    this.assetId = 0,
    this.customCode = '',
    
  });

  DepositState copyWith({
    String? walletAddressId,
    FormSubmissionStatus? formStatus,
    String? customMessage,
    String? customMessageEs,
    String? walletType,
    int? assetId,
    String? customCode,
  }) =>
      DepositState(
        walletAddressId: walletAddressId ?? this.walletAddressId,
        formStatus: formStatus ?? this.formStatus,
        customMessage: customMessage ?? this.customMessage,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        assetId: assetId ?? this.assetId,
        customCode: customCode ?? this.customCode,
      );

  DepositState initialState() => const DepositState(
        walletAddressId: '',
        formStatus: InitialFormStatus(),
        customMessage: '',
        customMessageEs: '',
        assetId: 0,
        customCode: '',
      );

  @override
  List<Object> get props => [
        walletAddressId,
        formStatus,
        customMessage,
        customMessageEs,
        assetId,
        customCode,
      ];
}
