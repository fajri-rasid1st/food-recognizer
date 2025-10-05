// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:food_recognizer/core/extensions/text_style_extension.dart';
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
  // late final readViewmodel = context.read<ImageClassificationViewmodel>();

  @override
  void dispose() {
    // Future.microtask(() async => await readViewmodel.close());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorScheme.of(context).onSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CameraView(
              onImage: (cameraImage) async {
                // await readViewmodel.runClassification(cameraImage);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: ColorScheme.of(context).surface,
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: AnalyzingLabel(),
                ),
                Text(
                  '00.00%',
                  style: TextTheme.of(context).titleSmall!.medium,
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   left: 0,
          //   child: Consumer<ImageClassificationViewmodel>(
          //     builder: (_, updateViewmodel, __) {
          //       final classifications = updateViewmodel.classifications.entries;

          //       if (classifications.isEmpty) {
          //         return const SizedBox.shrink();
          //       }
          //       return SingleChildScrollView(
          //         child: Column(
          //           children: classifications
          //               .map(
          //                 (classification) => ClassificatioinItem(
          //                   item: classification.key,
          //                   value: classification.value.toStringAsFixed(2),
          //                 ),
          //               )
          //               .toList(),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
