// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:transparent_image/transparent_image.dart';

// Project imports:
import 'package:food_recognizer/core/extensions/text_style_extension.dart';
import 'package:food_recognizer/src/models/meal.dart';
import 'package:food_recognizer/src/ui/widget/loading_indicator.dart';
import 'package:food_recognizer/src/ui/widget/scaffold_safe_area.dart';

class DetailPage extends StatelessWidget {
  final Meal meal;

  const DetailPage({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldSafeArea(
      appBar: _DetailAppBar('${meal.strMeal}'),
      body: _ResultBody(meal),
    );
  }
}

class _DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const _DetailAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorScheme.of(context).inversePrimary,
      title: Text(title),
      titleTextStyle: TextTheme.of(context).titleLarge!.semiBold.colorOnSurface(context),
      titleSpacing: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 4);
}

class _ResultBody extends StatelessWidget {
  final Meal meal;

  const _ResultBody(this.meal);

  @override
  Widget build(BuildContext context) {
    final ingredients = meal.getIngredientsList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              LoadingIndicator(
                radius: 50,
              ),
              Hero(
                tag: meal,
                child: FadeInImage.memoryNetwork(
                  image: '${meal.strMealThumb}',
                  placeholder: kTransparentImage,
                  fit: BoxFit.cover,
                  width: MediaQuery.widthOf(context),
                  height: MediaQuery.widthOf(context) - 96,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${meal.strMeal}',
                  style: TextTheme.of(context).titleLarge!.bold,
                ),
                SizedBox(height: 16),
                Text(
                  'Bahan-bahan',
                  style: TextTheme.of(context).titleMedium!.semiBold,
                ),
                Divider(height: 32),
                ...List<Padding>.generate(
                  ingredients.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: Text(
                            ingredients[index].key,
                            style: TextTheme.of(context).bodyMedium!.medium.colorOutline(context),
                          ),
                        ),
                        Text(
                          ingredients[index].value,
                          style: TextTheme.of(context).bodyMedium!.medium.colorOutline(context),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Cara Membuat',
                  style: TextTheme.of(context).titleMedium!.semiBold,
                ),
                Divider(height: 32),
                Text(
                  '${meal.strInstructions}',
                  style: TextTheme.of(context).bodyMedium!.medium.colorOutline(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
