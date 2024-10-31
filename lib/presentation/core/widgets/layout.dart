import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/appbar/app_top_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/appbar/appbar_logo_widget.dart';
import 'package:wallet_guru/presentation/core/widgets/bottom_navigation_menu.dart';

class WalletGuruLayout extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool showLoggedUserAppBar;
  final bool showBackButton;
  final bool showSafeArea;
  final bool isTransparent;
  final bool showBottomNavigationBar;
  final String? pageAppBarTitle;
  final void Function()? actionAppBar;
  final bool showSimpleStyle;
  final bool showNotLoggedAppBar;
  final bool centerLogo;
  const WalletGuruLayout({
    super.key,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.pageAppBarTitle,
    this.showLoggedUserAppBar = false,
    this.showBackButton = false,
    this.showSafeArea = false,
    this.isTransparent = false,
    this.showBottomNavigationBar = false,
    this.showNotLoggedAppBar = false,
    this.actionAppBar,
    this.showSimpleStyle = true,
    this.centerLogo = false,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColorSchema.of(context).scaffoldColor,
        appBar: showLoggedUserAppBar && !showNotLoggedAppBar
            ? WalletGuruAppBar(
                title: pageAppBarTitle!,
                action: actionAppBar,
                showSimpleStyle: showSimpleStyle,
              )
            : !showLoggedUserAppBar && showNotLoggedAppBar
                ? appBarLogoWidget(context, centerLogo)
                : null,
        body: SafeArea(
          top: showSafeArea,
          bottom: showSafeArea,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    mainAxisAlignment ?? MainAxisAlignment.center,
                crossAxisAlignment:
                    crossAxisAlignment ?? CrossAxisAlignment.center,
                children: children,
              ),
            ),
          ),
        ),
        bottomNavigationBar: showBottomNavigationBar
            ? BottomNavigationMenu(
                selectedIndex:
                    getSelectedIndex(ModalRoute.of(context)!.settings.name!),
              )
            : null,
      ),
    );
  }

  int getSelectedIndex(String currentRoute) {
    switch (currentRoute) {
      case '/dashboardWallet':
        return 0;
      case '/home':
        return 1;
      case '/createWallet':
        return 2;
      case '/myProfile':
        return 3;
      default:
        return 0;
    }
  }
}
