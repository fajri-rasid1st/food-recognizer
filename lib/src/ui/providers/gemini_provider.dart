// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:food_recognizer/core/enums/result_state.dart';
import 'package:food_recognizer/src/models/food_nutrient.dart';
import 'package:food_recognizer/src/services/gemini_service.dart';

class GeminiProvider extends ChangeNotifier {
  final GeminiService _geminiService;

  GeminiProvider(this._geminiService);

  FoodNutrient? foodNutrient;
  ResultState state = ResultState.loading;
  String message = '';

  Future<void> getNutrition(String foodName) async {
    state = ResultState.loading;
    notifyListeners();

    try {
      final result = await _geminiService.generateFoodNutrient(foodName);

      foodNutrient = result;

      state = ResultState.data;
    } catch (e) {
      message = 'Terjadi kesalahan.';

      state = ResultState.error;
    } finally {
      notifyListeners();
    }
  }
}
