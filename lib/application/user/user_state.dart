part of 'user_cubit.dart';

class UserState extends Equatable {
  final UserEntity? user;
  final String customCode;
  final String customMessage;
  final FormSubmissionStatus formStatus;
  final FormSubmissionStatus formStatusWallet;
  final String customMessageEs;
  final String userId;
  final bool userHasChanged;
  final UserEntity? initialUser;
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  final bool isSubmittable;
  final FormSubmissionStatus formStatusLockAccount;
  final WalletEntity? wallet;
  final double availableFunds;
  final double balance;

  const UserState({
    this.user,
    this.customCode = '',
    this.customMessage = '',
    this.formStatus = const InitialFormStatus(),
    this.formStatusWallet = const InitialFormStatus(),
    this.customMessageEs = '',
    this.userId = '',
    this.userHasChanged = false,
    this.initialUser,
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmNewPassword = '',
    this.isSubmittable = false,
    this.formStatusLockAccount = const InitialFormStatus(),
    this.wallet,
    this.availableFunds = 0.0,
    this.balance = 0.0,
  });

  UserState copyWith({
    String? customCode,
    String? customMessage,
    FormSubmissionStatus? formStatus,
    FormSubmissionStatus? formStatusWallet,
    String? customMessageEs,
    UserEntity? user,
    String? userId,
    bool? userHasChanged,
    UserEntity? initialUser,
    String? currentPassword,
    String? newPassword,
    String? confirmNewPassword,
    bool? isSubmittable,
    FormSubmissionStatus? formStatusLockAccount,
    WalletEntity? wallet,
    double? availableFunds,
    double? balance,
  }) =>
      UserState(
        user: user ?? this.user,
        customCode: customCode ?? this.customCode,
        customMessage: customMessage ?? this.customMessage,
        formStatus: formStatus ?? this.formStatus,
        formStatusWallet: formStatusWallet ?? this.formStatusWallet,
        customMessageEs: customMessageEs ?? this.customMessageEs,
        userId: userId ?? this.userId,
        userHasChanged: userHasChanged ?? this.userHasChanged,
        initialUser: initialUser ?? this.initialUser,
        currentPassword: currentPassword ?? this.currentPassword,
        newPassword: newPassword ?? this.newPassword,
        confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
        isSubmittable: isSubmittable ?? this.isSubmittable,
        formStatusLockAccount:
            formStatusLockAccount ?? this.formStatusLockAccount,
        wallet: wallet ?? this.wallet,
        availableFunds: availableFunds ?? this.availableFunds,
        balance: balance ?? this.balance,
      );

  @override
  List<Object?> get props => [
        customCode,
        customMessage,
        formStatus,
        formStatusWallet,
        customMessageEs,
        user,
        userId,
        userHasChanged,
        initialUser,
        currentPassword,
        newPassword,
        confirmNewPassword,
        isSubmittable,
        formStatusLockAccount,
        wallet,
        availableFunds,
        balance,
      ];
}
