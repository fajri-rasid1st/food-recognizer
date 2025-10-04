// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:food_recognizer/core/routes/route_names.dart';
import 'package:food_recognizer/src/ui/pages/live_camera_page.dart';

/// Routes generator
Route<dynamic>? generateAppRoutes(RouteSettings settings) {
  switch (settings.name) {
    case Routes.result:
      // final args = settings.arguments as Map<String, dynamic>;

      return MaterialPageRoute(
        builder: (context) => Placeholder(),
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
