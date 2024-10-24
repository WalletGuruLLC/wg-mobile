// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureRegisterFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => RegisterDataSource())
      ..registerFactory<RegisterRepository>((c) => RegisterRepositoryImpl(
          registerDataSource: c.resolve<RegisterDataSource>()));
  }

  @override
  void _configureLoginFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => LoginDataSource())
      ..registerFactory<LoginRepository>((c) =>
          LoginRepositoryImpl(loginDataSource: c.resolve<LoginDataSource>()));
  }

  @override
  void _configureCreateWalletFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => CreateWalletDataSource())
      ..registerFactory<CreateWalletRepository>((c) =>
          CreateWalletRepositoryImpl(
              createWalletDataSources: c.resolve<CreateWalletDataSource>()));
  }

  @override
  void _configureCreateProfileFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => CreateProfileDataSource())
      ..registerFactory<CreateProfileRepository>((c) =>
          CreateProfileRepositoryImpl(
              registerDataSource: c.resolve<CreateProfileDataSource>()));
  }

  @override
  void _configureUserModuleFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => UserDataSource())
      ..registerFactory<UserRepository>((c) =>
          UserRepositoryImpl(userDataSource: c.resolve<UserDataSource>()));
  }

  @override
  void _configureTranslationsErrorModuleFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => TranslationsErrorDataSources())
      ..registerFactory<TranslationsErrorRepository>((c) =>
          TranslationsErrorRepositoryImpl(
              translationsErrorDataSources:
                  c.resolve<TranslationsErrorDataSources>()));
  }

  @override
  void _configureSettingsrModuleFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => SettingsDataSource())
      ..registerFactory<SettingsRepository>((c) => SettingsRepositoryImpl(
          settingsDataSource: c.resolve<SettingsDataSource>()));
  }

  @override
  void _configureSendPaymentFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => SendPaymentDataSource())
      ..registerFactory<SendPaymentRepository>((c) => SendPaymentRepositoryImpl(
          sendPaymentDataSources: c.resolve<SendPaymentDataSource>()));
  }

  @override
  void _configureTransactionsFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => TransactionDataSource())
      ..registerFactory<TransactionRepository>((c) => TransactionRepositoryImpl(
          transactionDataSource: c.resolve<TransactionDataSource>()));
  }

  @override
  void _configureFundingFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => FundingDataSource())
      ..registerFactory<FundingRepository>((c) => FundingRepositoryImpl(
          fundingDataSource: c.resolve<FundingDataSource>()));
  }

  @override
  void _configureDepositFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => DepositDataSource())
      ..registerFactory<DepositRepository>((c) => DepositRepositoryImpl(
          depositDataSource: c.resolve<DepositDataSource>()));
  }

  @override
  void _configurePushNotificationFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => FirebaseMessagingDatasource())
      ..registerFactory<PushNotificationRepository>((c) =>
          PushNotificationRepositoryImpl(
              c.resolve<FirebaseMessagingDatasource>()))
      ..registerFactory((c) =>
          InitializePushNotifications(c.resolve<PushNotificationRepository>()))
      ..registerFactory((c) =>
          GetPushNotificationToken(c.resolve<PushNotificationRepository>()))
      ..registerFactory(
          (c) => SubscribeToTopic(c.resolve<PushNotificationRepository>()))
      ..registerFactory(
          (c) => UnsubscribeFromTopic(c.resolve<PushNotificationRepository>()))
      ..registerFactory((c) => PushNotificationCubit());
  }

  @override
  void _configureWebSocketFactories() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton<IWebSocketService>((c) => SocketIOService());
  }
}
