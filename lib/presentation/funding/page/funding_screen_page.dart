import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
<<<<<<< HEAD
=======

>>>>>>> PWG-867-app-integrate-remove-quotes
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/application/deposit/deposit_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
<<<<<<< HEAD
import 'package:wallet_guru/presentation/funding/widget/funding_screen_view.dart';
=======
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/presentation/funding/widgets/funding_item.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/presentation/funding/widgets/card_funding_widget.dart';
import 'package:wallet_guru/domain/send_payment/models/incoming_payment_model.dart';
import 'package:wallet_guru/presentation/core/widgets/stripe_separators_widget.dart';
>>>>>>> PWG-867-app-integrate-remove-quotes

class FundingScreenPage extends StatefulWidget {
  const FundingScreenPage({super.key});

  @override
  State<FundingScreenPage> createState() => _FundingScreenPageState();
}

class _FundingScreenPageState extends State<FundingScreenPage> {
  @override
  void initState() {
    super.initState();
    String walletAddress =
        BlocProvider.of<UserCubit>(context).state.wallet!.walletDb.rafikiId;
    BlocProvider.of<DepositCubit>(context).emitwalletId(walletAddress);
    BlocProvider.of<SendPaymentCubit>(context).emitGetListIncomingPayment();
  }

  Map<String, ({double totalAmount, List<String> ids})> _groupAndSumPayments(
      List<IncomingPaymentModel> payments) {
    Map<String, ({double totalAmount, List<String> ids})> groupedPayments = {};
    for (var payment in payments) {
      if (groupedPayments.containsKey(payment.provider)) {
        var existing = groupedPayments[payment.provider]!;
        groupedPayments[payment.provider] = (
          totalAmount: existing.totalAmount + payment.incomingAmount.value,
          ids: [...existing.ids, payment.id]
        );
      } else {
        groupedPayments[payment.provider] =
            (totalAmount: payment.incomingAmount.value, ids: [payment.id]);
      }
    }
    return groupedPayments;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: WalletGuruLayout(
        showSafeArea: true,
        showSimpleStyle: false,
        showLoggedUserAppBar: true,
        showBottomNavigationBar: false,
        actionAppBar: () {
          GoRouter.of(context).pushReplacementNamed(
            Routes.home.name,
          );
        },
        pageAppBarTitle: l10n.fundingTitelPage,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SizedBox(
              width: size.width * 0.90,
              height: size.height * 0.80,
              child: Column(
                children: [
                  const CardFundingWidget(),
                  const SizedBox(height: 20),
                  BlocConsumer<SendPaymentCubit, SendPaymentState>(
                    listener: (context, state) {
                      if (state.formStatusincomingPayments
                          is SubmissionFailed) {
                        GoRouter.of(context).pushReplacementNamed(
                          Routes.errorScreen.name,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state.formStatusincomingPayments is FormSubmitting) {
                        return const Column(
                          children: [
                            SizedBox(height: 20),
                            CircularProgressIndicator(),
                          ],
                        );
                      } else if (state.formStatusincomingPayments
                          is SubmissionSuccess) {
                        final groupedPayments =
                            _groupAndSumPayments(state.incomingPayments!);
                        return Column(
                          children: groupedPayments.entries.map((entry) {
                            return Column(
                              children: [
                                FundingItem(
                                  title: entry.key,
                                  amount: entry.value.totalAmount.toString(),
                                  incomingPaymentIds: entry.value.ids,
                                ),
                                const StripeSeparatorsWidget(),
                              ],
                            );
                          }).toList(),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
