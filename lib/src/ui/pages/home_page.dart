// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dotted_border/dotted_border.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:food_recognizer/core/extensions/text_style_extension.dart';
import 'package:food_recognizer/core/routes/route_names.dart';
import 'package:food_recognizer/core/utilities/navigator_key.dart';
import 'package:food_recognizer/src/services/image_service.dart';
import 'package:food_recognizer/src/ui/widget/scaffold_safe_area.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldSafeArea(
      appBar: _HomeAppBar(),
      body: _HomeBody(),
    );
  }
}

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorScheme.of(context).inversePrimary,
      title: Text('Food Recognizer'),
      titleTextStyle: TextTheme.of(context).titleLarge!.semiBold.colorOnSurface(context),
      actions: [
        IconButton(
          icon: Icon(Icons.linked_camera_outlined),
          iconSize: 28,
          color: ColorScheme.of(context).onSurface,
          tooltip: 'Live Food Recognizer',
          onPressed: () => navigatorKey.currentState!.pushNamed(Routes.liveCamera),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 4);
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(16),
                  dashPattern: [5, 5],
                  strokeWidth: 1.5,
                  strokeCap: StrokeCap.round,
                  color: ColorScheme.of(context).outlineVariant,
                ),
                child: SizedBox(
                  width: MediaQuery.widthOf(context) - 80,
                  height: MediaQuery.widthOf(context) - 80,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.large(
                        elevation: 0,
                        focusElevation: 0,
                        hoverElevation: 0,
                        disabledElevation: 0,
                        highlightElevation: 0,
                        foregroundColor: ColorScheme.of(context).outline,
                        backgroundColor: ColorScheme.of(context).surfaceContainer,
                        shape: CircleBorder(),
                        onPressed: () => pickImageFile(context, ImageSource.gallery),
                        child: Icon(Icons.photo_library_outlined),
                      ),
                      SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => pickImageFile(context, ImageSource.gallery),
                        child: Text(
                          'Pilih Gambar',
                          style: TextTheme.of(context).titleMedium!.semiBold.colorPrimary(context),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'atau',
                        style: TextTheme.of(context).bodySmall!.colorOutline(context),
                      ),
                      SizedBox(height: 12),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          textStyle: TextTheme.of(context).titleSmall!.semiBold,
                        ),
                        onPressed: () => pickImageFile(context, ImageSource.camera),
                        child: Text('Ambil Gambar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              textStyle: TextTheme.of(context).titleSmall!.semiBold,
            ),
            onPressed: () {},
            child: Text('Analyze'),
          ),
        ],
      ),
    );
  }

  Future<void> pickImageFile(
    BuildContext context,
    ImageSource source,
  ) async {
    final imageFile = await ImageService.pickImage(source);

    if (imageFile != null) {
      if (!context.mounted) return;

      final croppedImage = await ImageService.cropImage(
        context: context,
        imagePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      if (!context.mounted) return;

      if (croppedImage != null) {
        final imgByte = await croppedImage.readAsBytes();

        debugPrint('fajri before compress: ${imgByte.length}');

        final compressImgByte = await ImageService.compressImage(imgByte);

        debugPrint('fajri after compress: ${compressImgByte.length}');
      }
    }
  }
}
