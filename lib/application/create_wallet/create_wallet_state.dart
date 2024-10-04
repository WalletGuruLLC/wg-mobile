part of 'create_wallet_cubit.dart';

class CreateWalletState extends Equatable {
  final String addressName;
  final String assetId;
  final FormSubmissionStatus formStatus;
  final String customMessage;
  final String customMessageEs;
  final String customCode;
  final List<RafikiAssets>? rafikiAssets;
  final bool fetchWalletAsset;
  final bool activateButton;

  const CreateWalletState({
    this.addressName = '',
    this.customMessage = '',
    this.customMessageEs = '',
    this.formStatus = const InitialFormStatus(),
    this.assetId = '',
    this.customCode = '',
    this.rafikiAssets,
    this.fetchWalletAsset = false,
    this.activateButton = false,
  });

  CreateWalletState copyWith({
    String? addressName,
    FormSubmissionStatus? formStatus,
    String? customMessage,
    String? customMessageEs,
    String? walletType,
    String? assetId,
    String? customCode,
    List<RafikiAssets>? rafikiAssets,
    bool? fetchWalletAsset,
    bool? activateButton,
  }) =>
      CreateWalletState(
        addressName: addressName ?? this.addressName,
        formStatus: formStatus ?? this.formStatus,
        customMessage: customMessage ?? this.customMessage,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        assetId: assetId ?? this.assetId,
        customCode: customCode ?? this.customCode,
        rafikiAssets: rafikiAssets ?? this.rafikiAssets,
        fetchWalletAsset: fetchWalletAsset ?? this.fetchWalletAsset,
        activateButton: activateButton ?? this.activateButton,
      );

  CreateWalletState initialState() => const CreateWalletState(
        addressName: '',
        formStatus: InitialFormStatus(),
        customMessage: '',
        customMessageEs: '',
        assetId: '',
        customCode: '',
        rafikiAssets: null,
        fetchWalletAsset: false,
        activateButton: false,
      );

  @override
  List<Object> get props => [
        addressName,
        formStatus,
        customMessage,
        customMessageEs,
        assetId,
        customCode,
        rafikiAssets ?? [],
        fetchWalletAsset,
        activateButton,
      ];
}
