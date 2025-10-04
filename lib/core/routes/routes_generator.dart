// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:food_recognizer/core/routes/route_names.dart';

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

    case Routes.cameraView:
      return MaterialPageRoute(
        builder: (context) => Placeholder(),
      );

    default:
      return null;
  }
}
