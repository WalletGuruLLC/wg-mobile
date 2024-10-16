import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/domain/core/entities/incoming_payments_entity.dart';
import 'package:wallet_guru/domain/funding/funding_repository.dart';
import 'package:wallet_guru/domain/core/entities/funding_entity.dart';

import 'package:wallet_guru/infrastructure/core/injector/injector.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';

part 'funding_state.dart';

class FundingCubit extends Cubit<FundingState> {
  FundingCubit() : super(const FundingState());
  final fundingRepository = Injector.resolve<FundingRepository>();

  void emitGetListIncomingPayment() async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    final incomingPaymentsResponse =
        await fundingRepository.getListOfIncomingPayments();
    incomingPaymentsResponse.fold(
      (error) {
        emit(state.copyWith(
          formStatus: SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (success) {
        emit(state.copyWith(
          formStatus: SubmissionSuccess(),
          incomingPayments: success.data!.incomingPayments!
              .map((incomingPayment) =>
                  IncomingPaymentEntity.fromIncomingPayment(incomingPayment))
              .toList(),
        ));
      },
    );
  }

  void emitLinkServerProvider() async {
    emit(state.copyWith(scannedQrStatus: FormSubmitting()));
    final linkServerProviderResponse =
        await fundingRepository.linkServerProvider(state.fundingEntity!);
    linkServerProviderResponse.fold(
      (error) {
        emit(state.copyWith(
          scannedQrStatus:
              SubmissionFailed(exception: Exception(error.messageEn)),
          customCode: error.code,
          customMessage: error.messageEn,
          customMessageEs: error.messageEs,
        ));
      },
      (success) {
        emit(state.copyWith(
          scannedQrStatus: SubmissionSuccess(),
        ));
      },
    );
  }

  void resetFundingEntity() {
    emit(
      state.copyWith(
        fundingEntity: FundingEntity.empty(),
      ),
    );
  }

  void resetFundingQrStatus() {
    emit(
      state.copyWith(scannedQrStatus: const InitialFormStatus()),
    );
  }

  void updateFundingEntity({
    String? walletAddressUrl,
    String? rafikiWalletAddress,
    double? amountToAddFund,
  }) {
    final updatedFundingEntity = _getOrCreateFundingEntity().copyWith(
      walletAddressUrl: walletAddressUrl,
      rafikiWalletAddress: rafikiWalletAddress,
      amountToAddFund: amountToAddFund,
      sessionId: walletAddressUrl != null && walletAddressUrl.isNotEmpty
          ? FundingEntity.extractSessionIdFromUrl(walletAddressUrl)
          : null,
    );
    emit(state.copyWith(fundingEntity: updatedFundingEntity));
  }

  FundingEntity _getOrCreateFundingEntity() {
    return state.fundingEntity ??
        FundingEntity(
          walletAddressUrl: '',
          rafikiWalletAddress: '',
          amountToAddFund: 0,
        );
  }

  // void createServiceProviderPayment() async {
  //   emit(state.copyWith(formStatus: FormSubmitting()));
  //   final createdServiceProviderPaymentResponse =
  //       await fundingRepository.createServiceProviderPayment();
  // }
}
