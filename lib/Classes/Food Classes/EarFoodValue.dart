class NutritionalRequirement {
  final int earId;
  final String gender;
  final String age;
  final String group;
  final String workLevel;
  final double energy;
  final double protein;
  final double fatsOilsVisible;
  final double fiber;
  final double calcium;
  final double magnesium;
  final double iron;
  final double zinc;
  final double thiamine;
  final double riboflavin;
  final double niacin;
  final double folate;
  final double vitA;
  final double carbohyderate;
  final String particulars;

  NutritionalRequirement({
    required this.earId,
    required this.gender,
    required this.age,
    required this.group,
    required this.workLevel,
    required this.energy,
    required this.protein,
    required this.fatsOilsVisible,
    required this.fiber,
    required this.calcium,
    required this.magnesium,
    required this.iron,
    required this.zinc,
    required this.thiamine,
    required this.riboflavin,
    required this.niacin,
    required this.folate,
    required this.vitA,
    required this.carbohyderate,
    required this.particulars,
  });

  // Method to create a NutritionalRequirement object from a JSON object
  factory NutritionalRequirement.fromJson(Map<String, dynamic> json) {
    return NutritionalRequirement(
      earId: json['earId'],
      gender: json['gender'],
      age: json['age'],
      group: json['group'],
      workLevel: json['workLevel'],
      energy: json['energy'].toDouble(),
      protein: json['protein'].toDouble(),
      fatsOilsVisible: json['fatsOilsVisible'].toDouble(),
      fiber: json['fiber'].toDouble(),
      calcium: json['calcium'].toDouble(),
      magnesium: json['magnesium'].toDouble(),
      iron: json['iron'].toDouble(),
      zinc: json['zinc'].toDouble(),
      thiamine: json['thiamine'].toDouble(),
      riboflavin: json['riboflavin'].toDouble(),
      niacin: json['niacin'].toDouble(),
      folate: json['folate'].toDouble(),
      vitA: json['vitA'].toDouble(),
      carbohyderate: json['carbohyderate'].toDouble(),
      particulars: json['particulars'],
    );
  }
}
