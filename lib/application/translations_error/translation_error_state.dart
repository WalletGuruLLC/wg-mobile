import 'package:wallet_guru/domain/translations_error/models/translation_error_model.dart';

abstract class TranslationErrorState {}

class TranslationInitial extends TranslationErrorState {}

class TranslationLoading extends TranslationErrorState {}

class TranslationLoaded extends TranslationErrorState {
  final List<TranslationErrorModel> translations;

  TranslationLoaded(this.translations);
}

class TranslationError extends TranslationErrorState {
  final String message;

  TranslationError(this.message);
}
