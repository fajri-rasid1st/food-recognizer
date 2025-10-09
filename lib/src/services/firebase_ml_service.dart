// Dart imports:
import 'dart:io';

// Package imports:
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';

class FirebaseMlService {
  static final FirebaseMlService _instance = FirebaseMlService._internal();

  FirebaseMlService._internal();

  factory FirebaseMlService() => _instance;

  Future<File> loadModel() async {
    final instance = FirebaseModelDownloader.instance;

    final model = await instance.getModel(
      "Food-Recognizer",
      FirebaseModelDownloadType.localModel,
      FirebaseModelDownloadConditions(
        iosAllowsCellularAccess: true,
        iosAllowsBackgroundDownloading: false,
        androidChargingRequired: false,
        androidWifiRequired: false,
        androidDeviceIdleRequired: false,
      ),
    );

    return model.file;
  }
}
