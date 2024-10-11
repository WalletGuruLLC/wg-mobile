import 'package:app_links/app_links.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/infrastructure/core/routes/router_provider.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

class DynamicLinksDataSources {
  static final _appLinks = AppLinks();

  static Future<void> controlDynamicLink(Uri dynamicLink) async {
    final dynamicSendPaymentCubit =
        BlocProvider.of<SendPaymentCubit>(navigatorKey.currentContext!);

    final storage = await SharedPreferences.getInstance();
    final String? basic = storage.getString('Basic');

    try {
      if (basic != null) {
        dynamicSendPaymentCubit.updateSendPaymentInformation(
          receiverWalletAddress: 'https://walletguru.me${dynamicLink.path}',
        );
        GoRouter.of(navigatorKey.currentContext!).go(
          Routes.selectWalletByForm.path,
        );
        print('entro por default');
      } else {
        GoRouter.of(navigatorKey.currentContext!).go(
          Routes.errorScreen.path,
        );
        print('error sin token');
      }
    } catch (e) {
      GoRouter.of(navigatorKey.currentContext!).go(
        Routes.errorScreen.path,
      );
      print('error');
    }
  }

  static Future<void> initDynamicLink() async {
    final Uri? dynamicLink = await _appLinks.getInitialLink();

    if (dynamicLink != null) {
      controlDynamicLink(dynamicLink);
    }
  }

  static Future<void> listenDynamicLinks() async {
    _appLinks.uriLinkStream.listen((Uri uri) {
      controlDynamicLink(uri);
    });
  }
}
