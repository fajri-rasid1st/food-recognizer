// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:camera/camera.dart';

// Project imports:
import 'package:food_recognizer/src/services/lite_rt_service.dart';

class FoodRecognizerProvider extends ChangeNotifier {
  final LiteRtService _service;

  FoodRecognizerProvider(
    this._service, {
    int interval = 1200,
  }) {
    _service.init();
    _interval = Duration(milliseconds: interval);
  }

  late final Duration _interval;
  DateTime _lastRun = DateTime.fromMillisecondsSinceEpoch(0);
  bool _isRunning = false;

  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  // Create a state and getter to get a top one on classification item
  Map<String, num> _classifications = {};
  Map<String, num> get classifications => Map.fromEntries(
    (_classifications.entries.toList()..sort((a, b) => a.value.compareTo(b.value))).reversed.take(1),
  );

  /// Menjalankan inferensi sekali per [_throttleInterval].
  Future<void> runInference(CameraImage image) async {
    if (_isDisposed) return;

    final now = DateTime.now();
    final tooSoon = now.difference(_lastRun) < _interval;

    // Saat masih dalam interval throttle atau masih ada task sedang berjalan, drop frame ini.
    if (tooSoon || _isRunning) return;

    _lastRun = now;
    _isRunning = true;

    try {
      debugPrint("running inference...");
      final result = await _service.inferenceCameraFrame(image);

      if (_isDisposed) return;

      _classifications = result;

      notifyListeners();
    } catch (e) {
      if (_isDisposed) return;

      debugPrint('inference failed');
    } finally {
      _isRunning = false;
    }
  }

  void close() {
    _service.close();
  }

  @override
  void dispose() {
    _isDisposed = true;

    super.dispose();
  }
}
