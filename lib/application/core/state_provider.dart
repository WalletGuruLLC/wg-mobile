import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_guru/application/create_wallet/create_wallet_cubit.dart';

import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/application/register/register_cubit.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';

class WalletGuruStateProvider extends StatelessWidget {
  final Widget child;

  const WalletGuruStateProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider.value(
        value: LoginCubit(),
      ),
      BlocProvider.value(
        value: RegisterCubit(),
      ),
      BlocProvider.value(
        value: CreateProfileCubit(),
      ),
      BlocProvider.value(
        value: CreateWalletCubit(),
      ),
    ], child: child);
  }
}
