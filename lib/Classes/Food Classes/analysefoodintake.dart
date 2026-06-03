class Ingredientstaken {
  double? takenFibers;
  double? takenFats;
  double? takenCarbs;
  double? takenProteins;
  double? takenCalories;
  double? takenCalcium;
  double? takenNiacinB3;
  double? takenThiamineB1;
  double? takenIron;
  double? takenZinc;
  double? takenFolatesB9;
  double? takenRiboflavinB2;
  double? takenRetinolVitA;
  double? takenMagnesium;

  Ingredientstaken({
    required this.takenFibers,
    required this.takenFats,
    required this.takenCarbs,
    required this.takenProteins,
    required this.takenCalories,
    required this.takenCalcium,
    required this.takenNiacinB3,
    required this.takenThiamineB1,
    required this.takenIron,
    required this.takenZinc,
    required this.takenFolatesB9,
    required this.takenRiboflavinB2,
    required this.takenRetinolVitA,
    required this.takenMagnesium,
  });

  factory Ingredientstaken.fromJson(Map<String, dynamic> json) {
    return Ingredientstaken(
      takenFibers: json['fibers']?.toDouble(),
      takenFats: json['fat']?.toDouble(),
      takenCarbs: json['carbs']?.toDouble(),
      takenProteins: json['Protiens']?.toDouble(),
      takenCalories: json['Energy']?.toDouble(),
      takenCalcium: json['Calcium']?.toDouble(),
      takenNiacinB3: json['Niacin-B3']?.toDouble(),
      takenThiamineB1: json['Thiamine-B1']?.toDouble(),
      takenIron: json['Iron']?.toDouble(),
      takenZinc: json['Zinc']?.toDouble(),
      takenFolatesB9: json['Folates-B9']?.toDouble(),
      takenRiboflavinB2: json['Riboflavin-B2']?.toDouble(),
      takenRetinolVitA: json['Retinol-Vit-A']?.toDouble(),
      takenMagnesium: json['Magnesium']?.toDouble(),
    );
  }
}

class Ingredientsleft {
  double? leftCalories;
  double? leftNiacinB3;
  double? leftFats;
  double? leftFolatesB9;
  double? leftThiamineB1;
  double? leftRetinolVitA;
  double? leftRiboflavinB2;
  double? leftProteins;
  double? leftCalcium;
  double? leftIron;
  double? leftFibers;
  double? leftMagnesium;
  double? leftCarbs;
  double? leftZinc;

  Ingredientsleft({
    required this.leftCalories,
    required this.leftNiacinB3,
    required this.leftFats,
    required this.leftFolatesB9,
    required this.leftThiamineB1,
    required this.leftRetinolVitA,
    required this.leftRiboflavinB2,
    required this.leftProteins,
    required this.leftCalcium,
    required this.leftIron,
    required this.leftFibers,
    required this.leftMagnesium,
    required this.leftCarbs,
    required this.leftZinc,
  });

  factory Ingredientsleft.fromJson(Map<String, dynamic> json) {
    return Ingredientsleft(
      leftCalories: json['Left Calories']?.toDouble(),
      leftNiacinB3: json['Left Niacin_B3']?.toDouble(),
      leftFats: json['Left Fats']?.toDouble(),
      leftFolatesB9: json['Left Folates_B9']?.toDouble(),
      leftThiamineB1: json['Left Thiamine_B1']?.toDouble(),
      leftRetinolVitA: json['Left Retinol_Vit_A']?.toDouble(),
      leftRiboflavinB2: json['Left Riboflavin_B2']?.toDouble(),
      leftProteins: json['Left Proteins']?.toDouble(),
      leftCalcium: json['Left Calcium']?.toDouble(),
      leftIron: json['Left Iron']?.toDouble(),
      leftFibers: json['Left Fibers']?.toDouble(),
      leftMagnesium: json['Left Magnesium']?.toDouble(),
      leftCarbs: json['Left Carbs']?.toDouble(),
      leftZinc: json['Left Zinc']?.toDouble(),
    );
  }
}
