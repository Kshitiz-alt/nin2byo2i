class RawFood {
  int id;
  String name;
  String foodCode;
  String typesOfFood;
  double energy;
  double moisture;
  double protein;
  double calcium;
  double iron;
  double zinc;
  double magnesium;
  double thiamineB1;
  double riboflavinB2;
  double niacinB3;
  double folatesB9;
  double retinolVitA;
  double carbohydrate;
  double sodium;
  double vitB6;
  double vitC;
  String category;
  double totalFat;
  double totalDietaryFibre;

  RawFood({
    required this.id,
    required this.name,
    required this.foodCode,
    required this.typesOfFood,
    required this.energy,
    required this.protein,
    required this.calcium,
    required this.iron,
    required this.zinc,
    required this.magnesium,
    required this.thiamineB1,
    required this.riboflavinB2,
    required this.niacinB3,
    required this.folatesB9,
    required this.retinolVitA,
    required this.carbohydrate,
    required this.sodium,
    required this.vitB6,
    required this.vitC,
    required this.moisture,
    required this.category,
    required this.totalFat,
    required this.totalDietaryFibre,
  });

  factory RawFood.fromJson(Map<String, dynamic> json) {
    return RawFood(
      id: json['id'],
      name: json['name'],
      foodCode: json['foodCode'],
      typesOfFood: json['typesoffood'],
      energy: json['energy'].toDouble(),
      protein: json['protein'].toDouble(),
      calcium: json['calcium'].toDouble(),
      iron: json['iron'].toDouble(),
      zinc: json['zinc'].toDouble(),
      magnesium: json['magnesium'].toDouble(),
      thiamineB1: json['thiamine_B1'].toDouble(),
      riboflavinB2: json['riboflavin_B2'].toDouble(),
      niacinB3: json['niacin_B3'].toDouble(),
      folatesB9: json['folates_B9'].toDouble(),
      retinolVitA: json['retinolVit_A'].toDouble(),
      carbohydrate: json['carbohydrate'].toDouble(),
      sodium: json['sodium'].toDouble(),
      vitB6: json['vitb6'].toDouble(),
      vitC: json['vitc'].toDouble(),
      moisture: json['moisture'].toDouble(),
      category: json['category'],
      totalFat: json['total_Fat'].toDouble(),
      totalDietaryFibre: json['total_Dietary_Fibre'].toDouble(),
    );
  }
}
