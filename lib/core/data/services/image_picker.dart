import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  AppImagePicker({required this.source});

  ImageSource source;

  Future<File?> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }
}
