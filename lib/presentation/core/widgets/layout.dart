import 'package:flutter/material.dart';

import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';

class WalletGuruLayout extends StatelessWidget {
  //final Widget body;
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final PreferredSizeWidget? customAppBar;
  final bool showAppBar;
  final bool showBackButton;
  final bool showSafeArea;
  final bool isTransparent;
  final bool showBottomNavigationBar;
  final String? pageAppbarTitle;

  const WalletGuruLayout({
    super.key,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.pageAppbarTitle,
    this.showAppBar = true,
    this.showBackButton = false,
    this.showSafeArea = true,
    this.isTransparent = false,
    this.showBottomNavigationBar = false,
    this.customAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: AppColorSchema.of(context).scaffoldColor,
          appBar: showAppBar
              ? null // HEADER SHOULD BE HERE
              : null,
          body: SafeArea(
            top: showSafeArea == true ? true : false,
            bottom: showSafeArea == true ? true : false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                crossAxisAlignment:
                    crossAxisAlignment ?? CrossAxisAlignment.center,
                children: children,
              ),
            ),
          ),
          bottomNavigationBar: showBottomNavigationBar
              ? null //BOTTOM NAVIGATION SHOULD BE HERE
              : null),
    );
  }

  // int getSelectedIndex(String currentRoute) {
  //   switch (currentRoute) {
  //     case '/driver_profile':
  //       return 0;
  //     case '/message':
  //       return 1;
  //     case '/home':
  //       return 2;
  //     case '/history_details_loads':
  //       return 3;
  //     case '/training_videos':
  //       return 4;
  //     default:
  //       return 0;
  //   }
  // }
}
