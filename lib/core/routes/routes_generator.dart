// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:food_recognizer/core/routes/route_names.dart';
import 'package:food_recognizer/src/services/image_service.dart';
import 'package:food_recognizer/src/ui/pages/home_page.dart';
import 'package:food_recognizer/src/ui/pages/live_camera_page.dart';
import 'package:food_recognizer/src/ui/pages/result_page.dart';
import 'package:food_recognizer/src/ui/providers/home_provider.dart';

/// Routes generator
Route<dynamic>? generateAppRoutes(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      // final args = settings.arguments as Map<String, dynamic>;

      return MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => HomeProvider(
            context.read<ImageService>(),
          ),
          child: HomePage(),
        ),
      );
    case Routes.result:
      return MaterialPageRoute(
        builder: (context) => ResultPage(),
      );
    case Routes.detail:
      return MaterialPageRoute(
        builder: (context) => Placeholder(),
      );
    case Routes.liveCamera:
      return MaterialPageRoute(
        builder: (context) => LiveCameraPage(),
      );
    default:
      return null;
  }
}
