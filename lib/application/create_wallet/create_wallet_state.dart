part of 'create_wallet_cubit.dart';

class CreateWalletState extends Equatable {
  final String addressName;
  final String assetId;
  final FormSubmissionStatus formStatus;
  final String customMessage;
  final String customMessageEs;
  final String customCode;

  const CreateWalletState({
    this.addressName = '',
    this.customMessage = '',
    this.customMessageEs = '',
    this.formStatus = const InitialFormStatus(),
    this.assetId = '',
    this.customCode = '',
  });

  CreateWalletState copyWith({
    String? addressName,
    FormSubmissionStatus? formStatus,
    String? customMessage,
    String? customMessageEs,
    String? walletType,
    String? assetId,
    String? customCode,
  }) =>
      CreateWalletState(
        addressName: addressName ?? this.addressName,
        formStatus: formStatus ?? this.formStatus,
        customMessage: customMessage ?? this.customMessage,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        assetId: assetId ?? this.assetId,
        customCode: customCode ?? this.customCode,
      );

  CreateWalletState initialState() => const CreateWalletState(
        addressName: '',
        formStatus: InitialFormStatus(),
        customMessage: '',
        customMessageEs: '',
        assetId: '',
        customCode: '',
      );

  @override
  List<Object> get props => [
        addressName,
        formStatus,
        customMessage,
        customMessageEs,
        assetId,
        customCode,
      ];
}
