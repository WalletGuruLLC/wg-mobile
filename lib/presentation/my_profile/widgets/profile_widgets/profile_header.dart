import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:image_picker/image_picker.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/utils/image_picker_util.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:wallet_guru/presentation/create_profile/widgets/check_photo_modal.dart';

class ProfileHeaderWidget extends StatefulWidget {
  final String name;
  final String avatarImage;
  final bool? isOnTapAvailable;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.avatarImage,
    this.isOnTapAvailable = false,
  });

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  Uint8List? image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ImagePickerService.requestCameraPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextBase(text: widget.name),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: size.height * .1,
            child: GestureDetector(
              onTap: () {
                if (widget.isOnTapAvailable!) {
                  showModal(context);
                } else {
                  null;
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: image != null
                    ? Image.memory(
                        image!,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        widget.avatarImage,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showModal(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BaseModal(
          hasActions: false,
          hasCloseAction: true,
          content: Column(
            children: [
              const SizedBox(height: 20),
              _buildPickerOption(
                context,
                l10n.selectFromDevice,
                Icons.chevron_right,
                _handleImagePickerFromGallery,
              ),
              const SizedBox(height: 16),
              _buildPickerOption(
                context,
                l10n.selectFromCamera,
                Icons.chevron_right,
                _handleImagePickerFromCamera,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPickerOption(
    BuildContext context,
    String label,
    IconData icon,
    Future<void> Function() onTap,
  ) {
    return GestureDetector(
      onTap: () async {
        await onTap();
        if (image == null) return;
        if (context.mounted) {
          showDialog(
            context: context,
            barrierColor: AppColorSchema.of(context).modalBarrierColor,
            builder: (_) => CheckPhotoModal(image: image!),
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextBase(
            text: label,
            color: Colors.black,
            fontSize: 16,
          ),
          Icon(icon, size: 24),
        ],
      ),
    );
  }

  Future<void> _handleImagePickerFromGallery() async {
    XFile? selectedImage = await ImagePickerService.pickImageBytesFromGallery();
    if (selectedImage != null) {
      Uint8List? imageBytes = await File(selectedImage.path).readAsBytes();
      if (mounted) {
        setState(() {
          image = imageBytes;
        });
      }
    }
  }

  Future<void> _handleImagePickerFromCamera() async {
    XFile? selectedImage = await ImagePickerService.pickImageBytesFromCamera();
    if (selectedImage != null) {
      Uint8List? imageBytes = await File(selectedImage.path).readAsBytes();
      if (mounted) {
        setState(() {
          image = imageBytes;
        });
      }
    }
  }
}
