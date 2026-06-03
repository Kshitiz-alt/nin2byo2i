//class for top 10 food
class FoodItem {
  final int id;
  final String food;
  final double nutritionName;

  FoodItem({required this.id, required this.food, required this.nutritionName});

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      food: json['food'],
      nutritionName: json['fat'],
    );
  }
}
