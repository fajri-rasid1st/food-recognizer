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
import 'package:food_recognizer/src/ui/providers/gemini_provider.dart';
import 'package:food_recognizer/src/ui/providers/meal_api_provider.dart';
import 'package:food_recognizer/src/ui/widget/error_text.dart';
import 'package:food_recognizer/src/ui/widget/food_reference_tile.dart';
import 'package:food_recognizer/src/ui/widget/loading_indicator.dart';
import 'package:food_recognizer/src/ui/widget/scaffold_safe_area.dart';

class ResultPage extends StatelessWidget {
  final Uint8List imageBytes;
  final String predictedLabel;
  final num confidenceScore;

  const ResultPage({
    super.key,
    required this.imageBytes,
    required this.predictedLabel,
    required this.confidenceScore,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldSafeArea(
      appBar: _ResultAppBar(),
      body: _ResultBody(
        imageBytes,
        predictedLabel,
        confidenceScore,
      ),
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
  final String predictedLabel;
  final num confidenceScore;

  const _ResultBody(
    this.imageBytes,
    this.predictedLabel,
    this.confidenceScore,
  );

  @override
  State<_ResultBody> createState() => _ResultBodyState();
}

class _ResultBodyState extends State<_ResultBody> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<MealApiProvider>().getMeals(widget.predictedLabel);
      context.read<GeminiProvider>().getNutrition(widget.predictedLabel);
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
                  widget.predictedLabel,
                  style: TextTheme.of(context).titleLarge!.bold,
                ),
              ),
              Text(
                '${(widget.confidenceScore * 100).toStringAsFixed(1)}%',
                style: TextTheme.of(context).titleSmall!.medium,
              ),
            ],
          ),
          Consumer<GeminiProvider>(
            builder: (context, provider, child) {
              if (provider.foodNutrient == null) {
                return SizedBox.shrink();
              }

              return Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  provider.foodNutrient!.description,
                  style: TextTheme.of(context).bodyMedium!.medium.colorOutline(context),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          Text(
            'Informasi Nilai Gizi',
            style: TextTheme.of(context).titleMedium!.semiBold,
          ),
          Divider(height: 32),
          Consumer<GeminiProvider>(
            builder: (context, provider, child) {
              switch (provider.state) {
                case ResultState.loading:
                  return LoadingIndicator(radius: 20);
                case ResultState.error:
                  return ErrorText(provider.message);
                case ResultState.data:
                  final nutrition = provider.foodNutrient!.nutrition;
                  final map = nutrition.toMap();
                  final keys = map.keys.toList();
                  final labels = ['Kalori', 'Karbohidrat', 'Lemak', 'Serat', 'Protein'];

                  return Column(
                    children: List<Padding>.generate(
                      map.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: Text(
                                labels[index],
                                style: TextTheme.of(context).bodyMedium!.medium.colorOutline(context),
                              ),
                            ),
                            Text(
                              '${map[keys[index]]} g',
                              style: TextTheme.of(context).bodyMedium!.medium.colorOutline(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
              }
            },
          ),
          SizedBox(height: 20),
          Text(
            'Referensi Masakan',
            style: TextTheme.of(context).titleMedium!.semiBold,
          ),
          Divider(height: 32),
          Consumer<MealApiProvider>(
            builder: (context, provider, child) {
              switch (provider.state) {
                case ResultState.loading:
                  return LoadingIndicator(radius: 20);
                case ResultState.error:
                  return ErrorText(provider.message);
                case ResultState.data:
                  if (provider.meals.isEmpty) {
                    return ErrorText(provider.message);
                  }

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
