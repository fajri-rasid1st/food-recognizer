// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:food_recognizer/core/extensions/text_style_extension.dart';
import 'package:food_recognizer/src/ui/widget/camera_view.dart';
import 'package:food_recognizer/src/ui/widget/scaffold_safe_area.dart';

class LiveCameraPage extends StatelessWidget {
  const LiveCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSafeArea(
      appBar: AppBar(
        backgroundColor: ColorScheme.of(context).inversePrimary,
        title: Text('Live Recognizer Food'),
        titleTextStyle: TextTheme.of(context).titleLarge!.semiBold.colorOnSurface(context),
        titleSpacing: 0,
      ),
      body: ColoredBox(
        color: ColorScheme.of(context).onSurface,
        child: Center(
          child: _LiveCameraBody(),
        ),
      ),
    );
  }
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
    return Stack(
      children: [
        CameraView(
          onImage: (cameraImage) async {
            // await readViewmodel.runClassification(cameraImage);
          },
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
    );
  }
}
