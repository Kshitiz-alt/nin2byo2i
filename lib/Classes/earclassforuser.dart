class EarForUser {
  String gender;
  String age;
  String group;
  String workLevel;
  double energy;
  double protein;
  double fatsOilsVisible;
  double fiber;
  double calcium;
  double magnesium;
  double iron;
  double zinc;
  double thiamine;
  double riboflavin;
  double niacin;
  double folate; // Added field
  double vitA; // Added field
  double iodine; // Added field
  double vitB12; // Added field
  double vitC; // Added field
  double carbohydrate; // Added field

  EarForUser({
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
    required this.iodine,
    required this.vitB12,
    required this.vitC,
    required this.carbohydrate,
  });

  factory EarForUser.fromJson(Map<String, dynamic> json) {
    return EarForUser(
      gender: json['gender'] ?? '',
      age: json['age'] ?? '',
      group: json['group'] ?? '',
      workLevel: json['workLevel'] ?? '',
      energy: json['energy']?.toDouble() ?? 0.0,
      protein: json['protein']?.toDouble() ?? 0.0,
      fatsOilsVisible: json['fatsOilsVisible']?.toDouble() ?? 0.0,
      fiber: json['fiber']?.toDouble() ?? 0.0,
      calcium: json['calcium']?.toDouble() ?? 0.0,
      magnesium: json['magnesium']?.toDouble() ?? 0.0,
      iron: json['iron']?.toDouble() ?? 0.0,
      zinc: json['zinc']?.toDouble() ?? 0.0,
      thiamine: json['thiamine']?.toDouble() ?? 0.0,
      riboflavin: json['riboflavin']?.toDouble() ?? 0.0,
      niacin: json['niacin']?.toDouble() ?? 0.0,
      folate: json['folate']?.toDouble() ?? 0.0,
      vitA: json['vitA']?.toDouble() ?? 0.0,
      iodine: json['iodine']?.toDouble() ?? 0.0,
      vitB12: json['vitB12']?.toDouble() ?? 0.0,
      vitC: json['vitC']?.toDouble() ?? 0.0,
      carbohydrate: json['carbohydrate']?.toDouble() ?? 0.0,
    );
  }
}
