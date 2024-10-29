import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/application/register/register_cubit.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:flutter_idensic_mobile_sdk_plugin/flutter_idensic_mobile_sdk_plugin.dart';

class CreateProfileFirstForm extends StatefulWidget {
  const CreateProfileFirstForm({
    super.key,
    required this.id,
    required this.email,
  });

  final String id;
  final String email;

  @override
  State<CreateProfileFirstForm> createState() => CreateProfileFirstFormState();
}

class CreateProfileFirstFormState extends State<CreateProfileFirstForm> {
  late CreateProfileCubit createProfileCubit;

  @override
  void initState() {
    BlocProvider.of<LoginCubit>(context).cleanFormStatus();
    BlocProvider.of<RegisterCubit>(context).initialStatus();
    createProfileCubit = BlocProvider.of<CreateProfileCubit>(context);
    createProfileCubit.setUserId(widget.id, widget.email);
    createProfileCubit.loadCountryCodeAndCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProfileCubit, CreateProfileState>(
      builder: (context, state) {
        if (state.formStatusGetToken is FormSubmitting) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.formStatusGetToken is SubmissionFailed) {
          return Text(state.customMessage);
        } else {
          // Llamar directamente al SDK si no hay errores
          WidgetsBinding.instance.addPostFrameCallback((_) {
            launchSDK(state.sumSubToken, state.sumSubUserId);
          });
          return const SizedBox.shrink(); // Retorna un widget vacío
        }
      },
    );
  }

  Future<void> launchSDK(String accessToken, String userId) async {
    onTokenExpiration() async {
      // Lógica para obtener un nuevo token de tu backend
      return Future<String>.delayed(
          const Duration(seconds: 2), () => "your new access token");
    }

    onStatusChanged(
        SNSMobileSDKStatus newStatus, SNSMobileSDKStatus prevStatus) {
      print("The SDK status was changed: $prevStatus -> $newStatus");
    }

    final snsMobileSDK = SNSMobileSDK.init(accessToken, onTokenExpiration)
        .withHandlers(
          onStatusChanged: onStatusChanged,
        )
        .withDebug(true)
        .withLocale(Locale("en"))
        .build();

    final SNSMobileSDKResult result = await snsMobileSDK.launch();
    if (result.success && result.status == SNSMobileSDKStatus.Approved) {
      GoRouter.of(context).pushReplacementNamed(Routes.createProfile2.name);
    }
    print("Completed with result: $result");
  }
}
