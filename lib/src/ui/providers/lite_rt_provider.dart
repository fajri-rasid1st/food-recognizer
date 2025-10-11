// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:camera/camera.dart';

// Project imports:
import 'package:food_recognizer/src/services/lite_rt_service.dart';

class LiteRtProvider extends ChangeNotifier {
  final LiteRtService _service;

  LiteRtProvider(
    this._service, {
    double threshold = 0.20,
    int interval = 1200,
  }) {
    _service.init();
    _threshold = threshold;
    _interval = Duration(milliseconds: interval);
  }

  // Threshold
  late final double _threshold;

  // Throttle interval
  late final Duration _interval;
  DateTime _lastRun = DateTime.fromMillisecondsSinceEpoch(0);
  bool _isRunning = false;

  // Dispose condition
  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  // Classifications result
  Map<String, double> _classifications = {};
  Map<String, num> get classifications => Map.fromEntries(
    (_classifications.entries.toList()..sort((a, b) => a.value.compareTo(b.value))).reversed.take(1),
  );

  /// Menjalankan inferensi sekali per [interval] dari camera image.
  Future<void> runInferenceFromCameraFrame(CameraImage image) async {
    if (_isDisposed) return;

    final now = DateTime.now();
    final tooSoon = now.difference(_lastRun) < _interval;

    // Saat masih dalam interval throttle atau masih ada task sedang berjalan, drop frame.
    if (tooSoon || _isRunning) return;

    _lastRun = now;
    _isRunning = true;

    try {
      debugPrint("running inference...");

      final result = await _service.inferenceCameraFrame(image);

      if (_isDisposed) return;

      _applyThreshold(result);
    } catch (e) {
      if (_isDisposed) return;

      debugPrint('inference failed');
    } finally {
      _isRunning = false;
    }
  }

  /// Menjalankan inferensi langsung dari bytes gambar berformat jpg.
  Future<void> runInferenceFromImageBytes(Uint8List bytes) async {
    if (_isDisposed) return;

    try {
      debugPrint("running inference...");

      final result = await _service.inferenceImageBytes(bytes);

      if (_isDisposed) return;

      _applyThreshold(result);
    } catch (e) {
      if (_isDisposed) return;

      debugPrint('inference failed');
    }
  }

  /// Terapkan threshold
  void _applyThreshold(Map<String, double> result) {
    final topOne = _topOneOf(result);

    if (topOne == null || topOne.value < _threshold) {
      _classifications = {};
    } else {
      _classifications = result;
    }

    notifyListeners();
  }

  /// Ambil top-1 dari hasil inferensi
  MapEntry<String, double>? _topOneOf(Map<String, double> result) {
    if (result.isEmpty) return null;

    final sorted = result.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return sorted.first;
  }

  void resetClassifications() {
    _classifications = {};
    notifyListeners();
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
