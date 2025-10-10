// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:food_recognizer/core/extensions/text_style_extension.dart';
import 'package:food_recognizer/src/ui/providers/food_recognizer_provider.dart';
import 'package:food_recognizer/src/ui/widget/analyzing_label.dart';
import 'package:food_recognizer/src/ui/widget/camera_view.dart';
import 'package:food_recognizer/src/ui/widget/scaffold_safe_area.dart';

class LiveCameraPage extends StatelessWidget {
  const LiveCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSafeArea(
      appBar: _LiveCameraAppBar(),
      body: _LiveCameraBody(),
    );
  }
}

class _LiveCameraAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _LiveCameraAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorScheme.of(context).inversePrimary,
      title: Text('Live Food Recognizer'),
      titleTextStyle: TextTheme.of(context).titleLarge!.semiBold.colorOnSurface(context),
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 4);
}

class _LiveCameraBody extends StatefulWidget {
  const _LiveCameraBody();

  @override
  State<_LiveCameraBody> createState() => _LiveCameraBodyState();
}

class _LiveCameraBodyState extends State<_LiveCameraBody> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<FoodRecognizerProvider>();

    return ColoredBox(
      color: ColorScheme.of(context).onSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CameraView(
              onImage: (cameraImage) async {
                if (!mounted || provider.isDisposed) return;

                await provider.runInference(cameraImage);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: ColorScheme.of(context).surface,
            child: Consumer<FoodRecognizerProvider>(
              builder: (context, provider, child) {
                final classifications = provider.classifications;

                if (classifications.isEmpty) {
                  return AnalyzingLabel();
                }

                final predictedLabel = classifications.keys.first;
                final confidenceScore = classifications.values.first;

                return Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: Text(
                        predictedLabel,
                        style: TextTheme.of(context).titleLarge!.bold,
                      ),
                    ),
                    Text(
                      '${(confidenceScore * 100).toStringAsFixed(1)}%',
                      style: TextTheme.of(context).titleSmall!.medium,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
