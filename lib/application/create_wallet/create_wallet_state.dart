part of 'create_wallet_cubit.dart';

class CreateWalletState extends Equatable {
  final String walletName;
  final String walletAddress;
  final String walletType;
  final FormSubmissionStatus formStatus;
  final String customMessage;
  final String customMessageEs;

  const CreateWalletState({
    this.walletName = '',
    this.customMessage = '',
    this.customMessageEs = '',
    this.formStatus = const InitialFormStatus(),
    this.walletType = 'White Brand',
    this.walletAddress = 'http://address.whitelabel.co',
  });

  CreateWalletState copyWith({
    String? walletName,
    FormSubmissionStatus? formStatus,
    String? customMessage,
    String? customMessageEs,
    String? walletType,
    String? walletAddress,
  }) =>
      CreateWalletState(
        walletName: walletName ?? this.walletName,
        formStatus: formStatus ?? this.formStatus,
        customMessage: customMessage ?? this.customMessage,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        walletType: walletType ?? this.walletType,
        walletAddress: walletAddress ?? this.walletAddress,
      );

  CreateWalletState initialState() => const CreateWalletState(
        walletName: '',
        formStatus: InitialFormStatus(),
        customMessage: '',
        customMessageEs: '',
        walletType: 'White Brand',
        walletAddress: 'http://address.whitelabel.co',
      );

  @override
  List<Object> get props => [
        walletName,
        formStatus,
        customMessage,
        customMessageEs,
        walletType,
        walletAddress,
      ];
}
