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
}
