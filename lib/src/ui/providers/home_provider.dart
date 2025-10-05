// Dart imports:
import 'dart:typed_data' show Uint8List;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:food_recognizer/src/services/image_service.dart';

class HomeProvider extends ChangeNotifier {
  final ImageService _imageService;

  HomeProvider(this._imageService);

  Uint8List? imageBytes;

  void setImageBytes(Uint8List? bytes) {
    imageBytes = bytes;

    notifyListeners();
  }

  Future<void> pickImageFile(BuildContext context, ImageSource source) async {
    final imageFile = await _imageService.pickImage(source);

    if (imageFile != null) {
      if (!context.mounted) return;

      final croppedImage = await _imageService.cropImage(
        context: context,
        imagePath: imageFile.path,
      );

      if (!context.mounted) return;

      if (croppedImage != null) {
        final imgBytes = await croppedImage.readAsBytes();
        final compressedImgBytes = await _imageService.compressImage(imgBytes);

        setImageBytes(compressedImgBytes);
      }
    }
  }
}
