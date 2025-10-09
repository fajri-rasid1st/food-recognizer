// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:camera/camera.dart';

// Project imports:
import 'package:food_recognizer/src/services/lite_rt_service.dart';

class LiveFoodRecognizerProvider extends ChangeNotifier {
  final LiteRtService _service;

  LiveFoodRecognizerProvider(this._service) {
    _service.initHelper();
  }

  // Create a state and getter to get a top one on classification item
  Map<String, num> _classifications = {};

  Map<String, num> get classifications => Map.fromEntries(
    (_classifications.entries.toList()..sort((a, b) => a.value.compareTo(b.value))).reversed.take(1),
  );

  // Run the inference process
  Future<void> runInference(CameraImage camera) async {
    _classifications = await _service.inferenceCameraFrame(camera);
    notifyListeners();
  }

  // Close everything
  void close() {
    _service.close();
  }
}
