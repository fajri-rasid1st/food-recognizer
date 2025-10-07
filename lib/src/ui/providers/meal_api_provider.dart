// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:food_recognizer/core/enums/result_state.dart';
import 'package:food_recognizer/src/models/meal.dart';
import 'package:food_recognizer/src/services/meal_api_service.dart';

class MealApiProvider extends ChangeNotifier {
  final MealApiService _mealApiService;

  MealApiProvider(this._mealApiService);

  List<Meal> meals = [];
  ResultState state = ResultState.loading;
  String message = '';

  Future<void> getMeals(String query) async {
    state = ResultState.loading;
    notifyListeners();

    try {
      final result = await _mealApiService.getMeals(query);

      meals = result;

      if (meals.isEmpty) {
        message = 'Tidak ditemukan referensi masakan.';
      }

      state = ResultState.data;
    } catch (e) {
      message = 'Terjadi kesalahan.';

      state = ResultState.error;
    } finally {
      notifyListeners();
    }
  }
}
