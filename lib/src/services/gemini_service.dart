import 'package:firebase_ai/firebase_ai.dart';

class GeminiService {
  // Singleton pattern
  static final GeminiService _instance = GeminiService._internal();

  GeminiService._internal();

  factory GeminiService() => _instance;

  Future<void> init() async {
    // Initialize the Gemini Developer API backend service
    // Create a `GenerativeModel` instance with a model that supports your use case
    final model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');

    // Provide a prompt that contains text
    final prompt = [Content.text('Write a story about a magic backpack.')];

    // To generate text output, call generateContent with the text input
    final response = await model.generateContent(prompt);
    
    print(response.text);
  }
}
