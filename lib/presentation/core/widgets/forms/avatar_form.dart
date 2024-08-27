import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/utils/image_picker_util.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/create_profile/widgets/check_photo_modal.dart';

class AvatarForm extends StatefulWidget {
  final String? avatarUrl;
  final void Function()? onTap;

  const AvatarForm({
    super.key,
    this.avatarUrl,
    this.onTap,
  });

  @override
  State<AvatarForm> createState() => _AvatarFormState();
}

class _AvatarFormState extends State<AvatarForm> {
  Uint8List? image;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestCameraPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColorSchema.of(context).avatarBorder,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          TextBase(
            text: l10n.uploadPhoto,
            fontSize: 16,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await _handleImagePickerFromGallery();
                  if (image == null) return;
                  if (context.mounted) {
                    showDialog(
                      context: context,
                      barrierColor:
                          AppColorSchema.of(context).modalBarrierColor,
                      builder: (_) {
                        return CheckPhotoModal(
                          image: image!,
                        );
                      },
                    );
                  }
                },
                child: Image.asset(
                  Assets.uploadIcon,
                ),
              ),
              const SizedBox(width: 30),
              GestureDetector(
                onTap: () async {
                  await _handleImagePickerFromCamera();
                  if (image == null) return;
                  if (context.mounted) {
                    showDialog(
                      context: context,
                      barrierColor:
                          AppColorSchema.of(context).modalBarrierColor,
                      builder: (_) {
                        return CheckPhotoModal(
                          image: image!,
                        );
                      },
                    );
                  }
                },
                child: Image.asset(
                  Assets.cameraIcon,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<void> _handleImagePickerFromGallery() async {
    XFile? selectedImage = await ImagePickerService.pickImageBytesFromGallery();
    if (!mounted) return;
    if (selectedImage != null) {
      Uint8List? imageBytes = await File(selectedImage.path).readAsBytes();
      if (!mounted) return;
      setState(() {
        image = imageBytes;
      });
    } else {
      return;
    }
  }

  Future<void> _handleImagePickerFromCamera() async {
    XFile? selectedImage = await ImagePickerService.pickImageBytesFromCamera();
    if (!mounted) return;
    if (selectedImage != null) {
      Uint8List? imageBytes = await File(selectedImage.path).readAsBytes();
      if (!mounted) return;
      setState(() {
        image = imageBytes;
      });
    } else {
      return;
    }
  }
}
