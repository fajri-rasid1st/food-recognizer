// Dart imports:
import 'dart:convert';

class FoodNutrient {
  final String name;
  final String description;
  final Nutrition nutrition;

  const FoodNutrient({
    required this.name,
    required this.description,
    required this.nutrition,
  });

  factory FoodNutrient.fromMap(Map<String, dynamic> map) {
    return FoodNutrient(
      name: map['foodName'] as String,
      description: map['foodDescription'] as String,
      nutrition: Nutrition.fromMap(map['nutrition'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'nutrition': nutrition.toMap(),
    };
  }

  factory FoodNutrient.fromJson(String source) => FoodNutrient.fromMap(jsonDecode(source) as Map<String, dynamic>);
}

class Nutrition {
  final int calories;
  final int carbs;
  final int fat;
  final int fiber;
  final int protein;

  const Nutrition({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.protein,
  });

  factory Nutrition.fromMap(Map<String, dynamic> map) {
    return Nutrition(
      calories: map['calories'] as int,
      carbs: map['carbs'] as int,
      fat: map['fat'] as int,
      fiber: map['fiber'] as int,
      protein: map['protein'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'calories': calories,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'protein': protein,
    };
  }
}
