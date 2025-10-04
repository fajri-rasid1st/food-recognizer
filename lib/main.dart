// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:food_recognizer/app.dart';

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

  runApp(FoodRecognizerApp());

  // runApp(
  //   MultiProvider(
  //     providers: [],
  //     child: FoodRecognizerApp(),
  //   ),
  // );
}
