import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  static Future<File?> pickFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    return picked != null ? File(picked.path) : null;
  }

  static Future<File?> pickFromCamera() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    return picked != null ? File(picked.path) : null;
  }
}

// Example usage
// File? image = await ImagePickerUtils.pickFromGallery();
