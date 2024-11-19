import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';

import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/funding/widgets/modal_helpers.dart';

class FundingItem extends StatelessWidget {
  final String title;
  final String amount;
  final List<String> incomingPaymentIds;
  final String sessionId;

  const FundingItem({
    super.key,
    required this.title,
    required this.amount,
    required this.incomingPaymentIds,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return ListTile(
      title: TextBase(
        text: title,
        fontSize: size.width * 0.04,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextBase(
            text: "${toCurrencyString(amount, leadingSymbol: '\$')} USD",
            fontSize: size.width * 0.04,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(32))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          ListTile(
                            trailing: SvgPicture.asset(
                              Assets.sum,
                            ),
                            title: TextBase(
                              text: l10n.addFundsFundingItem,
                              fontSize: size.width * 0.03,
                              color: Colors.black,
                            ),
                            onTap: () {
                              GoRouter.of(context).go(
                                Routes.addFundsProvider.path,
                                extra: {
                                  "title": title,
                                },
                              );
                            },
                          ),
                          const Divider(),
                          ListTile(
                            trailing: SvgPicture.asset(
                              Assets.empty,
                            ),
                            title: TextBase(
                              text: l10n.withdrawFundingItem,
                              fontSize: size.width * 0.03,
                              color: Colors.black,
                            ),
                            onTap: () {
                              GoRouter.of(context).go(
                                Routes.withdrawPage.path,
                                extra: {
                                  "totalAmount": amount,
                                  "listProvider": incomingPaymentIds,
                                },
                              );
                            },
                          ),
                          const Divider(),
                          ListTile(
                            trailing: SvgPicture.asset(
                              Assets.myInfo,
                            ),
                            title: TextBase(
                              text: l10n.detailsFundingItem,
                              fontSize: size.width * 0.03,
                              color: Colors.black,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              // Lógica para mostrar detalles
                            },
                          ),
                          const Divider(),
                          ListTile(
                            trailing: SvgPicture.asset(
                              Assets.unlink,
                            ),
                            title: TextBase(
                              text: l10n.unlink,
                              fontSize: size.width * 0.03,
                              color: Colors.black,
                            ),
                            onTap: () {
                              ModalHelper(context)
                                  .buildConfirmationModal(sessionId);
                            },
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildSuccessfulModal(
      String amount, String providerName, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BaseModal(
          buttonText: "OK",
          buttonWidth: size.width * 0.4,
          content: Column(
            children: [
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.successFundsTitle,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size.height * 0.01),
              TextBase(
                textAlign: TextAlign.center,
                text:
                    '${l10n.successFundsText}$amount ${l10n.successFundsTextAccount} $providerName',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
            GoRouter.of(context).pushReplacementNamed(Routes.home.name);
          },
        );
      },
    );
  }
}
