// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:food_recognizer/core/routes/route_names.dart';
import 'package:food_recognizer/core/routes/routes_generator.dart';
import 'package:food_recognizer/core/theme/app_theme.dart';
import 'package:food_recognizer/core/utilities/navigator_key.dart';

class FoodRecognizerApp extends StatelessWidget {
  const FoodRecognizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recognizer',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      navigatorKey: navigatorKey,
      onGenerateRoute: generateAppRoutes,
      initialRoute: Routes.home,
    );
  }
}
