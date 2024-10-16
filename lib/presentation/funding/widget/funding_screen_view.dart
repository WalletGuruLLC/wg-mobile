// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
// import 'package:wallet_guru/application/funding/funding_cubit.dart';
// import 'package:wallet_guru/application/user/user_cubit.dart';
// import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
// import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
// import 'package:wallet_guru/presentation/funding/page/add_funding_page.dart';
// import 'package:wallet_guru/presentation/funding/widgets/funding_item.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class FundingScreenView extends StatefulWidget {
//   const FundingScreenView({super.key});

//   @override
//   State<FundingScreenView> createState() => _FundingScreenViewState();
// }

// class _FundingScreenViewState extends State<FundingScreenView> {
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<FundingCubit>(context).resetFundingQrStatus();
//     BlocProvider.of<FundingCubit>(context).resetFundingEntity();
//     BlocProvider.of<FundingCubit>(context).emitGetListIncomingPayment();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context)!;
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           decoration: BoxDecoration(
//             color: Colors.grey[900],
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: BlocBuilder<UserCubit, UserState>(
//             builder: (context, state) {
//               if (state.formStatusWallet is SubmissionSuccess) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextBase(
//                       text:
//                           "${toCurrencyString(state.availableFunds.toString(), leadingSymbol: '\$')} USD",
//                       fontSize: size.width * 0.07,
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.add, color: Colors.white),
//                       onPressed: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const AddFundingPage()),
//                       ),
//                     ),
//                   ],
//                 );
//               } else if (state.formStatusWallet is FormSubmitting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//         ),
//         const FundingItem(title: 'Sabbatical', amount: 30),
//         const FundingItem(title: 'Netflix', amount: 10),
//       ],
//     );
//   }
// }
