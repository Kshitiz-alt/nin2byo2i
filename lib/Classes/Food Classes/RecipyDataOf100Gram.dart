class Recipe {
  final int recipesId;
  final String recipeName;
  final double protein;
  final double totalFat;
  final double totalDietaryFibre;
  final double carbohydrate;
  final double energyJoules;
  final double riboflavinB2;
  final double niacin;
  final double totalFolateB9;
  final double vitaminC;
  final double vitaminA;
  final double iron;
  final double zinc;
  final double sodium;
  final double calcium;
  final double magnesium;
  final double thiamine;
  final double vitaminB6;

  Recipe({
    required this.recipesId,
    required this.recipeName,
    required this.protein,
    required this.totalFat,
    required this.totalDietaryFibre,
    required this.carbohydrate,
    required this.energyJoules,
    required this.riboflavinB2,
    required this.niacin,
    required this.totalFolateB9,
    required this.vitaminC,
    required this.vitaminA,
    required this.iron,
    required this.zinc,
    required this.sodium,
    required this.calcium,
    required this.magnesium,
    required this.thiamine,
    required this.vitaminB6,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipesId: json['recipesId'],
      recipeName: json['recipeName'],
      protein: json['protein'],
      totalFat: json['totalFat'],
      totalDietaryFibre: json['totalDietaryFibre'],
      carbohydrate: json['carbohydrate'],
      energyJoules: json['energyKcal'],
      riboflavinB2: json['riboflavinB2'],
      niacin: json['niacin'],
      totalFolateB9: json['folateB9'],
      vitaminC: json['vitaminC'],
      vitaminA: json['vitaminA'],
      iron: json['iron'],
      zinc: json['zinc'],
      sodium: json['sodium'],
      calcium: json['calcium'],
      magnesium: json['magnesium'],
      thiamine:
          json['thiamine'] ?? 0.0, // default value in case not provided in JSON
      vitaminB6: json['vitaminB6'] ??
          0.0, // default value in case not provided in JSON
    );
  }
}
