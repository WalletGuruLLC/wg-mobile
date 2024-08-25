import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet_guru/presentation/core/assets/assets.dart';
import 'package:wallet_guru/presentation/core/styles/schemas/app_color_schema.dart';
import 'package:wallet_guru/presentation/core/widgets/base_modal.dart';
import 'package:wallet_guru/presentation/core/widgets/custom_button.dart';
import 'package:wallet_guru/presentation/core/widgets/text_base.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission handler

class CameraAccessModal extends StatelessWidget {
  const CameraAccessModal({super.key});

  // Function to handle permission request
  Future<void> _requestCameraPermission(BuildContext context) async {
    // Request camera permission
    PermissionStatus cameraPermission = await Permission.camera.request();

    if (cameraPermission == PermissionStatus.granted) {
      // If permission is granted, close the modal
      Navigator.of(context).pop();
      print('Camera permission granted');
    } else if (cameraPermission == PermissionStatus.denied) {
      // If permission is denied, close the modal and show a SnackBar
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission denied.')),
      );
    } else if (cameraPermission == PermissionStatus.permanentlyDenied) {
      // If permission is permanently denied, close the modal and open app settings
      Navigator.of(context).pop();
      openAppSettings(); // Redirect user to app settings
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseModal(
      showCloseIcon: false,
      centerIcon: Container(),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.warningIcon,
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextBase(
            text: 'Camera Access Required',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColorSchema.of(context).secondaryText,
          ),
          const SizedBox(height: 20),
          TextBase(
            text:
                'To capture photos, please allow the app to access your camera',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColorSchema.of(context).secondaryText,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                borderRadius: 12,
                width: size.width * 0.3,
                border: Border.all(
                  color: AppColorSchema.of(context).secondaryButtonBorderColor,
                ),
                color: AppColorSchema.of(context).buttonColor,
                text: 'Allow',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                onPressed: () => _requestCameraPermission(
                    context), // Request camera permissions
              ),
              CustomButton(
                borderRadius: 12,
                width: size.width * 0.3,
                border: Border.all(
                  color: AppColorSchema.of(context).secondaryButtonBorderColor,
                ),
                color: AppColorSchema.of(context).clearButtonColor,
                text: 'Deny',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                buttonTextColor: Colors.black,
                onPressed: () => Navigator.of(context).pop(), // Close the modal
              ),
            ],
          ),
        ],
      ),
    );
  }
}
