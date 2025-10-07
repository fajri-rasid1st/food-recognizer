// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:food_recognizer/core/const/const.dart';
import 'package:food_recognizer/src/models/meal.dart';

class MealApiService {
  // Singleton pattern
  static final MealApiService _instance = MealApiService._internal();

  MealApiService._internal();

  factory MealApiService() => _instance;

  http.Client? _client;

  http.Client get client => _client ??= http.Client();

  /// Fetch daftar makanan dari **The Meal DB** sesuai [query] yang dimasukkan
  Future<List<Meal>> getMeals(String query) async {
    // Definisikan url
    final url = '${kMealDbBaseUrl}search.php?s=$query';

    // Parsing url ke bentuk uri
    final uri = Uri.parse(url);

    try {
      // Kirim http request menggunakan client.get
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        // Parsing string dan kembalikan nilai objek json
        final result = jsonDecode(response.body);

        // Cast hasilnya ke bentuk Map, lalu ambil value dari key "meals"
        final List? meals = (result as Map<String, dynamic>)['meals'];

        if (meals != null) {
          // Kembalikan nilai berupa daftar makanan (meal) dari list map di atas
          return meals.map((meal) => Meal.fromMap(meal)).toList();
        }

        // Kembalikan list kosong apabila meals null
        return [];
      } else {
        // Kembalikan exception error jika gagal
        throw Exception('error code ${response.statusCode}');
      }
    } catch (e) {
      // Kembalikan exception error jika gagal
      rethrow;
    }
  }
}
