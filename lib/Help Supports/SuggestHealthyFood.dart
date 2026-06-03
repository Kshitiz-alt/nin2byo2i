import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//suggested health  screen
class SuggestHealthyFood extends StatelessWidget {
  const SuggestHealthyFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.themeColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ThemeManager.themelightColor,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png", // Replace with your health app logo asset path
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Health Diet Chart",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      // appBar: AppBar(
      //   title: Text('Health Diet Chart'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HealthConditionTile(condition: 'Anemia'),
            HealthConditionTile(condition: 'Celiac'),
            HealthConditionTile(condition: 'Diabetes'),
            HealthConditionTile(condition: 'High Blood Pressure'),
            HealthConditionTile(condition: 'Low Blood Pressure'),
            HealthConditionTile(condition: 'Thyroid'),
            HealthConditionTile(condition: 'Heart'),
          ],
        ),
      ),
    );
  }
}

class HealthConditionTile extends StatelessWidget {
  final String condition;

  const HealthConditionTile({super.key, required this.condition});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeManager.themelightColor.withOpacity(0.8),
          borderRadius:
              BorderRadius.circular(16.0), // Adjust the radius as needed
        ),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text(
                  condition,
                  style: TextStyle(
                    color: ThemeManager.themeText,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FoodListScreen(condition: condition),
                    ),
                  );
                },
              ),
            ),
            // Spacer (Empty Container can be used as well)
            const SizedBox(width: 8.0),
            // Icon
            // IconButton(
            //   onPressed: () {},
            //   icon: Image.asset(
            //     "assets/img/next_icon.png",
            //     width: 20,
            //     height: 20,
            //   ),
            // )
          ],
        ),
      ),
    );
    //  ListTile(
    //   title: Text('Diet Chart for $condition',
    //       style: TextStyle(
    //         color: Colors.black,
    //       )),
    //   onTap: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => FoodListScreen(condition: condition),
    //       ),
    //     );
    //   },
    // );
  }
}

class FoodListScreen extends StatelessWidget {
  final String condition;

  const FoodListScreen({super.key, required this.condition});

  List<FoodItem> getFoodItemsForCondition() {
    if (condition == 'Anemia') {
      return [
        FoodItem(
          name: 'Iron-Rich Smoothie',
          description: 'A smoothie packed with iron-rich ingredients.',
          ingredients: ['Spinach', 'Banana', 'Almond Butter'],
        ),
        FoodItem(
          name: 'Lean Beef',
          description: 'Grilled lean beef for a good source of heme iron.',
          ingredients: ['Beef', 'Olive Oil', 'Herbs'],
        ),
        FoodItem(
          name: 'Lentil Soup',
          description: 'A hearty lentil soup rich in iron and fiber.',
          ingredients: ['Lentils', 'Tomatoes', 'Carrots', 'Onions'],
        ),
        FoodItem(
          name: 'Oatmeal with Berries',
          description:
              'Oatmeal topped with berries for a nutritious breakfast.',
          ingredients: ['Oats', 'Berries', 'Almond Milk'],
        ),
        FoodItem(
          name: 'Salmon',
          description: 'Baked salmon for a good source of omega-3 fatty acids.',
          ingredients: ['Salmon', 'Lemon', 'Dill'],
        ),
      ];
    } else if (condition == 'Celiac') {
      return [
        FoodItem(
          name: 'Quinoa Salad',
          description: 'A gluten-free quinoa salad.',
          ingredients: ['Quinoa', 'Vegetables', 'Olive Oil'],
        ),
        FoodItem(
          name: 'Grilled Chicken Breast',
          description:
              'Grilled chicken breast without gluten-containing marinades.',
          ingredients: ['Chicken Breast', 'Lemon', 'Herbs'],
        ),
        FoodItem(
          name: 'Stir-Fried Vegetables',
          description:
              'Fresh stir-fried vegetables for a gluten-free side dish.',
          ingredients: ['Broccoli', 'Bell Peppers', 'Carrots', 'Tamari Sauce'],
        ),
        FoodItem(
          name: 'Baked Sweet Potato',
          description: 'Baked sweet potato as a gluten-free alternative.',
          ingredients: ['Sweet Potato', 'Olive Oil', 'Rosemary'],
        ),
        FoodItem(
          name: 'Quinoa Bowl with Avocado',
          description: 'A nutritious bowl with quinoa and avocado.',
          ingredients: ['Quinoa', 'Avocado', 'Cherry Tomatoes'],
        ),
      ];
    } else if (condition == 'Diabetes') {
      return [
        FoodItem(
          name: 'Quinoa and Vegetable Stir-Fry',
          description:
              'A delicious stir-fry with quinoa and a variety of vegetables.',
          ingredients: [
            'Quinoa',
            'Broccoli',
            'Bell Peppers',
            'Carrots',
            'Tofu',
            'Soy Sauce'
          ],
        ),
        FoodItem(
          name: 'Grilled Salmon with Lemon and Herbs',
          description: 'Grilled salmon seasoned with fresh lemon and herbs.',
          ingredients: ['Salmon', 'Lemon', 'Dill', 'Olive Oil'],
        ),
        FoodItem(
          name: 'Mixed Berry Smoothie',
          description:
              'A refreshing smoothie with mixed berries and Greek yogurt.',
          ingredients: [
            'Mixed Berries',
            'Greek Yogurt',
            'Almond Milk',
            'Chia Seeds'
          ],
        ),
        FoodItem(
          name: 'Chickpea and Spinach Salad',
          description:
              'A protein-packed salad with chickpeas, spinach, and a light vinaigrette.',
          ingredients: [
            'Chickpeas',
            'Spinach',
            'Cherry Tomatoes',
            'Olive Oil',
            'Balsamic Vinegar'
          ],
        ),
        FoodItem(
          name: 'Vegetable Omelette',
          description:
              'An omelette filled with colorful vegetables like bell peppers, onions, and tomatoes.',
          ingredients: ['Eggs', 'Bell Peppers', 'Onions', 'Tomatoes', 'Cheese'],
        ),
      ];
    } else if (condition == 'High Blood Pressure') {
      return [
        FoodItem(
          name: 'Mediterranean Salad',
          description:
              'A refreshing salad with tomatoes, cucumbers, olives, and feta cheese.',
          ingredients: [
            'Tomatoes',
            'Cucumbers',
            'Olives',
            'Feta Cheese',
            'Olive Oil'
          ],
        ),
        FoodItem(
          name: 'Baked Chicken Breast with Herbs',
          description:
              'Boneless, skinless chicken breast baked with a mix of herbs and spices.',
          ingredients: [
            'Chicken Breast',
            'Rosemary',
            'Thyme',
            'Garlic Powder',
            'Black Pepper'
          ],
        ),
        FoodItem(
          name: 'Quinoa and Black Bean Bowl',
          description:
              'A nutritious bowl with quinoa, black beans, and a variety of vegetables.',
          ingredients: [
            'Quinoa',
            'Black Beans',
            'Bell Peppers',
            'Corn',
            'Avocado'
          ],
        ),
        FoodItem(
          name: 'Oven-Roasted Salmon',
          description:
              'Salmon fillets oven-roasted with lemon, garlic, and dill.',
          ingredients: ['Salmon', 'Lemon', 'Garlic', 'Dill', 'Olive Oil'],
        ),
        FoodItem(
          name: 'Greek Yogurt Parfait with Berries',
          description:
              'A delicious parfait with Greek yogurt and mixed berries.',
          ingredients: ['Greek Yogurt', 'Mixed Berries', 'Granola', 'Honey'],
        ),
      ];
    } else if (condition == 'Low Blood Pressure') {
      return [
        FoodItem(
          name: 'Banana and Almond Butter Smoothie',
          description:
              'A smoothie with banana and almond butter for a quick energy boost.',
          ingredients: ['Banana', 'Almond Butter', 'Milk', 'Honey'],
        ),
        FoodItem(
          name: 'Salted Pretzels',
          description:
              'A snack of salted pretzels can help increase sodium intake.',
          ingredients: ['Pretzels'],
        ),
        FoodItem(
          name: 'Spinach and Feta Omelette',
          description:
              'An omelette with spinach and feta cheese for a nutrient boost.',
          ingredients: ['Eggs', 'Spinach', 'Feta Cheese', 'Olive Oil'],
        ),
        FoodItem(
          name: 'Chicken Noodle Soup',
          description:
              'A comforting soup with chicken, noodles, and vegetables.',
          ingredients: [
            'Chicken Broth',
            'Chicken Breast',
            'Carrots',
            'Celery',
            'Noodles'
          ],
        ),
        FoodItem(
          name: 'Trail Mix with Nuts and Dried Fruits',
          description:
              'A mix of nuts and dried fruits for a portable and nutritious snack.',
          ingredients: [
            'Almonds',
            'Walnuts',
            'Dried Cranberries',
            'Dried Apricots'
          ],
        ),
      ];
    } else if (condition == 'Thyroid') {
      return [
        FoodItem(
          name: 'Seaweed Salad',
          description: 'A salad made with seaweed, a rich source of iodine.',
          ingredients: ['Seaweed', 'Sesame Seeds', 'Soy Sauce', 'Rice Vinegar'],
        ),
        FoodItem(
          name: 'Baked Salmon with Dill',
          description:
              'Salmon baked with dill, a source of omega-3 fatty acids.',
          ingredients: ['Salmon', 'Dill', 'Lemon', 'Olive Oil'],
        ),
        FoodItem(
          name: 'Brazil Nuts',
          description: 'A snack of Brazil nuts, high in selenium.',
          ingredients: ['Brazil Nuts'],
        ),
        FoodItem(
          name: 'Greek Yogurt Parfait with Berries',
          description:
              'A parfait with Greek yogurt and antioxidant-rich berries.',
          ingredients: ['Greek Yogurt', 'Mixed Berries', 'Granola', 'Honey'],
        ),
        FoodItem(
          name: 'Spinach and Kale Smoothie',
          description:
              'A green smoothie with spinach and kale for nutrient density.',
          ingredients: ['Spinach', 'Kale', 'Banana', 'Almond Milk'],
        ),
      ];
    } else if (condition == 'Heart') {
      return [
        FoodItem(
          name: 'Oatmeal with Berries',
          description:
              'Oatmeal topped with antioxidant-rich berries for a heart-healthy breakfast.',
          ingredients: ['Oats', 'Mixed Berries', 'Almond Milk', 'Chia Seeds'],
        ),
        FoodItem(
          name: 'Grilled Salmon with Lemon',
          description: 'Salmon grilled with lemon for omega-3 fatty acids.',
          ingredients: ['Salmon', 'Lemon', 'Dill', 'Olive Oil'],
        ),
        FoodItem(
          name: 'Mixed Nuts',
          description:
              'A mix of nuts (almonds, walnuts, and pistachios) for heart-healthy fats.',
          ingredients: ['Almonds', 'Walnuts', 'Pistachios'],
        ),
        FoodItem(
          name: 'Mediterranean Chickpea Salad',
          description:
              'A refreshing salad with chickpeas, tomatoes, cucumbers, and feta cheese.',
          ingredients: [
            'Chickpeas',
            'Tomatoes',
            'Cucumbers',
            'Feta Cheese',
            'Olive Oil'
          ],
        ),
        FoodItem(
          name: 'Dark Chocolate',
          description:
              'Dark chocolate with a high cocoa content for antioxidant benefits.',
          ingredients: ['Dark Chocolate'],
        ),
      ];
    }

    // Add conditions for other health conditions

    return [];
  }

  List<String> getFoodsToAvoid() {
    if (condition == 'Anemia') {
      return [
        'Red Meat (in excessive amounts)',
        'Dairy Products',
        'Tea and Coffee (with meals)',
        'Processed Foods with Calcium',
      ];
    } else if (condition == 'Celiac') {
      return [
        'Wheat and Wheat Products',
        'Barley',
        'Rye',
        'Processed Foods with Gluten',
        'Beer',
      ];
    } else if (condition == 'Diabetes') {
      return [
        'Sugary Foods and Beverages',
        'White Bread and Refined Grains',
        'Fried Foods',
        'Highly Processed Foods',
        'Sweetened Drinks',
      ];
    } else if (condition == 'High Blood Pressure') {
      return [
        'High-Sodium Foods (e.g., processed meats, canned soups)',
        'Excessive Salt',
        'Fried Foods',
        'Processed Foods with Added Sodium',
        'Sugary Drinks',
      ];
    } else if (condition == 'Low Blood Pressure') {
      return [
        'Caffeine (in excessive amounts)',
        'Alcohol',
        'Salty Foods (in moderation)',
        'Processed and Sugary Foods',
        'Low-Fiber Foods',
      ];
    } else if (condition == 'Thyroid') {
      return [
        'Cruciferous Vegetables (in excess, e.g., broccoli, cabbage)',
        'Soy and Soy Products',
        'Processed Foods with Artificial Additives',
        'Excessive Iodine (supplements)',
        'High-Fat Foods',
      ];
    } else if (condition == 'Heart') {
      return [
        'Trans Fats (partially hydrogenated oils)',
        'Processed Meats (e.g., bacon, sausage)',
        'Sugary Foods and Beverages',
        'Excessive Salt',
        'Fried Foods',
      ];
    }

    // Add conditions for other health conditions

    return [];
  }

  @override
  Widget build(BuildContext context) {
    List<FoodItem> foodItems = getFoodItemsForCondition();
    List<String> foodsToAvoid = getFoodsToAvoid();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.themeColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ThemeManager.themelightColor,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png", // Replace with your health app logo asset path
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Diet Chart for $condition",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      // appBar: AppBar(
      //   title: Text('Diet Chart for $condition'),
      // ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Foods to Avoid',
                style: TextStyle(
                  color: ThemeManager.themeText,
                )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: foodsToAvoid
                  .map((food) =>
                      Text('- $food', style: const TextStyle(color: Colors.red)))
                  .toList(),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text('Recommended Foods',
                style: TextStyle(
                  color: ThemeManager.themeText,
                )),
          ),
          const Divider(),
          ...foodItems
              .map((foodItem) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                ThemeManager.themelightColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(
                                16.0), // Adjust the radius as needed
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    foodItem.name,
                                    style: TextStyle(
                                      color: ThemeManager.themeText,
                                    ),
                                  ),
                                  subtitle: Text(foodItem.description,
                                      style: TextStyle(
                                        color: ThemeManager.themeText,
                                      )),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodDetailsScreen(
                                          foodItem: foodItem,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Spacer (Empty Container can be used as well)
                              // SizedBox(width: 8.0),
                              // // Icon
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: Image.asset(
                              //     "assets/img/next_icon.png",
                              //     width: 20,
                              //     color: ThemeManager.themeText,
                              //     height: 20,
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      )
                  // ListTile(
                  //       title: Text(foodItem.name,
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //           )),
                  //       subtitle: Text(foodItem.description,
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //           )),
                  //       onTap: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => FoodDetailsScreen(
                  //               foodItem: foodItem,
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     )
                  )
              .toList(),
        ],
      ),
    );
  }
}

class FoodItem {
  final String name;
  final String description;
  final List<String> ingredients;

  FoodItem({
    required this.name,
    required this.description,
    required this.ingredients,
  });
}

class FoodDetailsScreen extends StatelessWidget {
  final FoodItem foodItem;

  const FoodDetailsScreen({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.themeColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ThemeManager.themelightColor,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png", // Replace with your health app logo asset path
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          foodItem.name,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      // appBar: AppBar(
      //   title: Text(foodItem.name),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${foodItem.description}',
                style: TextStyle(
                  color: ThemeManager.themeText,
                )),
            const SizedBox(height: 16),
            Text('Ingredients:',
                style: TextStyle(
                  color: ThemeManager.themeText,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: foodItem.ingredients
                  .map((ingredient) => Text('- $ingredient',
                      style: TextStyle(
                        color: ThemeManager.themeText,
                      )))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
