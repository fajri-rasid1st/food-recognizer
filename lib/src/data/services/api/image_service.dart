// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static Future<XFile?> pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();

    final image = await imagePicker.pickImage(
      source: source,
      imageQuality: 80,
    );

    return image;
  }

  static Future<CroppedFile?> cropImage({
    required BuildContext context,
    required String imagePath,
    CropAspectRatio? aspectRatio,
  }) async {
    final imageCropper = ImageCropper();

    final croppedFile = await imageCropper.cropImage(
      sourcePath: imagePath,
      aspectRatio: aspectRatio,
      maxWidth: 500,
      maxHeight: 500,
      compressQuality: 80,

      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Gambar',
          toolbarColor: ColorScheme.of(context).inversePrimary,
          toolbarWidgetColor: ColorScheme.of(context).onSurface,
          activeControlsWidgetColor: ColorScheme.of(context).primary,
          backgroundColor: ColorScheme.of(context).surface,
          cropFrameStrokeWidth: 5,
          cropGridStrokeWidth: 3,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Crop Gambar',
          doneButtonTitle: 'Selesai',
          cancelButtonTitle: 'Batal',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );

    return croppedFile;
  }
}
