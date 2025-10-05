class Nutrition {
  final String name;
  final double value;
  final String unit;

  const Nutrition({
    required this.name,
    required this.value,
    required this.unit,
  });
}

const dummyNutritions = [
  Nutrition(
    name: 'Kalori',
    value: 450,
    unit: 'g',
  ),
  Nutrition(
    name: 'Karbohidrat',
    value: 50,
    unit: 'g',
  ),
  Nutrition(
    name: 'Lemak',
    value: 25,
    unit: 'g',
  ),
  Nutrition(
    name: 'Serat',
    value: 3,
    unit: 'g',
  ),
  Nutrition(
    name: 'Protein',
    value: 10,
    unit: 'g',
  ),
];
