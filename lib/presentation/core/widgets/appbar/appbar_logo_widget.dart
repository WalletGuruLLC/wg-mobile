import 'package:flutter/material.dart';

import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

AppBar appBarLogoWidget(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColorSchema.of(context).scaffoldColor,
    elevation: 0,
    title: Row(
      children: [
        Image.asset(
          Assets.iconLogo,
        ),
      ],
    ),
  );
}
