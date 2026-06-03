class Meal {
  final double totalmealCalories;
  bool expanded;
  final String date;
  final List<Dish> rlist;
  final double mealProteins;
  final double mealCarbs;
  final double mealFats;
  final double mealFibers;
  final double mealCalcium;
  final double mealIron;
  final double mealZinc;
  final double mealMagnesium;
  final double mealThiamineB1;
  final double mealRiboflavinB2;
  final double mealNiacinB3;
  final double mealFolatesB9;
  final double mealRetinolVitA;
  // final Map<String, dynamic> nutrientsNameWithSIUnit;

  Meal({
    required this.totalmealCalories,
    required this.date,
    required this.expanded,
    required this.rlist,
    required this.mealCarbs,
    required this.mealFats,
    required this.mealFibers,
    required this.mealProteins,
    required this.mealCalcium,
    required this.mealIron,
    required this.mealZinc,
    required this.mealMagnesium,
    required this.mealThiamineB1,
    required this.mealRiboflavinB2,
    required this.mealNiacinB3,
    required this.mealFolatesB9,
    required this.mealRetinolVitA,
    // required this.nutrientsNameWithSIUnit,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    var rlist = json['rlist'] as List;
    List<Dish> dishes = rlist.map((dish) => Dish.fromJson(dish)).toList();

    return Meal(
      totalmealCalories: json['mealEnergy'] ?? 0,
      date: json['date'],
      expanded: false,
      mealProteins: json['mealProteins'] ?? 0,
      mealCarbs: json['mealCarbs'] ?? 0,
      mealFats: json['mealFats'] ?? 0,
      mealFibers: json['mealFibers'] ?? 0,
      mealCalcium: json['mealCalcium'] ?? 0,
      mealIron: json['mealIron'] ?? 0,
      mealZinc: json['mealZinc'] ?? 0,
      mealMagnesium: json['mealMagnesium'],
      mealThiamineB1: json['mealThiamine_B1'] ?? 0,
      mealRiboflavinB2: json['mealRiboflavin_B2'] ?? 0,
      mealNiacinB3: json['mealNiacin_B3'] ?? 0,
      mealFolatesB9: json['mealFolates_B9'] ?? 0,
      mealRetinolVitA: json['mealRetinolVit_A'] ?? 0,
      // nutrientsNameWithSIUnit: json['nutrientsNameWithSIUnit'],
      rlist: dishes,
    );
  }
}

class Dish {
  final int dishId;
  final String dishName;
  final String unit;
  final double dishQuantity;
  final double valueforOneUnit;
  final double servingSize;
  final String mealtype;
  final List<Ingredient> ingredients;
  final double totalCalories;
  final double totalProteins;
  final double totalCarbs;
  final double totalFats;
  final double totalFibers;
  final double totalCalcium;
  final double totalIron;
  final double totalZinc;
  final double totalMagnesium;
  final double totalThiamineB1;
  final double totalRiboflavinB2;
  final double totalNiacinB3;
  final double totalFolatesB9;
  final double totalRetinolVitA;
  bool favourite;

  Dish({
    required this.dishId,
    required this.dishName,
    required this.unit,
    required this.valueforOneUnit,
    required this.dishQuantity,
    required this.servingSize,
    required this.mealtype,
    required this.ingredients,
    required this.totalCalories,
    required this.totalProteins,
    required this.totalCarbs,
    required this.totalFats,
    required this.totalFibers,
    required this.totalCalcium,
    required this.totalIron,
    required this.totalZinc,
    required this.totalMagnesium,
    required this.totalThiamineB1,
    required this.totalRiboflavinB2,
    required this.totalNiacinB3,
    required this.totalFolatesB9,
    required this.totalRetinolVitA,
    required this.favourite,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    var ingredientsList = json['ingredients'] as List;
    List<Ingredient> ingredientData = ingredientsList
        .map((ingredient) => Ingredient.fromJson(ingredient))
        .toList();

    return Dish(
      dishId: json["dishId"],
      dishName: json['dishName'],
      valueforOneUnit: json['valueForOneUnit'],
      unit: json['unit'],
      dishQuantity: json['dishQuantity'] ?? 0,
      servingSize: json['servingSize'] ?? 0,
      favourite: json["favourite"],
      mealtype: json["mealType"] ?? '',
      ingredients: ingredientData,
      totalCalories: json['totalEnergy'] ?? 0,
      totalProteins: json['totalProteins'] ?? 0,
      totalCarbs: json['totalCarbs'] ?? 0,
      totalFats: json['totalFats'] ?? 0,
      totalFibers: json['totalFibers'] ?? 0,
      totalCalcium: json['totalCalcium'] ?? 0,
      totalIron: json['totalIron'] ?? 0,
      totalZinc: json['totalZinc'] ?? 0,
      totalMagnesium: json['totalMagnesium'] ?? 0,
      totalThiamineB1: json['totalThiamine_B1'] ?? 0,
      totalRiboflavinB2: json['totalRiboflavin_B2'] ?? 0,
      totalNiacinB3: json['totalNiacin_B3'] ?? 0,
      totalFolatesB9: json['totalFolates_B9'] ?? 0,
      totalRetinolVitA: json['totalRetinolVit_A'] ?? 0,
    );
  }
}

class Ingredient {
  final String ingredientName;
  final double ingredientQuantity;
  final double calories;
  final double proteins;
  final double fats;
  final double carbs;
  final double fibers;
  final double calcium;
  final double iron;
  final double zinc;
  final double magnesium;
  final double thiamineB1;
  final double riboflavinB2;
  final double niacinB3;
  final double folatesB9;
  final double retinolVitA;

  Ingredient({
    required this.ingredientName,
    required this.ingredientQuantity,
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
    required this.fibers,
    required this.calcium,
    required this.iron,
    required this.zinc,
    required this.magnesium,
    required this.thiamineB1,
    required this.riboflavinB2,
    required this.niacinB3,
    required this.folatesB9,
    required this.retinolVitA,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      ingredientName: json['ingredientName'],
      ingredientQuantity: json['ingredientQuantity'],
      calories: json['energy'],
      proteins: json['proteins'],
      fats: json['fats'],
      carbs: json['carbs'],
      fibers: json['fibers'],
      calcium: json['calcium'],
      iron: json['iron'],
      zinc: json['zinc'],
      magnesium: json['magnesium'],
      thiamineB1: json['thiamine_B1'] ?? 0,
      riboflavinB2: json['riboflavin_B2'] ?? 0,
      niacinB3: json['niacin_B3'] ?? 0,
      folatesB9: json['folates_B9'] ?? 0,
      retinolVitA: json['retinolVit_A'] ?? 0,
    );
  }
}
