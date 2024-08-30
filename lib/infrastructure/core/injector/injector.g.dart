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
}
