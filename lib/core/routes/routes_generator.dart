// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:food_recognizer/core/routes/route_names.dart';
import 'package:food_recognizer/src/services/image_service.dart';
import 'package:food_recognizer/src/ui/pages/detail_page.dart';
import 'package:food_recognizer/src/ui/pages/home_page.dart';
import 'package:food_recognizer/src/ui/pages/live_camera_page.dart';
import 'package:food_recognizer/src/ui/pages/result_page.dart';
import 'package:food_recognizer/src/ui/providers/home_provider.dart';

/// Routes generator
Route<dynamic>? generateAppRoutes(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => HomeProvider(
            context.read<ImageService>(),
          ),
          child: HomePage(),
        ),
      );
    case Routes.result:
      final args = settings.arguments as Map<String, dynamic>;

      return MaterialPageRoute(
        builder: (_) => ResultPage(
          imageBytes: args['imageBytes'],
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
      return MaterialPageRoute(
        builder: (_) => LiveCameraPage(),
      );
    default:
      return null;
  }
}
