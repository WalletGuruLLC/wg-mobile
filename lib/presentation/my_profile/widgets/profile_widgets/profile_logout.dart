import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class LogoutButton extends StatelessWidget {
  final String text;

  const LogoutButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    Size size = MediaQuery.of(context).size;

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.logOutSuccess) {
          loginCubit.initialStatus();
          GoRouter.of(context).pushReplacementNamed(
            Routes.logIn.name,
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          loginCubit.emitLogOut();
        },
        child: Row(
          children: [
            SizedBox(
              width: size.width * .08,
              child: SvgPicture.asset(Assets.logoutIcon),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextBase(text: text, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
