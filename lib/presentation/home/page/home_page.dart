import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/home/widgets/balance_card.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/presentation/core/widgets/bottom_navigation_menu.dart';
import 'package:wallet_guru/presentation/home/widgets/last_transactions_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.emitGetUserInformation();
    //userCubit.emitGetWalletInformation();
    BlocProvider.of<CreateProfileCubit>(context).emitInitialStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BalanceCard(),
              SizedBox(height: size.height * 0.02),
              const LastTransactionsList(),
              SizedBox(height: size.height * 0.03),
              Text(
                "Connecting you to a Digital Future",
                style:
                    TextStyle(fontSize: size.width * 0.05, color: Colors.white),
              ),
            ],
          ),
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
    Uint8List? image;

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
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: size.width * 0.05,
                  child: Image.asset(
                    Assets.iconLogo,
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Text(
                  "Hi ${state.user?.firstName}",
                  style: TextStyle(
                      color: Colors.white, fontSize: size.width * 0.045),
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: state.user != null
                      ? Image.network(state.user!.picture,
                          width: 39, height: 39)
                      : const Icon(
                          Icons.account_circle,
                          size: 45,
                          color: Colors.grey,
                        ),
                ),
                SizedBox(width: size.width * 0.03),
                Icon(Icons.menu, color: Colors.white, size: size.width * 0.07),
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
