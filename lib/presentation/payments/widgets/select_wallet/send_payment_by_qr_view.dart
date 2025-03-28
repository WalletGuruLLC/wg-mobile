import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class SendPaymentByQrView extends StatefulWidget {
  const SendPaymentByQrView({super.key});

  @override
  State<SendPaymentByQrView> createState() => _SendPaymentByQrViewState();
}

class _SendPaymentByQrViewState extends State<SendPaymentByQrView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late SendPaymentCubit sendPaymentCubit;
  bool isProcessing = false;

  @override
  void initState() {
    sendPaymentCubit = BlocProvider.of<SendPaymentCubit>(context);
    sendPaymentCubit.emitGetWalletInformation();
    sendPaymentCubit.emitFetchWalletAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;

    return BlocListener<SendPaymentCubit, SendPaymentState>(
      listener: (context, state) {
        if (state.isWalletExistQr is SubmissionSuccess) {
          GoRouter.of(context).goNamed(Routes.sendPaymentToUser.name);
        } else if (state.isWalletExistQr is SubmissionFailed) {
          controller!.resumeCamera();
          setState(() {
            isProcessing = false;
          });
          _buildErrorModal(context);
        }
      },
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea,
        ),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No permission to access camera')),
      );
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      if (scanData.code == null || isProcessing) {
        return;
      } else {
        controller.pauseCamera();
        setState(() {
          isProcessing = true;
        });

        BlocProvider.of<SendPaymentCubit>(context)
            .updateSendPaymentInformation(receiverWalletAddress: scanData.code);
        sendPaymentCubit.emitVerifyWalletExistence('qr');
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _buildErrorModal(
    BuildContext context,
  ) {
    final locale = Localizations.localeOf(context);
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          buttonWidth: locale.languageCode == 'en'
              ? MediaQuery.of(context).size.width * 0.40
              : MediaQuery.of(context).size.width * 0.44,
          isSucefull: false,
          content: Column(
            children: [
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.walletNotFoundTitle,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: l10n.walletNotFoundText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
            ],
          ),
          onPressed: () {
            BlocProvider.of<SendPaymentCubit>(context)
                .resetSendPaymentInformation();
            BlocProvider.of<SendPaymentCubit>(context).resetPaymentEntity();
            Navigator.of(context).pop();
            GoRouter.of(context).goNamed(Routes.selectWalletByQr.name);
          },
        );
      },
    );
  }
}
