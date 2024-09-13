import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/widgets/layout.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/my_info_widgets/my_info_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/presentation/my_profile/widgets/profile_widgets/security_modal.dart';

class MyInfoPage extends StatelessWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    final UserCubit userCubit = BlocProvider.of<UserCubit>(context);

    void showModal(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SecurityModal();
        },
      );
    }

    void handleAction() {
      if (userCubit.state.userHasChanged == false) {
        GoRouter.of(context).pushNamed(
          Routes.myProfile.name,
        );
      } else {
        showModal(context);
      }
    }

    return PopScope(
      canPop: false,
      child: WalletGuruLayout(
        showSafeArea: true,
        showLoggedUserAppBar: true,
        showBottomNavigationBar: true,
        pageAppBarTitle: l10n.myInfo,
        actionAppBar: handleAction,
        children: [
          SizedBox(
            width: size.width * 0.90,
            height: size.height,
            child: const MyInfoView(),
          ),
        ],
      ),
    );
  }
}
