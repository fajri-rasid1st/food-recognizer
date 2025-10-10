// Dart imports:
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data' show Uint8List;

// Package imports:
import 'package:camera/camera.dart';
import 'package:image/image.dart' as image_lib;
import 'package:tflite_flutter/tflite_flutter.dart';

// Project imports:
import 'package:food_recognizer/core/utilities/image_utils.dart';

// Create an isolate class for running inference proccess
class IsolateInference {
  // Setup a state
  late Isolate _isolate;
  late SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  final _receivePort = ReceivePort();

  /// Open the new thread and create a static function, called [entryPoint].
  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(
      entryPoint,
      _receivePort.sendPort,
      debugName: "TFLITE_INFERENCE",
    );

    _sendPort = await _receivePort.first;
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();

    sendPort.send(port.sendPort);

    await for (final InferenceModel model in port) {
      // Create a [_imagePreProcessing] function and run image pre-processing
      final cameraImage = model.cameraImage;
      final imageBytes = model.imageBytes;
      final inputShape = model.inputShape;

      final imageMatrix = _imagePreProcessing(cameraImage, imageBytes, inputShape);

      // Run inference
      final input = [imageMatrix];
      final output = [List.filled(model.outputShape[1], 0)];
      final address = model.interpreterAddress;

      final result = _runInference(input, output, address);

      // Result preperation
      final maxScore = result.reduce((a, b) => a + b);
      final keys = model.labels;
      final values = result.map((e) => e.toDouble() / maxScore.toDouble()).toList();

      final classification = Map.fromIterables(keys, values);
      classification.removeWhere((_, value) => value == 0);

      // Send the result to main thread
      model.responsePort.send(classification);
    }
  }

  static List<List<List<num>>> _imagePreProcessing(
    CameraImage? cameraImage,
    Uint8List? imageBytes,
    List<int> inputShape,
  ) {
    assert(
      (cameraImage == null) != (imageBytes == null),
      'Exactly one of [cameraImage] or [imageBytes] must be non-null',
    );

    final image = cameraImage != null
        ? ImageUtils.convertCameraImage(cameraImage)
        : ImageUtils.convertJpgImageBytes(imageBytes!);

    // Resize original image to match model shape.
    var imageInput = image_lib.copyResize(
      image!,
      width: inputShape[1],
      height: inputShape[2],
    );

    if (Platform.isAndroid) {
      imageInput = image_lib.copyRotate(
        imageInput,
        angle: 90,
      );
    }

    final imageMatrix = List.generate(
      imageInput.height,
      (y) => List.generate(
        imageInput.width,
        (x) {
          final pixel = imageInput.getPixel(x, y);

          return [pixel.r, pixel.g, pixel.b];
        },
      ),
    );

    return imageMatrix;
  }

  static List<int> _runInference(
    List<List<List<List<num>>>> input,
    List<List<int>> output,
    int interpreterAddress,
  ) {
    final interpreter = Interpreter.fromAddress(interpreterAddress);

    interpreter.run(input, output);

    // Get first output tensor
    final result = output.first;

    return result;
  }

  /// Close every thread that might be open
  void close() {
    _isolate.kill();
    _receivePort.close();
  }
}

// Create an inference model class
class InferenceModel {
  late SendPort responsePort;

  CameraImage? cameraImage;
  Uint8List? imageBytes;

  int interpreterAddress;
  List<String> labels;
  List<int> inputShape;
  List<int> outputShape;

  InferenceModel.cameraImage(
    this.cameraImage,
    this.interpreterAddress,
    this.labels,
    this.inputShape,
    this.outputShape,
  );

  InferenceModel.imageBytes(
    this.imageBytes,
    this.interpreterAddress,
    this.labels,
    this.inputShape,
    this.outputShape,
  );
}
