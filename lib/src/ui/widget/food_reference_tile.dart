// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:transparent_image/transparent_image.dart';

// Project imports:
import 'package:food_recognizer/core/extensions/text_style_extension.dart';
import 'package:food_recognizer/src/models/meal.dart';

class FoodReferenceTile extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  const FoodReferenceTile({
    super.key,
    required this.meal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          spacing: 12,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(8),
                  child: FadeInImage.memoryNetwork(
                    image: '${meal.strMealThumb}',
                    placeholder: kTransparentImage,
                    fit: BoxFit.cover,
                    width: 56,
                    height: 56,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${meal.strMeal}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextTheme.of(context).titleMedium!.bold,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 32,
            ),
          ],
        ),
        Positioned.fill(
          child: Material(
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
