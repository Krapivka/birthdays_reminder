import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AppImagePickerService {
  static Future<File?> getImageFromGallery() async {
    const ImageSource source = ImageSource.gallery;
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }
}
