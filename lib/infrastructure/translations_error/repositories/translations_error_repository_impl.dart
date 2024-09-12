import 'package:either_dart/either.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/translations_error/models/translation_error_model.dart';
import 'package:wallet_guru/domain/translations_error/repositories/translations_error_repository.dart';
import 'package:wallet_guru/infrastructure/translations_error/data_sources/translations_error_data_sources.dart';

class TranslationsErrorRepositoryImpl extends TranslationsErrorRepository {
  final TranslationsErrorDataSources translationsErrorDataSources;

  TranslationsErrorRepositoryImpl({
    required this.translationsErrorDataSources,
  });

  @override
  Future<Either<InvalidData, List<TranslationErrorModel>>>
      getTranslationsErrors(String lang) async {
    try {
      final List<TranslationErrorModel> response =
          await translationsErrorDataSources.getTranslationsErrors(lang);
      return Right(response);
    } on InvalidData catch (invalidData) {
      return Left(invalidData);
    }
  }
}
