// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_ai/firebase_ai.dart';

// Project imports:
import 'package:food_recognizer/core/const/const.dart';
import 'package:food_recognizer/src/models/food_nutrient.dart';

class GeminiService {
  // Singleton pattern
  static final GeminiService _instance = GeminiService._internal();

  late final GenerativeModel _model;

  factory GeminiService() => _instance;

  GeminiService._internal()
    : _model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.5-flash',
        systemInstruction: Content.system(kGeminiSystemInstruction.replaceAll(RegExp(r'\r?\n'), ' ')),
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          responseSchema: Schema.object(
            nullable: false,
            properties: {
              'foodName': Schema.string(nullable: false),
              'foodDescription': Schema.string(nullable: false),
              'nutrition': Schema.object(
                nullable: false,
                properties: {
                  'calories': Schema.integer(nullable: false),
                  'carbs': Schema.integer(nullable: false),
                  'fat': Schema.integer(nullable: false),
                  'fiber': Schema.integer(nullable: false),
                  'protein': Schema.integer(nullable: false),
                },
              ),
            },
          ),
        ),
      );

  Future<FoodNutrient> generateFoodNutrient(String foodName) async {
    final prompt = "Nama makanannya adalah $foodName.";

    final content = [Content.text(prompt)];

    try {
      final response = await _model.generateContent(content);

      // Ambil teks JSON dari response
      final text = response.text;

      if (text == null || text.isEmpty) {
        throw StateError('Response kosong dari Gemini.');
      }

      debugPrint('fajri + $text');

      return FoodNutrient.fromJson(text);
    } catch (e) {
      rethrow;
    }
  }
}
