// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:food_recognizer/core/routes/route_names.dart';
import 'package:food_recognizer/src/services/gemini_service.dart';
import 'package:food_recognizer/src/services/image_picker_service.dart';
import 'package:food_recognizer/src/services/lite_rt_service.dart';
import 'package:food_recognizer/src/services/meal_api_service.dart';
import 'package:food_recognizer/src/ui/pages/detail_page.dart';
import 'package:food_recognizer/src/ui/pages/home_page.dart';
import 'package:food_recognizer/src/ui/pages/live_camera_page.dart';
import 'package:food_recognizer/src/ui/pages/result_page.dart';
import 'package:food_recognizer/src/ui/providers/gemini_provider.dart';
import 'package:food_recognizer/src/ui/providers/image_picker_provider.dart';
import 'package:food_recognizer/src/ui/providers/lite_rt_provider.dart';
import 'package:food_recognizer/src/ui/providers/meal_api_provider.dart';

/// Routes generator
Route<dynamic>? generateAppRoutes(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ImagePickerProvider(
                context.read<ImagePickerService>(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => LiteRtProvider(
                context.read<LiteRtService>(),
              ),
            ),
          ],
          child: HomePage(),
        ),
      );
    case Routes.result:
      final args = settings.arguments as Map<String, dynamic>;

      return MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MealApiProvider(
                context.read<MealApiService>(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => GeminiProvider(
                context.read<GeminiService>(),
              ),
            ),
          ],
          child: ResultPage(
            imageBytes: args['imageBytes'],
            predictedLabel: args['predictedLabel'],
            confidenceScore: args['confidenceScore'],
          ),
        ),
      );
    case Routes.detail:
      final args = settings.arguments as Map<String, dynamic>;

      return MaterialPageRoute(
        builder: (_) => DetailPage(
          meal: args['meal'],
        ),
      );
    case Routes.liveCamera:
      final args = settings.arguments as Map<String, dynamic>;

      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
          value: args['provider'] as LiteRtProvider,
          child: LiveCameraPage(),
        ),
      );
    default:
      return null;
  }
}
