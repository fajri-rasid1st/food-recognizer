// Dart imports:
import 'dart:typed_data' show Uint8List;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  // Singleton pattern
  static final ImageService _instance = ImageService._internal();

  ImageService._internal();

  factory ImageService() => _instance;

  /// To pick image from provided [source]
  Future<XFile?> pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();

    final image = await imagePicker.pickImage(
      source: source,
      imageQuality: 80,
    );

    return image;
  }

  /// To crop image after picked from gallery or camera
  Future<CroppedFile?> cropImage({
    required BuildContext context,
    required String imagePath,
    double? aspectRatioX,
    double? aspectRatioY,
  }) async {
    final imageCropper = ImageCropper();

    final croppedImage = await imageCropper.cropImage(
      sourcePath: imagePath,
      aspectRatio: CropAspectRatio(
        ratioX: aspectRatioX ?? 1.0,
        ratioY: aspectRatioY ?? 1.0,
      ),
      maxWidth: 800,
      maxHeight: 800,
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

    return croppedImage;
  }

  /// To compress image after cropped
  Future<Uint8List> compressImage(Uint8List bytes, [int maxSizeMb = 1]) async {
    final imageLength = bytes.length;

    if (imageLength < (maxSizeMb * 1000000)) return bytes;

    final image = img.decodeImage(bytes)!;

    var compressQuality = 100;
    var length = imageLength;
    Uint8List newBytes;

    do {
      compressQuality -= 10;

      newBytes = img.encodeJpg(
        image,
        quality: compressQuality,
      );

      length = newBytes.length;
    } while (length > (maxSizeMb * 1000000));

    return newBytes;
  }
}
