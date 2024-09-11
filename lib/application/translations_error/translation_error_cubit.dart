import 'package:flutter_bloc/flutter_bloc.dart';

import 'translation_error_state.dart';
import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/translations_error/repositories/translations_error_repository.dart';

class TranslationErrorCubit extends Cubit<TranslationErrorState> {
  final TranslationsErrorRepository translationsErrorRepository = Injector.resolve<TranslationsErrorRepository>();

  TranslationErrorCubit() : super(TranslationInitial());

  Future<void> loadTranslations(String lang) async {
    try {
      emit(TranslationLoading());
      final responseTranslations = await translationsErrorRepository.getTranslationsErrors(lang);
      responseTranslations.fold((error) {}, (success) {
        emit(TranslationLoaded(success));
      });
    } catch (e) {
      emit(TranslationError(e.toString()));
    }
  }
}
