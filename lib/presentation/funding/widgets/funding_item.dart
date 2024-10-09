import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class FundingItem extends StatelessWidget {
  final String title;
  final int amount;

  const FundingItem({super.key, required this.title, required this.amount});

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
            text: '$amount USD',
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
                            trailing: const Icon(Icons.add_circle_outline,
                                color: Colors.black),
                            title: TextBase(
                              text: l10n.addFundsFundingItem,
                              fontSize: size.width * 0.03,
                              color: Colors.black,
                            ),
                            onTap: () {
                              GoRouter.of(context).go(
                                Routes.addFundsProvider.path,
                                extra: {
                                  "title": "Sabbatical ",
                                },
                              );
                            },
                          ),
                          const Divider(),
                          ListTile(
                            trailing:
                                const Icon(Icons.remove, color: Colors.black),
                            title: TextBase(
                              text: l10n.withdrawFundingItem,
                              fontSize: size.width * 0.03,
                              color: Colors.black,
                            ),
                            onTap: () {
                              GoRouter.of(context).go(
                                Routes.withdrawPage.path,
                                extra: {
                                  "title": "Sabbatical ",
                                },
                              );
                            },
                          ),
                          const Divider(),
                          ListTile(
                            trailing: const Icon(Icons.info_outline,
                                color: Colors.black),
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
}
