// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:camera/camera.dart';

class CameraView extends StatefulWidget {
  final Function(CameraImage cameraImage)? onImage;

  const CameraView({
    super.key,
    this.onImage,
  });

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  CameraController? controller;

  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _isProcessing = false;
  bool _isFlashOn = false;
  bool _isRearCamera = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();

    initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    controller!
      ..stopImageStream()
      ..dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController != null || !cameraController!.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.inactive:
        cameraController.dispose();
        break;
      case AppLifecycleState.resumed:
        onNewCameraSelected(cameraController.description);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isCameraInitialized
        ? Stack(
            fit: StackFit.expand,
            children: [
              CameraPreview(controller!),
              Positioned(
                left: 0,
                right: 0,
                bottom: 48,
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _FlashlightButton(
                      value: _isFlashOn,
                      onChanged: (value) => setState(() {
                        _isFlashOn = value;

                        if (_isFlashOn) {
                          controller!.setFlashMode(FlashMode.torch);
                        } else {
                          controller!.setFlashMode(FlashMode.off);
                        }
                      }),
                    ),
                    _SwitchCameraButton(
                      value: _isRearCamera,
                      onChanged: (value) => setState(() {
                        _isRearCamera = value;

                        final cameraDescription = _cameras.firstWhere((camera) {
                          if (_isRearCamera) {
                            return camera.lensDirection == CameraLensDirection.back;
                          }

                          return camera.lensDirection == CameraLensDirection.front;
                        });

                        controller!.setDescription(cameraDescription);
                      }),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Center(
            child: SizedBox(
              width: 48,
              height: 48,
              child: CircularProgressIndicator(),
            ),
          );
  }

  Future<void> initCamera() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }

    final cameraDescription = _cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);

    await onNewCameraSelected(cameraDescription);
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      fps: 30,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid ? ImageFormatGroup.yuv420 : ImageFormatGroup.bgra8888,
    );

    await previousCameraController?.dispose();

    cameraController
        .initialize()
        .then((value) {
          if (mounted) {
            setState(() {
              controller = cameraController;

              if (widget.onImage != null) {
                controller!.startImageStream(_processCameraImage);
              }

              _isCameraInitialized = controller!.value.isInitialized;
            });
          }
        })
        .catchError((e) {
          debugPrint('Error initializing camera: $e');
        });
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isProcessing) {
      return;
    }

    _isProcessing = true;

    if (widget.onImage != null) {
      await widget.onImage!(image);
    }
    _isProcessing = false;
  }
}

class _FlashlightButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _FlashlightButton({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'flashlight_button',
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      foregroundColor: ColorScheme.of(context).surface,
      backgroundColor: ColorScheme.of(context).primary,
      shape: CircleBorder(
        side: BorderSide(
          color: ColorScheme.of(context).surface,
          width: 2,
        ),
      ),
      tooltip: 'Flash',
      onPressed: () => onChanged.call(!value),
      child: Icon(value ? Icons.flash_on : Icons.flash_off),
    );
  }
}

class _SwitchCameraButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchCameraButton({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'switch_camera_button',
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      foregroundColor: ColorScheme.of(context).surface,
      backgroundColor: ColorScheme.of(context).primary,
      shape: CircleBorder(
        side: BorderSide(
          color: ColorScheme.of(context).surface,
          width: 2,
        ),
      ),
      tooltip: 'Switch',
      onPressed: () => onChanged.call(!value),
      child: Icon(Icons.sync),
    );
  }
}
