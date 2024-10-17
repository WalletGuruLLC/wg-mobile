import 'package:kiwi/kiwi.dart';

import 'injector_imports.dart';

part 'injector.g.dart';

abstract class Injector {
  static KiwiContainer container = KiwiContainer();
  static void setup() {
    var injector = _$Injector();
    injector._configure();
  }

  static final resolve = container.resolve;

//The repositories and their implementation, the use case and the datasource must always be registered.
  //If two or more use cases depend on the same repositories and datasource, only the new use case should be registered, since the rest will already be registered.

  //When you finish registering the new use case, you must run the following command in the console
  // flutter packages pub run build_runner build
  //If it fails, you must run the following command
  // flutter packages pub run build_runner build --delete-conflicting-outputs
  //The second command will overwrite the injector.g.dart file if necessary

  //A new factory configuration must be created every time there is a new repository and datasource.
  void _configure() {
    _configureRegisterModule();
    _configureLoginModule();
    _configureCreateWalletModule();
    _configureCreateProfileModule();
    _configureUserModule();
    _configureTranslationsErrorModule();
    _configureSettingsrModule();
    _configureSendPaymentModule();
    _configureTransactionsModule();
    _configureFundingModule();
    _configureDepositModule();
    _configurePushNotificationModule();
  }

  void _configureRegisterModule() {
    _configureRegisterFactories();
  }

  void _configureLoginModule() {
    _configureLoginFactories();
  }

  void _configureCreateProfileModule() {
    _configureCreateProfileFactories();
  }

  void _configureCreateWalletModule() {
    _configureCreateWalletFactories();
  }

  void _configureUserModule() {
    _configureUserModuleFactories();
  }

  void _configureTranslationsErrorModule() {
    _configureTranslationsErrorModuleFactories();
  }

  void _configureSettingsrModule() {
    _configureSettingsrModuleFactories();
  }

  void _configureSendPaymentModule() {
    _configureSendPaymentFactories();
  }

  void _configureTransactionsModule() {
    _configureTransactionsFactories();
  }

  void _configureDepositModule() {
    _configureDepositFactories();
  }
  void _configurePushNotificationModule() {
    _configurePushNotificationFactories();
  }

  void _configureFundingModule() {
    _configureFundingFactories();
  }

  @Register.factory(RegisterDataSource)
  @Register.factory(RegisterRepository, from: RegisterRepositoryImpl)
  void _configureRegisterFactories();

  @Register.factory(LoginDataSource)
  @Register.factory(LoginRepository, from: LoginRepositoryImpl)
  void _configureLoginFactories();

  @Register.factory(CreateWalletDataSource)
  @Register.factory(CreateWalletRepository, from: CreateWalletRepositoryImpl)
  void _configureCreateWalletFactories();

  @Register.factory(CreateProfileDataSource)
  @Register.factory(CreateProfileRepository, from: CreateProfileRepositoryImpl)
  void _configureCreateProfileFactories();

  @Register.factory(UserDataSource)
  @Register.factory(UserRepository, from: UserRepositoryImpl)
  void _configureUserModuleFactories();

  @Register.factory(TranslationsErrorDataSources)
  @Register.factory(TranslationsErrorRepository,
      from: TranslationsErrorRepositoryImpl)
  void _configureTranslationsErrorModuleFactories();

  @Register.factory(SettingsDataSource)
  @Register.factory(SettingsRepository, from: SettingsRepositoryImpl)
  void _configureSettingsrModuleFactories();

  @Register.factory(SendPaymentDataSource)
  @Register.factory(SendPaymentRepository, from: SendPaymentRepositoryImpl)
  void _configureSendPaymentFactories();

  @Register.factory(TransactionDataSource)
  @Register.factory(TransactionRepository, from: TransactionRepositoryImpl)
  void _configureTransactionsFactories();

  @Register.factory(FundingDataSource)
  @Register.factory(FundingRepository, from: FundingRepositoryImpl)
  void _configureFundingFactories();

  @Register.factory(DepositDataSource)
  @Register.factory(DepositRepository, from: DepositRepositoryImpl)
  void _configureDepositFactories();
  
  @Register.factory(FirebaseMessagingDatasource)
  @Register.factory(PushNotificationRepository, from: PushNotificationRepositoryImpl)
  @Register.factory(InitializePushNotifications)
  void _configurePushNotificationFactories();
}
