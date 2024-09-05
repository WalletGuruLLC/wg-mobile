import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class WalletGuruAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? action;
  final bool showSimpleStyle;

  const WalletGuruAppBar({
    super.key,
    required this.title,
    required this.action,
    this.showSimpleStyle = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavigateBackButton(context, showSimpleStyle: showSimpleStyle),
            _buildTitle(title),
            showSimpleStyle
                ? _buildEmptyContainer()
                : _buildFourDotsButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String text) => TextBase(text: title, fontSize: 18);

  Widget _buildNavigateBackButton(
    BuildContext context, {
    required bool showSimpleStyle,
  }) {
    return GestureDetector(
        onTap: () => action ?? Navigator.of(context).pop(),
        child: showSimpleStyle
            ? const Icon(Icons.arrow_back_ios, color: Colors.white)
            : Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColorSchema.of(context).buttonColor,
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: Colors.white,
                  ),
                )));
  }

  Widget _buildFourDotsButton(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: AppColorSchema.of(context).buttonColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(Assets.fourDotsIcon),
      ),
    );
  }

  Widget _buildEmptyContainer() {
    return Container(
      color: Colors.transparent,
      width: 20,
      height: 20,
    );
  }
}
