import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet_guru/application/funding/funding_cubit.dart';
import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/domain/core/models/form_submission_status.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';

class AddProviderByQrView extends StatefulWidget {
  const AddProviderByQrView({super.key});

  @override
  State<AddProviderByQrView> createState() => _AddProviderByQrViewState();
}

class _AddProviderByQrViewState extends State<AddProviderByQrView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late SendPaymentCubit sendPaymentCubit;
  late FundingCubit fundingCubit;
  bool isProcessing = false;

  @override
  void initState() {
    sendPaymentCubit = BlocProvider.of<SendPaymentCubit>(context);
    fundingCubit = BlocProvider.of<FundingCubit>(context);
    sendPaymentCubit.emitGetWalletInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;

    return BlocListener<FundingCubit, FundingState>(
      listener: (context, state) {
        if (state.scannedQrStatus is SubmissionSuccess) {
          _buildSuccessModal(context);
          GoRouter.of(context)
              .pushReplacementNamed(Routes.addValidateFunds.name);
        } else if (state.scannedQrStatus is SubmissionFailed) {
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
          fundingCubit.updateFundingEntity(
              walletAddressUrl: scanData.code,
              rafikiWalletAddress: sendPaymentCubit
                  .state.walletForPaymentEntity!.walletDb.rafikiId);
        });
        fundingCubit.emitLinkServerProvider();
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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          buttonText: 'OK',
          buttonWidth: MediaQuery.of(context).size.width * 0.40,
          isSucefull: false,
          content: Column(
            children: [
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: 'Error',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: 'An error has ocurred, please try again.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
            ],
          ),
          onPressed: () {
            fundingCubit.resetFundingEntity();
            fundingCubit.resetFundingQrStatus();
            Navigator.of(context).pop();
            GoRouter.of(context).goNamed(Routes.addProvider.name);
          },
        );
      },
    );
  }

  void _buildSuccessModal(
    BuildContext context,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double size = MediaQuery.of(context).size.height;
        return BaseModal(
          buttonText: 'OK',
          buttonWidth: MediaQuery.of(context).size.width * 0.40,
          isSucefull: true,
          content: Column(
            children: [
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text: 'New Service Added',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
              TextBase(
                textAlign: TextAlign.center,
                text:
                    'You have successfully added a new Provider to your wallet ',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColorSchema.of(context).secondaryText,
              ),
              SizedBox(height: size * 0.010),
            ],
          ),
          onPressed: () {
            fundingCubit.resetFundingEntity();
            fundingCubit.resetFundingQrStatus();
            Navigator.of(context).pop();
            GoRouter.of(context).goNamed(Routes.home.name);
          },
        );
      },
    );
  }
}
