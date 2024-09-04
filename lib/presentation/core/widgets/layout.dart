import 'package:flutter/material.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/app_top_bar.dart';
import 'package:wallet_guru/presentation/core/widgets/bottom_navigation_menu.dart';

class WalletGuruLayout extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool showAppBar;
  final bool showBackButton;
  final bool showSafeArea;
  final bool isTransparent;
  final bool showBottomNavigationBar;
  final String? pageAppbarTitle;
  final void Function()? actionAppBar;
  final bool isAppBarSimpleStyle;

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
    this.actionAppBar,
    this.isAppBarSimpleStyle = true,
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
            ? AppTopBar(
                title: pageAppbarTitle!,
                action: actionAppBar,
                isSimpleStyle: isAppBarSimpleStyle,
              )
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
