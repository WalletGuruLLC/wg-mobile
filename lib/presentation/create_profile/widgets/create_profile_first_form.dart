import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/login/login_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/application/register/register_cubit.dart';
import 'package:wallet_guru/application/create_profile/create_profile_cubit.dart';
import 'package:flutter_idensic_mobile_sdk_plugin/flutter_idensic_mobile_sdk_plugin.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/utils/screen_util.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

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
    Size size = MediaQuery.of(context).size;
    bool smallScreen = ScreenUtils.isSmallScreen(context);

    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<CreateProfileCubit, CreateProfileState>(
      builder: (context, state) {
        if (state.formStatusGetToken is FormSubmitting) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.formStatusGetToken is SubmissionFailed) {
          return Text(state.customMessage);
        } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 41),
                SvgPicture.asset(
                  Assets.kycProcessIcon,
                  //width: 10,
                  //height: 10,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(height: 40),
                TextBase(
                  text: l10n.forSecurityKyc,
                  textAlign: TextAlign.center,
                  fontSize: 18,
                ),
                const SizedBox(height: 20),
                TextBase(
                  text: l10n.forSecurityTextKyc,
                  fontSize: 18,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height:
                        smallScreen ? size.height * 0.1 : size.height * 0.15),
                Center(
                  child: CustomButton(
                      width: 301,
                      onPressed: () {
                        launchSDK(state.sumSubToken, state.sumSubUserId);
                      },
                      text: l10n.startKYC,
                      color: AppColorSchema.of(context).buttonColor),
                ),
              ],
            ),
          );
          // return
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
        .withLocale(Locale(Localizations.localeOf(context).languageCode))
        .build();

    final SNSMobileSDKResult result = await snsMobileSDK.launch();
    if (result.success && result.status == SNSMobileSDKStatus.Approved) {
      GoRouter.of(context).pushReplacementNamed(Routes.createProfile2.name);
    }
    print("Completed with result: $result");
  }
}
