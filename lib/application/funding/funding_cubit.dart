import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/domain/funding/funding_repository.dart';

import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';

part 'funding_state.dart';

class FundingCubit extends Cubit<FundingState> {
  FundingCubit() : super(const FundingState());
  final fundingRepository = Injector.resolve<FundingRepository>();

  void emitGetListIncomingPayment() async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    final registerResponse =
        await fundingRepository.getListOfIncomingPayments();
    registerResponse.fold(
      (error) {
        emit(state.copyWith(
          formStatus: SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (createUser) {
        emit(state.copyWith(
          formStatus: SubmissionSuccess(),
        ));
      },
    );
  }

  void emitLinkServerProvider(
      String walletAddressUrl, String walletAddressId) async {
    emit(state.copyWith(scannedQrStatus: FormSubmitting()));
    final registerResponse = await fundingRepository.linkServerProvider(
        walletAddressUrl, walletAddressId);
    registerResponse.fold(
      (error) {
        emit(state.copyWith(
          scannedQrStatus:
              SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (createUser) {
        emit(state.copyWith(
          scannedQrStatus: SubmissionSuccess(),
        ));
      },
    );
  }
}
