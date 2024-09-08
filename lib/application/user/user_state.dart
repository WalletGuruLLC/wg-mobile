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
  final String? newPassword;

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
    this.newPassword,
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
      ];
}
