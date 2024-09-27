import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wallet_guru/application/core/validations/validations.dart';
import 'package:wallet_guru/infrastructure/core/routes/routes.dart';

class SendPaymentByQrView extends StatefulWidget {
  const SendPaymentByQrView({super.key});

  @override
  State<SendPaymentByQrView> createState() => _SendPaymentByQrViewState();
}

class _SendPaymentByQrViewState extends State<SendPaymentByQrView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;

    return QRView(
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
      if (scanData.code == null) {
        return;
      }
      if (Validators.regExpressionForWallet.hasMatch(scanData.code!)) {
        GoRouter.of(context).pushNamed(
          Routes.sendPaymentToUser.name,
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
