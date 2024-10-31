import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/application/funding/funding_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/home/widgets/balance_card.dart';
import 'package:wallet_guru/application/transactions/transaction_cubit.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/bottom_navigation_menu.dart';
import 'package:wallet_guru/presentation/home/widgets/last_transactions_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final UserCubit userCubit;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      userCubit = context.read<UserCubit>();
      _initializeData();
      _initialized = true;
    }
  }

  void _initializeData() {
    userCubit.emitGetUserInformation();
    userCubit.emitGetWalletInformation();
    userCubit.initializeWebSocket();
    context.read<TransactionCubit>().loadTransactions();
    context.read<CreateProfileCubit>().emitInitialStatus();
    context.read<SendPaymentCubit>().emitGetWalletInformation();
    context.read<FundingCubit>().resetCreateIncomingPaymentStatus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    const BalanceCard(),
                    SizedBox(height: size.height * 0.02),
                    const LastTransactionsList(),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(height: size.height * 0.1),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: kBottomNavigationBarHeight * 0.30,
              left: size.width * 0.05,
              right: size.width * 0.05,
              child: TextBase(
                text: "Connecting you to \na Digital Future",
                fontSize: size.width * 0.045,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationMenu(
        selectedIndex: 0,
      ),
      backgroundColor: Colors.black,
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      elevation: 0,
      title: GestureDetector(
        onTap: () {
          GoRouter.of(context).pushNamed(
            Routes.myProfile.name,
          );
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Assets.iconLogoLarge,
                  scale: 1.2,
                ),
                Center(
                  child: TextBase(
                    text: "Hi ${state.user?.firstName}",
                    color: Colors.white,
                    fontSize: size.width * 0.05,
                  ),
                ),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: state.user != null
                          ? Image.network(
                              state.user!.picture,
                              width: 60,
                              height: 60,
                            )
                          : const Icon(
                              Icons.account_circle,
                              size: 45,
                              color: Colors.grey,
                            ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Image.asset(
                      Assets.homeMenuIcon1,
                      scale: 0.8,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
