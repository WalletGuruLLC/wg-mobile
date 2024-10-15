import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/application/deposit/deposit_cubit.dart';
import 'package:wallet_guru/application/register/register_cubit.dart';
import 'package:wallet_guru/application/settings/settings_cubit.dart';
import 'package:wallet_guru/application/transactions/transaction_cubit.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/application/create_wallet/create_wallet_cubit.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:wallet_guru/application/translations_error/translation_error_cubit.dart';

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
      BlocProvider.value(
        value: UserCubit(),
      ),
      BlocProvider.value(
        value: TranslationErrorCubit(),
      ),
      BlocProvider.value(
        value: SettingsCubit(),
      ),
      BlocProvider.value(
        value: SendPaymentCubit(),
      ),
      BlocProvider.value(
        value: TransactionCubit(),
      ),
      BlocProvider.value(
        value: DepositCubit(),
      ),
    ], child: child);
  }
}
