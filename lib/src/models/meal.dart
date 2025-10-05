class Meal {
  final String? idMeal;
  final String? strMeal;
  final String? strMealThumb;
  final String? strInstructions;
  final String? strIngredient1;
  final String? strIngredient2;
  final String? strIngredient3;
  final String? strIngredient4;
  final String? strIngredient5;
  final String? strIngredient6;
  final String? strIngredient7;
  final String? strIngredient8;
  final String? strIngredient9;
  final String? strIngredient10;
  final String? strIngredient11;
  final String? strIngredient12;
  final String? strIngredient13;
  final String? strIngredient14;
  final String? strIngredient15;
  final String? strIngredient16;
  final String? strIngredient17;
  final String? strIngredient18;
  final String? strIngredient19;
  final String? strIngredient20;
  final String? strMeasure1;
  final String? strMeasure2;
  final String? strMeasure3;
  final String? strMeasure4;
  final String? strMeasure5;
  final String? strMeasure6;
  final String? strMeasure7;
  final String? strMeasure8;
  final String? strMeasure9;
  final String? strMeasure10;
  final String? strMeasure11;
  final String? strMeasure12;
  final String? strMeasure13;
  final String? strMeasure14;
  final String? strMeasure15;
  final String? strMeasure16;
  final String? strMeasure17;
  final String? strMeasure18;
  final String? strMeasure19;
  final String? strMeasure20;

  const Meal({
    this.idMeal,
    this.strMeal,
    this.strInstructions,
    this.strMealThumb,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strIngredient16,
    this.strIngredient17,
    this.strIngredient18,
    this.strIngredient19,
    this.strIngredient20,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    this.strMeasure16,
    this.strMeasure17,
    this.strMeasure18,
    this.strMeasure19,
    this.strMeasure20,
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      idMeal: map['idMeal'],
      strMeal: map['strMeal'],
      strInstructions: map['strInstructions'],
      strMealThumb: map['strMealThumb'],
      strIngredient1: map['strIngredient1'],
      strIngredient2: map['strIngredient2'],
      strIngredient3: map['strIngredient3'],
      strIngredient4: map['strIngredient4'],
      strIngredient5: map['strIngredient5'],
      strIngredient6: map['strIngredient6'],
      strIngredient7: map['strIngredient7'],
      strIngredient8: map['strIngredient8'],
      strIngredient9: map['strIngredient9'],
      strIngredient10: map['strIngredient10'],
      strIngredient11: map['strIngredient11'],
      strIngredient12: map['strIngredient12'],
      strIngredient13: map['strIngredient13'],
      strIngredient14: map['strIngredient14'],
      strIngredient15: map['strIngredient15'],
      strIngredient16: map['strIngredient16'],
      strIngredient17: map['strIngredient17'],
      strIngredient18: map['strIngredient18'],
      strIngredient19: map['strIngredient19'],
      strIngredient20: map['strIngredient20'],
      strMeasure1: map['strMeasure1'],
      strMeasure2: map['strMeasure2'],
      strMeasure3: map['strMeasure3'],
      strMeasure4: map['strMeasure4'],
      strMeasure5: map['strMeasure5'],
      strMeasure6: map['strMeasure6'],
      strMeasure7: map['strMeasure7'],
      strMeasure8: map['strMeasure8'],
      strMeasure9: map['strMeasure9'],
      strMeasure10: map['strMeasure10'],
      strMeasure11: map['strMeasure11'],
      strMeasure12: map['strMeasure12'],
      strMeasure13: map['strMeasure13'],
      strMeasure14: map['strMeasure14'],
      strMeasure15: map['strMeasure15'],
      strMeasure16: map['strMeasure16'],
      strMeasure17: map['strMeasure17'],
      strMeasure18: map['strMeasure18'],
      strMeasure19: map['strMeasure19'],
      strMeasure20: map['strMeasure20'],
    );
  }
}
