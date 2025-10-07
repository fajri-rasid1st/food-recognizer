// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:food_recognizer/app.dart';
import 'package:food_recognizer/firebase_options.dart';
import 'package:food_recognizer/src/services/gemini_service.dart';
import 'package:food_recognizer/src/services/image_picker_service.dart';
import 'package:food_recognizer/src/services/meal_api_service.dart';

void main() async {
  // Memastikan widget Flutter sudah diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();

  // Untuk mencegah orientasi landscape
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => ImagePickerService(),
        ),
        Provider(
          create: (_) => MealApiService(),
        ),
        Provider(
          create: (_) => GeminiService(),
        ),
      ],
      child: FoodRecognizerApp(),
    ),
  );
}
