import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//health recommandation screen
class HealthRecommendationsPage extends StatelessWidget {
  const HealthRecommendationsPage({super.key});

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
          "Health Recommendations",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HealthConditionTile(condition: 'Food to Eat'),
            HealthConditionTile(condition: 'Food to Avoid'),
            HealthConditionTile(condition: 'Best Vegetarian Iron-Rich Foods'),
            HealthConditionTile(
                condition: 'Best Non-Vegetarian Iron-Rich Foods'),
            HealthConditionTile(condition: 'Sound Sleep Tips'),
            HealthConditionTile(condition: 'Weight Loss Tips'),
            HealthConditionTile(condition: 'Weight Gain Tips'),
            HealthConditionTile(condition: 'Tips for General Fitness'),
            HealthConditionTile(condition: 'Digestion & Metabolism Tips'),
            HealthConditionTile(condition: 'Diet Plan for Anemia Patients'),
            HealthConditionTile(condition: 'Hypotension (Low BP)'),
            HealthConditionTile(condition: 'Hypertension (High BP)'),
            HealthConditionTile(condition: 'Diabetes Care'),
            HealthConditionTile(condition: 'Celiac Disease'),
            HealthConditionTile(condition: 'Thyroid Care'),
            HealthConditionTile(condition: 'Heart Care'),
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
                          HealthConditionDetailsScreen(condition: condition),
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
            //     height: 20,
            //   ),
            // )
          ],
        ),
      ),
    );

    // ListTile(
    //   title: Text(condition,
    //       style: TextStyle(
    //         color: ThemeManager.themeText,
    //       )),
    //   onTap: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) =>
    //             HealthConditionDetailsScreen(condition: condition),
    //       ),
    //     );
    //   },
    // );
  }
}

class HealthConditionDetailsScreen extends StatelessWidget {
  final String condition;

  const HealthConditionDetailsScreen({super.key, required this.condition});

  List<String> getContentForCondition() {
    switch (condition) {
      case 'Food to Eat':
        return [
          'Fruits: Apples, Bananas, Berries, etc.',
          'Vegetables: Broccoli, Spinach, Carrots, etc.',
          'Lean Proteins: Chicken, Fish, Tofu, etc.',
          'Whole Grains: Quinoa, Brown Rice, Oats, etc.',
          'Nuts and Seeds: Almonds, Walnuts, Chia Seeds, etc.',
          'Low-Fat Dairy: Milk, Yogurt, Cheese, etc.',
          'Healthy Fats: Avocado, Olive Oil, Nuts, etc.',
          'Legumes: Lentils, Chickpeas, Black Beans, etc.',
          'Fish: Salmon, Mackerel, Sardines, etc.',
          'Water: Stay hydrated throughout the day.',
        ];
      case 'Food to Avoid':
        return [
          'Processed Foods: Chips, Fast Food, etc.',
          'Sugary Beverages: Soda, Energy Drinks, etc.',
          'Trans Fats: Fried Foods, Baked Goods, etc.',
          'Excessive Salt: High-Sodium Foods, etc.',
          'Added Sugars: Candies, Pastries, Sweetened Drinks, etc.',
          'Red and Processed Meats: Bacon, Sausages, Hot Dogs, etc.',
          'Refined Grains: White Bread, White Rice, etc.',
          'Alcohol: Limit consumption for overall health.',
          'Artificial Sweeteners: Found in some diet products.',
          'High-Caffeine Foods: Limit for better sleep.',
        ];
      case 'Best Vegetarian Iron-Rich Foods':
        return [
          'Spinach: High in iron and vitamin C for better absorption.',
          'Lentils: Excellent source of iron and protein.',
          'Chickpeas: Packed with iron and fiber.',
          'Tofu: Contains iron and is a versatile meat substitute.',
          'Quinoa: Iron-rich whole grain.',
          'Beans: Kidney beans, black beans, etc., are good sources of iron.',
          'Nuts and Seeds: Almonds, pumpkin seeds, etc., provide iron.',
          'Dried Fruits: Raisins, apricots, and prunes are iron-rich.',
          'Whole Grains: Brown rice, oats, and barley are iron-containing grains.',
          'Dark Chocolate: Enjoy in moderation for an iron boost.',
        ];
      case 'Best Non-Vegetarian Iron-Rich Foods':
        return [
          'Lean Beef: Excellent source of heme iron.',
          'Chicken: Provides heme iron and is a lean protein source.',
          'Salmon: Rich in iron and omega-3 fatty acids.',
          'Turkey: Good source of heme iron and protein.',
          'Shellfish: Clams, oysters, and mussels are iron-rich seafood.',
          'Organ Meats: Liver and kidneys are high in heme iron.',
          'Eggs: Iron is found in the yolk, along with other nutrients.',
          'Pork: Lean pork cuts contain iron.',
          'Fish: Haddock, perch, and tuna are iron-containing fish.',
          'Turkey: Provides heme iron and is a lean protein source.',
        ];
      case 'Sound Sleep Tips':
        return [
          'Maintain a consistent sleep schedule: Go to bed and wake up at the same time daily.',
          'Create a relaxing bedtime routine: Develop calming activities before sleep.',
          'Keep the bedroom dark and quiet: Minimize light and noise for better rest.',
          'Limit screen time before bedtime: Reduce exposure to screens at least an hour before sleep.',
          'Avoid caffeine and heavy meals close to bedtime: Both can disrupt sleep.',
          'Invest in a comfortable mattress and pillows: Ensure a supportive sleep environment.',
          'Exercise regularly: Physical activity can promote better sleep.',
          'Manage stress: Practice relaxation techniques before bedtime.',
          'Limit naps: Short naps earlier in the day can be beneficial.',
          'Avoid alcohol and smoking: Both can interfere with sleep quality.',
        ];
      case 'Weight Loss Tips':
        return [
          'Follow a balanced diet with a calorie deficit: Consume fewer calories than you burn.',
          'Engage in regular physical activity: Include both cardio and strength training exercises.',
          'Stay hydrated and avoid sugary beverages: Choose water as your primary drink.',
          'Get enough sleep to support weight loss: Aim for 7-9 hours per night.',
          'Monitor portion sizes and practice mindful eating: Be aware of what and how much you eat.',
          'Choose nutrient-dense foods: Prioritize foods rich in vitamins and minerals.',
          'Limit processed and high-calorie foods: Focus on whole, unprocessed options.',
          'Set realistic and achievable goals: Celebrate small successes along the way.',
          'Seek support: Share your goals with friends, family, or a healthcare professional.',
          'Be patient and consistent: Sustainable weight loss takes time and commitment.',
        ];
      case 'Weight Gain Tips':
        return [
          'Consume more calories than your body burns: Create a calorie surplus.',
          'Include protein-rich foods in your diet: Meat, dairy, legumes, and nuts are good sources.',
          'Eat frequent, smaller meals throughout the day: Opt for nutrient-dense snacks.',
          'Strength training exercises: Build muscle mass through weightlifting.',
          'Choose nutrient-dense foods for weight gain: Focus on quality calories.',
          'Add healthy fats to your diet: Avocado, olive oil, and nuts can contribute to calorie intake.',
          'Stay hydrated: Drink fluids between meals to avoid feeling too full.',
          'Include dairy: Milk, cheese, and yogurt are calorie-dense options.',
          'Snack before bedtime: A small, nutritious snack can provide extra calories.',
          'Consult a nutritionist or healthcare professional: Get personalized advice for healthy weight gain.',
        ];
      case 'Tips for General Fitness':
        return [
          'Combine cardio and strength training exercises: Achieve a well-rounded fitness routine.',
          'Set realistic fitness goals: Define clear objectives for motivation.',
          'Stay hydrated during workouts: Drink water before, during, and after exercise.',
          'Listen to your body and rest when needed: Allow time for recovery.',
          'Include flexibility exercises in your routine: Stretch regularly for joint health.',
          'Vary your workouts: Prevent boredom and challenge different muscle groups.',
          'Prioritize proper form: Ensure youre performing exercises correctly to avoid injury.',
          'Include rest days: Allow your body time to recover and prevent burnout.',
          'Warm-up before exercise: Increase blood flow and reduce the risk of injury.',
          'Find activities you enjoy: Make fitness a sustainable and enjoyable part of your lifestyle.',
        ];
      case 'Digestion & Metabolism Tips':
        return [
          'Eat fiber-rich foods for better digestion: Include fruits, vegetables, and whole grains.',
          'Stay hydrated to support metabolism: Water is essential for metabolic processes.',
          'Include probiotics in your diet: Yogurt, kefir, and sauerkraut promote gut health.',
          'Avoid overeating and practice portion control: Listen to your body’s hunger and fullness cues.',
          'Engage in regular physical activity to boost metabolism: Both cardio and strength training are beneficial.',
          'Chew your food thoroughly: Proper chewing aids digestion.',
          'Limit high-fat and greasy foods: These can slow down digestion.',
          'Manage stress: Stress can impact digestion and metabolism.',
          'Include digestive enzymes if needed: Consult with a healthcare professional.',
          'Get regular check-ups: Ensure overall digestive and metabolic health.',
        ];
      case 'Diet Plan for Anemia Patients':
        return [
          'Iron-Rich Smoothie: Spinach, Banana, Almond Butter.',
          'Lean Beef: Grilled lean beef with olive oil and herbs.',
          'Lentil Soup: Hearty lentil soup with tomatoes and carrots.',
          'Oatmeal with Berries: Oats topped with berries and almond milk.',
          'Salmon: Baked salmon for omega-3 fatty acids.',
          'Dark Leafy Greens: Kale, collard greens, and Swiss chard for iron.',
          'Vitamin C-Rich Foods: Oranges, strawberries, and bell peppers to enhance iron absorption.',
          'Fortified Cereals: Choose cereals enriched with iron and other nutrients.',
          'Eggs: Good source of protein and iron.',
          'Legumes: Beans, peas, and lentils provide iron and protein.',
        ];
      case 'Hypotension (Low BP)':
        return [
          'Increase Salt Intake: Consult with a healthcare professional before making changes.',
          'Stay Hydrated: Drink plenty of fluids to help raise blood volume.',
          'Wear Compression Stockings: Help reduce the pooling of blood in the legs.',
          'Avoid Alcohol in Excess: Can lower blood pressure further.',
          'Eat Small, Low-Carb Meals Throughout the Day: Prevents a sudden drop in blood pressure.',
          'Stand Up Gradually: Avoid sudden changes in position.',
          'Limit Caffeine: Monitor how your body responds to caffeine.',
          'Add More Electrolytes: Include potassium-rich foods like bananas.',
          'Avoid Hot Baths: Heat can cause blood vessels to dilate.',
          'Exercise Regularly: Consult with a healthcare professional for appropriate exercises.',
        ];
      case 'Hypertension (High BP)':
        return [
          'DASH Diet: Focus on fruits, vegetables, and low-fat dairy products.',
          'Reduce Sodium Intake: Limit processed foods and use herbs for flavoring.',
          'Regular Exercise: Aim for at least 150 minutes of moderate-intensity exercise per week.',
          'Maintain a Healthy Weight: Lose weight if overweight and maintain a healthy BMI.',
          'Limit Alcohol Consumption: Moderate alcohol intake, if any.',
          'Quit Smoking: Smoking can raise blood pressure.',
          'Manage Stress: Practice stress-reducing activities like meditation and yoga.',
          'Monitor Blood Pressure Regularly: Keep track of your blood pressure at home.',
          'Limit Caffeine: Too much caffeine can temporarily raise blood pressure.',
          'Take Medications as Prescribed: Follow your healthcare provider’s recommendations.',
        ];
      case 'Diabetes Care':
        return [
          'Balanced Diet: Monitor carbohydrate intake and choose whole foods.',
          'Regular Physical Activity: Include both aerobic and strength training exercises.',
          'Regular Blood Sugar Monitoring: Keep track of blood glucose levels as advised.',
          'Medication Adherence: Take prescribed medications as directed by your healthcare provider.',
          'Stress Management: Practice stress-reducing activities such as mindfulness and deep breathing.',
          'Adequate Sleep: Aim for 7-9 hours of quality sleep per night.',
          'Limit Alcohol Intake: Consume alcohol in moderation or as advised by your healthcare provider.',
          'Regular Medical Check-ups: Stay proactive with diabetes management.',
          'Stay Hydrated: Drink plenty of water throughout the day.',
          'Foot Care: Check feet regularly for any cuts or wounds.',
        ];
      case 'Celiac Disease':
        return [
          'Gluten-Free Diet: Strictly avoid wheat, barley, and rye.',
          'Quinoa Salad: Enjoy a salad with gluten-free quinoa and fresh vegetables.',
          'Grilled Chicken Breast: Opt for grilled chicken without gluten-containing marinades.',
          'Stir-Fried Vegetables: Prepare stir-fried vegetables',
          'Stir-Fried Vegetables: Prepare stir-fried vegetables without gluten-containing sauces.',
          'Baked Sweet Potato: Enjoy baked sweet potatoes as a gluten-free alternative.',
          'Fresh Fruits: Include a variety of fresh fruits in your diet.',
          'Gluten-Free Oats: If tolerated, choose certified gluten-free oats.',
          'Nuts and Seeds: Snack on gluten-free nuts and seeds.',
          'Legumes: Beans and lentils can be excellent sources of protein.',
          'Dairy: Choose lactose-free dairy products.',
          'Gluten-Free Baking: Explore gluten-free baking with alternative flours like almond or coconut flour.',
        ];
      case 'Thyroid Care':
        return [
          'Seaweed Salad: Enjoy a salad with iodine-rich seaweed.',
          'Baked Salmon with Dill: Incorporate baked salmon for omega-3 fatty acids.',
          'Brazil Nuts: Snack on Brazil nuts for selenium, important for thyroid function.',
          'Greek Yogurt Parfait: Create a parfait with Greek yogurt and antioxidant-rich berries.',
          'Spinach and Kale Smoothie: Make a green smoothie for nutrient density.',
          'Berries: Blueberries, strawberries, and raspberries are rich in antioxidants.',
          'Lean Proteins: Include lean proteins like chicken and turkey.',
          'Whole Grains: Choose whole grains like quinoa and brown rice.',
          'Colorful Vegetables: Consume a variety of colorful vegetables.',
          'Hydration: Stay well-hydrated with water and herbal teas.',
        ];
      case 'Heart Care':
        return [
          'Oatmeal with Berries: Enjoy oatmeal topped with antioxidant-rich berries for heart health.',
          'Grilled Salmon with Lemon: Incorporate grilled salmon for omega-3 fatty acids.',
          'Mixed Nuts: Snack on a mix of heart-healthy nuts like almonds and walnuts.',
          'Mediterranean Chickpea Salad: Prepare a salad with chickpeas, tomatoes, and cucumbers.',
          'Dark Chocolate: Indulge in dark chocolate with high cocoa content for antioxidants.',
          'Leafy Greens: Include leafy greens like kale and spinach for vitamin K.',
          'Berries: Blueberries and strawberries contain compounds beneficial for heart health.',
          'Olive Oil: Use olive oil as a healthy alternative to saturated fats.',
          'Avocado: Add avocado to salads or as a spread for monounsaturated fats.',
          'Garlic: Incorporate garlic into your cooking for potential cardiovascular benefits.',
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> content = getContentForCondition();

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
          "$condition Details",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: ListView(
        children: [
          ...content
              .map((item) => ListTile(
                    title: Text(item,
                        style: TextStyle(
                          color: ThemeManager.themeText,
                        )),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
