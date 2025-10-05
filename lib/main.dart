// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:food_recognizer/app.dart';
import 'package:food_recognizer/src/services/image_service.dart';

// Package imports:
// import 'package:provider/provider.dart';

void main() {
  // Memastikan widget Flutter sudah diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();

  // Untuk mencegah orientasi landscape
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => ImageService(),
        ),
      ],
      child: FoodRecognizerApp(),
    ),
  );
}
