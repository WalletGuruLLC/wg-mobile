import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/core/wallet_status/wallet_status_cubit.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/unlock_account_redirect_modal.dart';
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
    super.initState();
    _selectedIndex = widget.selectedIndex;
    BlocProvider.of<SendPaymentCubit>(context).emitGetWalletInformation();
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex =
        _getSelectedIndexFromRoute(GoRouterState.of(context).fullPath!);

    return BlocListener<SendPaymentCubit, SendPaymentState>(
      listener: (context, state) {
        if (state.walletForPaymentEntity != null) {
          // Actualizar el estado de la billetera usando WalletStatusCubit
          context.read<WalletStatusCubit>().updateWalletStatus(
              state.walletForPaymentEntity!.walletDb.active);
        }
      },
      child: BlocBuilder<WalletStatusCubit, WalletStatusState>(
        builder: (context, walletStatusState) {
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
                onTap: (index) =>
                    _changeIndex(index, walletStatusState.isWalletActive),
                currentIndex: _selectedIndex,
                backgroundColor: AppColorSchema.of(context).buttonColor,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                enableFeedback: false,
                items: _buildBottomNavItems(walletStatusState.isWalletActive),
              ),
            ),
          );
        },
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
      case '/addProvider':
        return 2;
      case '/transactionChart':
        return 3;
      default:
        return 0;
    }
  }

  List<BottomNavigationBarItem> _buildBottomNavItems(bool isWalletActive) {
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
        isWalletActive: isWalletActive,
      ),
      _buildNavItem(
        icon: Assets.transactionsMenuIcon,
        label: 'Payments',
        index: 2,
        isWalletActive: isWalletActive,
      ),
      _buildNavItem(
        icon: Assets.verticalTransactionMenuIcon,
        label: 'Transactions',
        index: 3,
      ),
    ];
  }

  BottomNavigationBarItem _buildNavItem({
    required String icon,
    required String label,
    required int index,
    bool isWalletActive = true,
  }) {
    bool isSelected = _selectedIndex == index;
    double size = isSelected ? 50 : 40;
    double iconSize = isSelected ? 24 : 20;

    // Determinar colores de fondo e ícono según el estado de la billetera
    Color backgroundColor;
    Color iconColor;

    if (index == 1 || index == 2) {
      backgroundColor = !isWalletActive
          ? const Color.fromARGB(255, 120, 120, 120)
          : (isSelected ? Colors.white : Colors.black);
      iconColor = !isWalletActive
          ? Colors.grey
          : (isSelected ? Colors.black : Colors.white);
    } else {
      backgroundColor = isSelected ? Colors.white : Colors.black;
      iconColor = isSelected ? Colors.black : Colors.white;
    }

    return BottomNavigationBarItem(
      activeIcon:
          _buildIconContainer(icon, backgroundColor, iconColor, iconSize, size),
      icon:
          _buildIconContainer(icon, backgroundColor, iconColor, iconSize, size),
      label: label,
    );
  }

  Widget _buildIconContainer(String icon, Color backgroundColor,
      Color iconColor, double iconSize, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: iconSize,
          height: iconSize,
          colorFilter: ColorFilter.mode(
            iconColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  void _changeIndex(int index, bool isWalletActive) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        GoRouter.of(context).go(Routes.home.path);
        break;
      case 1:
        if (isWalletActive) {
          GoRouter.of(context).go(Routes.fundingScreen.path);
        } else {
          _showUnlockAccountModal();
        }

        break;
      case 2:
        if (isWalletActive) {
          GoRouter.of(context).go(Routes.payments.path);
        } else {
          _showUnlockAccountModal();
        }
        break;
      case 3:
        GoRouter.of(context).go(Routes.transactionChart.path);
        break;
    }
  }

  void _showUnlockAccountModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LockAccountRedirectModal();
      },
    );
  }
}
