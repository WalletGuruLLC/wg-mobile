import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<XFile?> pickImageBytesFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      return pickedFile;
    } else {
      // Handle the case where the user cancels the picker
      return null;
    }
  }

  static Future<XFile?> pickImageBytesFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      return pickedFile;
    } else {
      // Handle the case where the user cancels the picker
      return null;
    }
  }
}
