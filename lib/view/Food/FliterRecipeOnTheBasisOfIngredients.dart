import 'package:flutter/material.dart';
import 'package:nin2byo2i/Classes/Food Classes/RecipyDataOf100Gram.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/view/Food/SearchCookedFood.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//filter recipy page on the basis of ingredients
class FilterPage extends StatefulWidget {
  final List<Recipe> allRecipes;

  const FilterPage({super.key, required this.allRecipes});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedIngredient = 'Protein';

  @override
  Widget build(BuildContext context) {
    List<Recipe> sortedRecipes = _sortRecipes();
    double screenWidth = MediaQuery.of(context).size.width;
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
              "assets/img/black_btn.png",
              color: ThemeManager.themeText,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Nutrients in 100g",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: Column(
        children: [
          _buildDropdown(),
          // _buildSelectedIngredient(),
          Expanded(
            child: ListView.builder(
              itemCount: sortedRecipes.length,
              itemBuilder: (context, index) {
                Recipe recipe = sortedRecipes[index];
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: TColor.primaryColor1.withOpacity(0.3)),
                      color: ThemeManager.themelightColor),
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: ListTile(
                    leading: Image.asset(
                      "assets/img/foodimage.png",
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      recipe.recipeName,
                      style: TextStyle(color: ThemeManager.themeText),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/img/proteins.png",
                              width: 15,
                              height: 15,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            SizedBox(
                              width: screenWidth * 0.5,
                              child: Text(
                                '$selectedIngredient: ${_getIngredientValue(recipe)}',
                                style: TextStyle(color: ThemeManager.themeText),
                              ),
                            ),
                          ],
                        ),
                        // Text('Protein: ${recipe.protein.toString()}g'),
                        // Text('Energy: ${recipe.energyJoules.toString()}g'),
                        // Text('Fat: ${recipe.totalFat.toString()}g'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailPage(recipe: recipe),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          // gradient: LinearGradient(colors: [
          //   ThemeManager.themeText.withOpacity(0.1),
          //   ThemeManager.themeText.withOpacity(0.3),
          // ]),
          color: const Color(0xFF007BC1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButton<String>(
          value: selectedIngredient,
          onChanged: (String? newValue) {
            setState(() {
              selectedIngredient = newValue!;
            });
          },
          style: const TextStyle(color: Colors.white),
          dropdownColor: const Color(0xFF007BC1),
          icon: const Icon(Icons.expand_more, color: Colors.white),
          underline: Container(),
          menuMaxHeight: 400,
          items: [
            'Energy',
            'Carbohydrate',
            'Fat',
            'Sodium',
            'Dietary fibre',
            'Calcium',
            'Iron',
            'Magnesium',
            'Zinc',
            'Protein',
            'Thiamine',
            'Riboflavin',
            'Niacin',
            'Vitamin B6',
            'Folate',
            'Vitamin C',
            'Vitamin A'

            //         recipesId: json['recipesId'],
            // recipeName: json['recipeName'],
            // protein: json['protein'],
            // totalFat: json['totalFat'],
            // totalDietaryFibre: json['totalDietaryFibre'],
            // carbohydrate: json['carbohydrate'],
            // energyJoules: json['energyKcal'] * 4.184, // converting kcal to Joules
            // riboflavinB2: json['riboflavinB2'],
            // // "niacin": 0.55,
            // totalB6: json['vitaminB6'],
            // totalFolateB9: json['folateB9'],
            // totalAscorbicAcid: json['vitaminC'],
            // retinol: json['vitaminA'],
            // totalCarotenoids:
            //     json['vitaminA'], // I assumed totalCarotenoids same as vitaminA

            // iron: json['iron'],
            // zinc: json['zinc'],
            // sodium: json['sodium'],
            // calcium: json['calcium'],
            // magnesium: json['magnesium']
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Widget _buildSelectedIngredient() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Text(
  //       'Selected Ingredient: $selectedIngredient',
  //       style: TextStyle(fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }

  // double _getIngredientValue(Recipe recipe) {
  //   switch (selectedIngredient) {
  //     case 'Protein':
  //       return recipe.protein;
  //     case 'Total Fat':
  //       return recipe.totalFat;
  //     case 'Total Dietary Fibre':
  //       return recipe.totalDietaryFibre;
  //     case 'Carbohydrate':
  //       return recipe.carbohydrate;
  //     case 'Energy Joules':
  //       return recipe.energyJoules;
  //     case 'Riboflavin B2':
  //       return recipe.riboflavinB2;
  //     case 'Total B6':
  //       return recipe.totalB6;
  //     case 'Total Folate B9':
  //       return recipe.totalFolateB9;
  //     case 'Total Ascorbic Acid':
  //       return recipe.totalAscorbicAcid;
  //     case 'Retinol':
  //       return recipe.retinol;
  //     case 'Total Carotenoids':
  //       return recipe.totalCarotenoids;
  //     case 'Ergocalciferol D2':
  //       return recipe.ergocalciferolD2;
  //     case 'Cholecalciferol D3':
  //       return recipe.cholecalciferolD3;
  //     case 'Vitamin 25 Hydroxy D3':
  //       return recipe.vitamin25HydroxyD3;
  //     case 'Iron':
  //       return recipe.iron;
  //     case 'Zinc':
  //       return recipe.zinc;
  //     case 'Potassium':
  //       return recipe.potassium;
  //     case 'Sodium':
  //       return recipe.sodium;
  //     case 'Calcium':
  //       return recipe.calcium;
  //     case 'Total Saturated Fatty Acids':
  //       return recipe.totalSaturatedFattyAcids;
  //     default:
  //       return 0.0; // default value, you may want to handle this differently
  //   }
  // }
  String _getIngredientValue(Recipe recipe) {
    switch (selectedIngredient) {
      case 'Protein':
        return "${recipe.protein.toStringAsFixed(recipe.protein >= 99 ? 0 : 2)} g";
      case 'Fat':
        return "${recipe.totalFat.toStringAsFixed(recipe.totalFat >= 99 ? 0 : 2)} g";
      case 'Dietary fibre':
        return "${recipe.totalDietaryFibre
                .toStringAsFixed(recipe.totalDietaryFibre >= 99 ? 0 : 2)} g";
      case 'Carbohydrate':
        return "${recipe.carbohydrate
                .toStringAsFixed(recipe.carbohydrate >= 99 ? 0 : 2)} g";
      case 'Energy':
        return "${recipe.energyJoules
                .toStringAsFixed(recipe.energyJoules >= 99 ? 0 : 2)} Kcal";
      case 'Riboflavin':
        return "${recipe.riboflavinB2
                .toStringAsFixed(recipe.riboflavinB2 >= 99 ? 0 : 2)} mg";
      case 'Vitamin B6':
        return "${recipe.vitaminB6
                .toStringAsFixed(recipe.vitaminB6 >= 99 ? 0 : 2)} mg";
      case 'Folate':
        return "${recipe.totalFolateB9
                .toStringAsFixed(recipe.totalFolateB9 >= 99 ? 0 : 2)} µg";
      case 'Iron':
        return "${recipe.iron.toStringAsFixed(recipe.iron >= 99 ? 0 : 2)} mg";
      case 'Zinc':
        return "${recipe.zinc.toStringAsFixed(recipe.zinc >= 99 ? 0 : 2)} mg";
      case 'Sodium':
        return "${recipe.sodium.toStringAsFixed(recipe.sodium >= 99 ? 0 : 2)} mg";
      case 'Calcium':
        return "${recipe.calcium.toStringAsFixed(recipe.calcium >= 99 ? 0 : 2)} mg";
      case "Niacin":
        return "${recipe.niacin.toStringAsFixed(recipe.niacin >= 99 ? 0 : 2)} mg";
      case "Magnesium":
        return "${recipe.magnesium
                .toStringAsFixed(recipe.magnesium >= 99 ? 0 : 2)} mg";
      case 'Thiamine':
        return "${recipe.thiamine.toStringAsFixed(recipe.thiamine >= 99 ? 0 : 2)} mg";
      case 'Vitamin C':
        return "${recipe.vitaminC.toStringAsFixed(recipe.vitaminC >= 99 ? 0 : 2)} mg";
      case 'Vitamin A':
        return "${recipe.vitaminA.toStringAsFixed(recipe.vitaminA >= 99 ? 0 : 2)} µg";
      default:
        return "0.0"; // default value, you may want to handle this differently
    }
  }

  List<Recipe> _sortRecipes() {
    List<Recipe> sortedRecipes = List.from(widget.allRecipes);

    switch (selectedIngredient) {
      case 'Protein':
        sortedRecipes.sort((a, b) =>
            b.protein.compareTo(a.protein)); // Reverse order for Protein
        break;
      case 'Total Fat':
        sortedRecipes.sort((a, b) =>
            b.totalFat.compareTo(a.totalFat)); // Reverse order for Total Fat
        break;
      case 'Total Dietary Fibre':
        sortedRecipes.sort((a, b) => b.totalDietaryFibre.compareTo(
            a.totalDietaryFibre)); // Reverse order for Total Dietary Fibre
        break;
      case 'Carbohydrate':
        sortedRecipes.sort((a, b) => b.carbohydrate
            .compareTo(a.carbohydrate)); // Reverse order for Carbohydrate
        break;
      case 'Energy Joules':
        sortedRecipes.sort((a, b) => b.energyJoules
            .compareTo(a.energyJoules)); // Reverse order for Energy Joules
        break;
      case 'Riboflavin B2':
        sortedRecipes.sort((a, b) => b.riboflavinB2.compareTo(a.riboflavinB2));
        break;
      case 'Total B6':
        sortedRecipes.sort((a, b) => b.vitaminB6.compareTo(a.vitaminB6));
        break;
      case 'Total Folate B9':
        sortedRecipes
            .sort((a, b) => b.totalFolateB9.compareTo(a.totalFolateB9));
        break;

      case 'Iron':
        sortedRecipes.sort((a, b) => b.iron.compareTo(a.iron));
        break;
      case 'Zinc':
        sortedRecipes.sort((a, b) => b.zinc.compareTo(a.zinc));
        break;
      case "Niacin":
        sortedRecipes.sort((a, b) => b.niacin.compareTo(a.zinc));
        break;
      case "Magnesium":
        sortedRecipes.sort((a, b) => b.magnesium.compareTo(a.zinc));
        break;
      // case 'Potassium':
      //   sortedRecipes.sort((a, b) => b.potassium.compareTo(a.potassium));
      // break;
      case 'Sodium':
        sortedRecipes.sort((a, b) => b.sodium.compareTo(a.sodium));
        break;
      case 'Calcium':
        sortedRecipes.sort((a, b) => b.calcium.compareTo(a.calcium));
        break;
      // case 'Total Saturated Fatty Acids':
      //   sortedRecipes.sort((a, b) =>
      //       b.totalSaturatedFattyAcids.compareTo(a.totalSaturatedFattyAcids));
      //   break;
      // Add cases for other ingredients
    }

    return sortedRecipes;
  }
}
