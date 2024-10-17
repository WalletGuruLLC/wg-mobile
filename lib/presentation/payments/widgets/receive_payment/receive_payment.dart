import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:wallet_guru/application/send_payment/send_payment_cubit.dart';
import 'package:wallet_guru/application/user/user_cubit.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ReceivePaymentView extends StatefulWidget {
  const ReceivePaymentView({super.key});

  @override
  State<ReceivePaymentView> createState() => _ReceivePaymentViewState();
}

class _ReceivePaymentViewState extends State<ReceivePaymentView> {
  late SendPaymentCubit sendPaymentCubit;
  late UserCubit userCubit;
  late String qrUrl;
  GlobalKey qrKey = GlobalKey(); // Clave para identificar el QR a capturar
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    sendPaymentCubit = BlocProvider.of<SendPaymentCubit>(context);
    userCubit = BlocProvider.of<UserCubit>(context);
    super.initState();
  }

  Future<void> _shareQrCode() async {
    try {
      RenderRepaintBoundary boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/qr_code.png';
      await File(imagePath).writeAsBytes(pngBytes);
      await Share.shareXFiles([XFile(imagePath)], text: 'QR');
    } catch (e) {
      print('error $e');
    }
  }

  Future<void> _downloadQrCode() async {
    try {
      // Captura la imagen del QR
      RenderRepaintBoundary boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      // Guarda la imagen en la galería
      final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100);
      // Notifica al usuario sobre el resultado
      if (result != null && result['isSuccess'] == true) {
      } else {}
    } catch (e) {
      print('error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        qrUrl = userState.walletAddress;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildModalToShow(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextBase(
                  text: qrUrl,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.copy, color: Colors.white),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: qrUrl));
                  },
                ),
              ],
            ),
            _buildQrToShare(),
          ],
        );
      },
    );
  }

  Widget _buildQrToShare() {
    return Stack(
      children: [
        RepaintBoundary(
          key: qrKey, // Clave para el widget QR
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(8),
              color: Colors.black,
            ),
            child: Stack(
              children: [
                Center(
                  child: PrettyQr(
                    data: qrUrl,
                    size: 150,
                    elementColor: Colors.white,
                    roundEdges: true,
                    errorCorrectLevel: QrErrorCorrectLevel.M,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 40,
                  right: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextBase(
                        text: qrUrl,
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Contenedor invisible, pero hace que el QR sea renderizable
        Container(
          width: 500,
          height: 300,
          color: AppColorSchema.of(context)
              .scaffoldColor
              .withOpacity(1), // Color que oculta el contenido
        ),
      ],
    );
  }

  Widget _buildModalToShow() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 25, left: 40, right: 40, bottom: 15),
            child: Column(
              children: [
                PrettyQr(
                  data: qrUrl,
                  size: 150,
                  elementColor: Colors.white,
                  roundEdges: true,
                  errorCorrectLevel: QrErrorCorrectLevel.M,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 120,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFF212139),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Platform.isAndroid
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: _shareQrCode,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.share_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              height: 20,
                              thickness: 4,
                            ),
                            GestureDetector(
                              onTap: _downloadQrCode,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.download_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: _shareQrCode,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              Icons.share_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
