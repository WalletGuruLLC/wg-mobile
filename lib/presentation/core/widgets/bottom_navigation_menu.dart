import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import '../styles/schemas/app_color_schema.dart';

class BottomNavigationMenu extends StatefulWidget {
  final int selectedIndex;
  const BottomNavigationMenu({super.key, required this.selectedIndex});

  @override
  State<BottomNavigationMenu> createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex =
        _getSelectedIndexFromRoute(GoRouterState.of(context).fullPath!);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          onTap: _changeIndex,
          currentIndex: _selectedIndex,
          backgroundColor: AppColorSchema.of(context).buttonColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          items: _buildBottomNavItems(),
        ),
      ),
    );
  }

  int _getSelectedIndexFromRoute(String location) {
    switch (location) {
      case '/home':
        return 0;
      case '/wallet':
        return 1;
      case '/payments':
      case '/selectWalletByForm':
      case '/selectWalletByQr':
      case '/sendPaymentToUser':
      case '/sendPayments':
      case '/receivePayment':
        return 2;
      case '/receive':
        return 3;
      default:
        return 0;
    }
  }

  List<BottomNavigationBarItem> _buildBottomNavItems() {
    return [
      _buildNavItem(
        icon: Assets.homeMenuIcon,
        label: 'Home',
        index: 0,
      ),
      _buildNavItem(
        icon: Assets.fundingMenuIcon,
        label: 'Wallet',
        index: 1,
      ),
      _buildNavItem(
        icon: Assets.transactionsMenuIcon,
        label: 'Payments',
        index: 2,
      ),
      _buildNavItem(
        icon: Assets.verticalTransactionMenuIcon,
        label: 'Receive',
        index: 3,
      ),
    ];
  }

  BottomNavigationBarItem _buildNavItem({
    required String icon,
    required String label,
    required int index,
  }) {
    bool isSelected = _selectedIndex == index;
    double size = isSelected ? 50 : 40;
    double iconSize = isSelected ? 24 : 20;

    return BottomNavigationBarItem(
      activeIcon: _buildIconContainer(icon, Colors.white, iconSize, size),
      icon: _buildIconContainer(icon, Colors.black, iconSize, size),
      label: label,
    );
  }

  Widget _buildIconContainer(
      String icon, Color color, double iconSize, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color == Colors.white ? Colors.white : Colors.black,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: iconSize,
          height: iconSize,
          colorFilter: ColorFilter.mode(
            color == Colors.white ? Colors.black : Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        GoRouter.of(context).go(Routes.home.path);
        break;
      case 1:
        GoRouter.of(context).go(Routes.withdrawPage.path);
        break;
      case 2:
        GoRouter.of(context).go(Routes.payments.path);
        break;
      case 3:
        // GoRouter.of(context).go(Routes.receive.path);
        break;
    }
  }
}
