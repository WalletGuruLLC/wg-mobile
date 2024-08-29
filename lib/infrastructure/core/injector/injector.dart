import 'package:wallet_guru/domain/login/repositories/login_repository.dart';
import 'package:wallet_guru/domain/register/repositories/register_repository.dart';
import 'package:wallet_guru/infrastructure/login/data_sources/login_data_sources.dart';
import 'package:wallet_guru/infrastructure/login/repositories/login_repository_impl.dart';
import 'package:wallet_guru/infrastructure/register/data_sources/register_data_source.dart';
import 'package:wallet_guru/domain/create_profile/repositories/create_profile_repository.dart';
import 'package:wallet_guru/infrastructure/register/repositories/register_repository_impl.dart';
import 'package:wallet_guru/infrastructure/create_profile/data_sources/create_profile_data_source.dart';
import 'package:wallet_guru/infrastructure/create_profile/repositories/create_profile_repository_impl.dart';

import 'package:kiwi/kiwi.dart';

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
    _configureCreateProfileModule();
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

  @Register.factory(RegisterDataSource)
  @Register.factory(RegisterRepository, from: RegisterRepositoryImpl)
  void _configureRegisterFactories();

  @Register.factory(LoginDataSource)
  @Register.factory(LoginRepository, from: LoginRepositoryImpl)
  void _configureLoginFactories();
  
  @Register.factory(CreateProfileDataSource)
  @Register.factory(CreateProfileRepository, from: CreateProfileRepositoryImpl)
  void _configureCreateProfileFactories();
}
