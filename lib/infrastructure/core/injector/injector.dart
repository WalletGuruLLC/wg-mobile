import 'package:kiwi/kiwi.dart';
import 'package:wallet_guru/domain/send_payment/repositories/send_payment_repository.dart';
import 'package:wallet_guru/domain/settings/repositories/settings_repository.dart';
import 'package:wallet_guru/domain/transactions/repositories/transaction_repository.dart';

import 'package:wallet_guru/domain/user/repositories/user_repository.dart';
import 'package:wallet_guru/domain/login/repositories/login_repository.dart';
import 'package:wallet_guru/domain/register/repositories/register_repository.dart';
import 'package:wallet_guru/infrastructure/send_payment/data_sources/send_payment_data_sources.dart';
import 'package:wallet_guru/infrastructure/send_payment/repositories/send_payment_repository_impl.dart';
import 'package:wallet_guru/infrastructure/settings/data_sources/settings_data_source.dart';
import 'package:wallet_guru/infrastructure/settings/repositories/settings_repository_impl.dart';
import 'package:wallet_guru/infrastructure/transactions/data_sources/transaction_data_source.dart';
import 'package:wallet_guru/infrastructure/transactions/repositories/transaction_repository_impl.dart';
import 'package:wallet_guru/infrastructure/user/data_sources/user_data_source.dart';
import 'package:wallet_guru/infrastructure/login/data_sources/login_data_sources.dart';
import 'package:wallet_guru/infrastructure/user/repositories/user_repository_impl.dart';
import 'package:wallet_guru/infrastructure/login/repositories/login_repository_impl.dart';
import 'package:wallet_guru/infrastructure/register/data_sources/register_data_source.dart';
import 'package:wallet_guru/domain/create_wallet/repositories/create_wallet_repository.dart';
import 'package:wallet_guru/domain/create_profile/repositories/create_profile_repository.dart';
import 'package:wallet_guru/infrastructure/register/repositories/register_repository_impl.dart';
import 'package:wallet_guru/infrastructure/create_wallet/data_sources/create_wallet_data_sources.dart';
import 'package:wallet_guru/domain/translations_error/repositories/translations_error_repository.dart';
import 'package:wallet_guru/infrastructure/create_profile/data_sources/create_profile_data_source.dart';
import 'package:wallet_guru/infrastructure/create_wallet/repositories/create_wallet_repository_impl.dart';
import 'package:wallet_guru/infrastructure/create_profile/repositories/create_profile_repository_impl.dart';
import 'package:wallet_guru/infrastructure/translations_error/data_sources/translations_error_data_sources.dart';
import 'package:wallet_guru/infrastructure/translations_error/repositories/translations_error_repository_impl.dart';

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
}
