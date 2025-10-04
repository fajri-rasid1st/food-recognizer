// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:food_recognizer/core/theme/color_scheme.dart';
import 'package:food_recognizer/core/theme/text_theme.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  textTheme: buildTextTheme(lightColorScheme),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  textTheme: buildTextTheme(darkColorScheme),
);
