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

  void setMeals(List<Meal> meals) {
    this.meals = meals;
    notifyListeners();
  }

  Future<void> getMeals(String query) async {
    state = ResultState.loading;
    notifyListeners();

    try {
      final result = await _mealApiService.getMeals(query);

      meals = result;

      state = ResultState.data;
    } catch (e) {
      message = 'Tidak ada referensi makanan serupa';

      state = ResultState.error;
    } finally {
      notifyListeners();
    }
  }
}
