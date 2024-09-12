import 'package:either_dart/either.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/translations_error/models/translation_error_model.dart';

abstract class TranslationsErrorRepository {
  Future<Either<InvalidData, List<TranslationErrorModel>>>
      getTranslationsErrors(String lang);
}
