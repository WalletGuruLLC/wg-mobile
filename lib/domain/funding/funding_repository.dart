import 'package:either_dart/either.dart';

import 'package:wallet_guru/domain/core/models/invalid_data.dart';
import 'package:wallet_guru/domain/core/models/response_model.dart';

abstract class FundingRepository {
  Future<Either<InvalidData, ResponseModel>> getListOfIncomingPayments();
}
