// Dart imports:
import 'dart:typed_data' show Uint8List;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:food_recognizer/core/extensions/text_style_extension.dart';
import 'package:food_recognizer/core/routes/route_names.dart';
import 'package:food_recognizer/core/utilities/navigator_key.dart';
import 'package:food_recognizer/src/ui/providers/image_picker_provider.dart';
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
    final imageBytes = context.select<ImagePickerProvider, Uint8List?>((provider) => provider.imageBytes);

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  padding: EdgeInsets.zero,
                  radius: Radius.circular(16),
                  dashPattern: [5, 5],
                  strokeWidth: 1.5,
                  strokeCap: StrokeCap.round,
                  color: ColorScheme.of(context).outlineVariant,
                ),
                child: SizedBox(
                  width: MediaQuery.widthOf(context),
                  height: MediaQuery.widthOf(context) - 56,
                  child: imageBytes != null ? _ImagePreviewWidget(imageBytes) : _ImagePickerWidget(),
                ),
              ),
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              textStyle: TextTheme.of(context).titleSmall!.semiBold,
            ),
            onPressed: imageBytes != null
                ? () => navigatorKey.currentState!.pushNamed(
                    Routes.result,
                    arguments: {'imageBytes': imageBytes},
                  )
                : null,
            child: Text('Analyze'),
          ),
        ],
      ),
    );
  }
}

class _ImagePickerWidget extends StatelessWidget {
  const _ImagePickerWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
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
          onPressed: () => context.read<ImagePickerProvider>().pickImageFile(context, ImageSource.gallery),
          child: Icon(Icons.photo_library_outlined),
        ),
        GestureDetector(
          onTap: () => context.read<ImagePickerProvider>().pickImageFile(context, ImageSource.gallery),
          child: Text(
            'Pilih Gambar',
            style: TextTheme.of(context).titleMedium!.semiBold.colorPrimary(context),
          ),
        ),
        Text(
          'atau',
          style: TextTheme.of(context).bodySmall!.colorOutline(context),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            textStyle: TextTheme.of(context).titleSmall!.semiBold,
          ),
          onPressed: () => context.read<ImagePickerProvider>().pickImageFile(context, ImageSource.camera),
          child: Text('Ambil Gambar'),
        ),
      ],
    );
  }
}

class _ImagePreviewWidget extends StatelessWidget {
  final Uint8List imageBytes;

  const _ImagePreviewWidget(this.imageBytes);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageBytes,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1.5,
            color: ColorScheme.of(context).outlineVariant,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          image: DecorationImage(
            image: MemoryImage(imageBytes),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FilledButton.tonalIcon(
              icon: Icon(Icons.delete_outline_rounded),
              label: Text('Hapus'),
              style: FilledButton.styleFrom(
                textStyle: TextTheme.of(context).titleSmall!.semiBold,
              ),
              onPressed: () => context.read<ImagePickerProvider>().setImageBytes(null),
            ),
          ),
        ),
      ),
    );
  }
}
