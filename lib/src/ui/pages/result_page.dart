// Dart imports:
import 'dart:typed_data' show Uint8List;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:food_recognizer/core/enums/result_state.dart';
import 'package:food_recognizer/core/extensions/text_style_extension.dart';
import 'package:food_recognizer/core/routes/route_names.dart';
import 'package:food_recognizer/core/utilities/navigator_key.dart';
import 'package:food_recognizer/src/models/nutrition.dart';
import 'package:food_recognizer/src/ui/providers/meal_api_provider.dart';
import 'package:food_recognizer/src/ui/widget/food_reference_tile.dart';
import 'package:food_recognizer/src/ui/widget/scaffold_safe_area.dart';

class ResultPage extends StatelessWidget {
  final Uint8List imageBytes;

  const ResultPage({
    super.key,
    required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldSafeArea(
      appBar: _ResultAppBar(),
      body: _ResultBody(imageBytes),
    );
  }
}

class _ResultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ResultAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorScheme.of(context).inversePrimary,
      title: Text('Hasil Analisis'),
      titleTextStyle: TextTheme.of(context).titleLarge!.semiBold.colorOnSurface(context),
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 4);
}

class _ResultBody extends StatefulWidget {
  final Uint8List imageBytes;

  const _ResultBody(this.imageBytes);

  @override
  State<_ResultBody> createState() => _ResultBodyState();
}

class _ResultBodyState extends State<_ResultBody> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // todo-02: run the inference model based on user picture
      if (!mounted) return;

      context.read<MealApiProvider>().getMeals('burger');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: widget.imageBytes,
            child: Container(
              width: MediaQuery.widthOf(context),
              height: MediaQuery.widthOf(context) - 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 1.5,
                  color: ColorScheme.of(context).outlineVariant,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                image: DecorationImage(
                  image: MemoryImage(widget.imageBytes),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: Text(
                  'Nasi Lemak',
                  style: TextTheme.of(context).titleLarge!.bold,
                ),
              ),
              Text(
                '00.00%',
                style: TextTheme.of(context).titleSmall!.medium,
              ),
            ],
          ),
          Divider(height: 32),
          Text(
            'Informasi Nilai Gizi',
            style: TextTheme.of(context).titleMedium!.semiBold,
          ),
          Divider(height: 32),
          ...List<Padding>.generate(
            dummyNutritions.length,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Text(
                      dummyNutritions[index].name,
                      style: TextTheme.of(context).bodyMedium!.medium.colorOutline(context),
                    ),
                  ),
                  Text(
                    '${dummyNutritions[index].value} ${dummyNutritions[index].unit}',
                    style: TextTheme.of(context).bodyMedium!.medium.colorOutline(context),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Referensi Makanan Serupa',
            style: TextTheme.of(context).titleMedium!.semiBold,
          ),
          Divider(height: 32),
          Consumer<MealApiProvider>(
            builder: (context, provider, child) {
              switch (provider.state) {
                case ResultState.loading:
                  return Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  );
                case ResultState.error:
                  return Center(
                    child: Text(
                      provider.message,
                      textAlign: TextAlign.center,
                      style: TextTheme.of(context).bodyMedium!.medium.colorOutline(context),
                    ),
                  );
                case ResultState.data:
                  return Column(
                    spacing: 16,
                    children: List<FoodReferenceTile>.generate(
                      provider.meals.length,
                      (index) {
                        final meal = provider.meals[index];

                        return FoodReferenceTile(
                          meal: meal,
                          onTap: () => navigatorKey.currentState!.pushNamed(
                            Routes.detail,
                            arguments: {'meal': meal},
                          ),
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
