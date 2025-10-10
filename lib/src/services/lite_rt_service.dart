// Dart imports:
import 'dart:io';
import 'dart:isolate';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

// Project imports:
import 'package:food_recognizer/src/services/firebase_ml_service.dart';
import 'package:food_recognizer/src/services/helpers/isolate_inference.dart';

class LiteRtService {
  static LiteRtService? _instance;

  final FirebaseMlService _mlService;

  LiteRtService._internal(this._mlService);

  factory LiteRtService({required FirebaseMlService mlService}) {
    return _instance ??= LiteRtService._internal(mlService);
  }

  late final File modelFile;
  late final Interpreter interpreter;
  late final List<String> labels;
  late final IsolateInference isolateInference;

  late Tensor inputTensor;
  late Tensor outputTensor;

  Future<void> init() async {
    await _loadModel();
    await _loadLabels();

    isolateInference = IsolateInference();

    await isolateInference.start();
  }

  Future<void> _loadModel() async {
    debugPrint('Interpreter on loading...');

    // Download hosted model from Firebase Machine Learning
    modelFile = await _mlService.getModel();

    final options = InterpreterOptions()
      ..useNnApiForAndroid = true
      ..useMetalDelegateForIOS = true;

    // Load model from file after download
    interpreter = Interpreter.fromFile(
      modelFile,
      options: options,
    );

    // Get tensor input shape [1, 224, 224, 3]
    inputTensor = interpreter.getInputTensors().first;

    // Get tensor output shape [1, 1001]
    outputTensor = interpreter.getOutputTensors().first;

    debugPrint('Interpreter loaded successfully');
  }

  Future<void> _loadLabels() async {
    final labelTxt = await rootBundle.loadString('assets/aiy_food_V1_labels.txt');

    labels = labelTxt.split('\n');
  }

  Future<Map<String, double>> inferenceCameraFrame(CameraImage cameraImage) async {
    final model = InferenceModel(
      cameraImage,
      interpreter.address,
      labels,
      inputTensor.shape,
      outputTensor.shape,
    );

    final responsePort = ReceivePort();

    isolateInference.sendPort.send(model..responsePort = responsePort.sendPort);

    // Get inference result
    final results = await responsePort.first;

    return results;
  }

  void close() {
    isolateInference.close();
  }
}
