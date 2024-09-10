part of 'user_cubit.dart';

class UserState extends Equatable {
  final UserEntity? user;
  final String customCode;
  final String customMessage;
  final FormSubmissionStatus formStatus;
  final String customMessageEs;
  final String userId;
  final bool userHasChanged;
  final UserEntity? initialUser;
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  final bool isSubmittable;
  final FormSubmissionStatus formStatusLockAccount;

  const UserState({
    this.user,
    this.customCode = '',
    this.customMessage = '',
    this.formStatus = const InitialFormStatus(),
    this.customMessageEs = '',
    this.userId = '',
    this.userHasChanged = false,
    this.initialUser,
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmNewPassword = '',
    this.isSubmittable = false,
    this.formStatusLockAccount = const InitialFormStatus(),
  });

  UserState copyWith({
    String? customCode,
    String? customMessage,
    FormSubmissionStatus? formStatus,
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
  }) =>
      UserState(
        user: user ?? this.user,
        customCode: customCode ?? this.customCode,
        customMessage: customMessage ?? this.customMessage,
        formStatus: formStatus ?? this.formStatus,
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
      );

  @override
  List<Object?> get props => [
        customCode,
        customMessage,
        formStatus,
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
      ];
}
