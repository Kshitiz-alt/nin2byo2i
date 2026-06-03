import 'dart:convert';
import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Classes/Food%20Classes/RecipyDataOf100Gram.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Repository/auth_repo.dart';
import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/constants/server.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/FliterRecipeOnTheBasisOfIngredients.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

//user can search food from here
class SearchCookedFood extends StatefulWidget {
  const SearchCookedFood({super.key});

  @override
  _SearchCookedFoodState createState() => _SearchCookedFoodState();
}

class _SearchCookedFoodState extends State<SearchCookedFood> {
  List<Recipe> allRecipes = [];
  List<Recipe> displayedRecipes = [];

  TextEditingController searchController = TextEditingController();

  bool isLoadingScreenCheck = true;
  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    setState(() {
      isLoadingScreenCheck = true;
    });
    String? token = await AuthRepo.getToken();
    if (token != null) {
      debugPrint("Token: $token");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    final response = await http.get(
      Uri.parse('${API.server}/recipes/all'),
      // headers: headers
    );
    // final response = await http.get(Uri.parse('YOUR_API_ENDPOINT')); // Replace with your actual API endpoint
    if (response.statusCode == 200) {
      debugPrint("vhfdkvndjkbnjkfbkjfnjbk ${response.body}");
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        isLoadingScreenCheck = false;
        allRecipes = data.map((json) => Recipe.fromJson(json)).toList();
        allRecipes.sort((a, b) => a.recipeName.compareTo(b.recipeName));
        displayedRecipes = List.from(allRecipes);
        // displayedRecipes.sort((a, b) => a.recipeName.compareTo(b.recipeName));
      });
    } else {
      debugPrint("vhfdkvndjkbnjkfbkjfnjbk 44 ${response.body}");
      throw Exception('Failed to load recipes');
    }
  }

  void filterRecipes(String query) {
    setState(() {
      displayedRecipes = allRecipes
          .where((recipe) =>
              recipe.recipeName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.themeColor,
        centerTitle: true,
        elevation: 0,
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Container(
        //     margin: const EdgeInsets.all(8),
        //     height: 40,
        //     width: 40,
        //     alignment: Alignment.center,
        //     decoration: BoxDecoration(
        //         color: ThemeManager.themelightColor,
        //         borderRadius: BorderRadius.circular(10)),
        //     child: Image.asset(
        //       "assets/img/black_btn.png",
        //       color: ThemeManager.themeText,
        //       width: 15,
        //       height: 15,
        //       fit: BoxFit.contain,
        //     ),
        //   ),
        // ),
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
          "${Languages.of(context)!.mainlabelRecipes} (100g)",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (allRecipes.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilterPage(allRecipes: allRecipes),
                  ),
                );
              } else {
                // Handle the case where allRecipes is empty, e.g., show a message to the user.
                debugPrint("Cannot proceed with an empty list of recipes");
              }
            },
            icon: Icon(
              Icons.filter_list,
              color: ThemeManager.themeText,
            ),
          )
          // SizedBox(
          //   height: 20,
          //   child: ElevatedButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => FilterPage(allRecipes: allRecipes),
          //           ),
          //         );
          //       },
          //       child: Row(
          //         children: [
          //           Text("Filter"),
          //           Icon(Icons.filter_list),
          //         ],
          //       )),
          // )
        ],
      ),
      backgroundColor: ThemeManager.themeColor,
      body: isLoadingScreenCheck
          ? const CommonDataLoadingScreen()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeManager.themelightColor,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              onChanged: filterRecipes,
                              decoration: InputDecoration(
                                hintText: Languages.of(context)!
                                    .mainlabelSearchByFoodName,
                                border: InputBorder.none,
                                labelStyle: TextStyle(
                                  color: ThemeManager.themeText,
                                ),
                                hintStyle: TextStyle(
                                  color: ThemeManager.themeText,
                                ),
                                // border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: ThemeManager.themeText,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: ThemeManager.themeText,
                            ),
                            onPressed: () {
                              searchController.clear();
                              filterRecipes('');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: displayedRecipes.length,
                      itemBuilder: (context, index) {
                        Recipe recipe = displayedRecipes[index];
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  color: TColor.primaryColor1.withOpacity(0.3)),
                              color: ThemeManager.themelightColor),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          child: ListTile(
                            leading: Image.asset(
                              "assets/img/cooked recipy.png",
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
                                    Text(
                                      '${Languages.of(context)!.Foodprotein} : ${recipe.protein.toStringAsFixed(recipe.protein >= 99 ? 0 : 2)} g',
                                      style: TextStyle(
                                          color: ThemeManager.themeText),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/img/burn.png",
                                      width: 15,
                                      height: 15,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      '${Languages.of(context)!.Foodenergy} : ${recipe.energyJoules.toStringAsFixed(recipe.energyJoules >= 99 ? 0 : 2)} Kcal',
                                      style: TextStyle(
                                          color: ThemeManager.themeText),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/img/egg.png",
                                      width: 15,
                                      height: 15,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      '${Languages.of(context)!.Foodfat} : ${recipe.totalFat.toStringAsFixed(recipe.totalFat >= 99 ? 0 : 2)} g',
                                      style: TextStyle(
                                          color: ThemeManager.themeText),
                                    ),
                                  ],
                                ),
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
                ),
              ],
            ),
    );
  }
}

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  Future<void> _generateAndSaveRecipeDetails() async {
    try {
      // Get the directory for saving files
      final directory = await getApplicationDocumentsDirectory();
      // final directory = await getApplicationDocumentsDirectory();
      try {
        // Define the file path
        String filePath =
            '${directory.path}/${widget.recipe.recipeName}_details.csv';

        // Create a text file
        File file = File(filePath);

        // Create text content
        String textContent = '';

        // Add recipe details to the content
        textContent += 'Recipe Name: ${widget.recipe.recipeName}\n\n';
        textContent += 'Nutrients in 100g \n';
        textContent += 'Protein (g): ${widget.recipe.protein}\n';
        textContent += 'Total Fat (g): ${widget.recipe.totalFat}\n';
        textContent += 'Energy (kcal): ${widget.recipe.energyJoules}\n';
        textContent +=
            'Dietary Fiber (g): ${widget.recipe.totalDietaryFibre}\n';
        textContent +=
            'Carbohydrates (g): ${widget.recipe.carbohydrate}\n'; // Assuming you have carbohydrates property in your recipe model
        textContent +=
            'Vitamin B2 (Riboflavin) (mg): ${widget.recipe.riboflavinB2}\n'; // Renaming from riboflavinB2 to vitaminB2 for consistency
        textContent += 'Vitamin B6 (mg): ${widget.recipe.vitaminB6}\n';
        textContent +=
            'Folate (µg): ${widget.recipe.totalFolateB9}\n'; // Assuming totalFolateB9 is renamed to folate for consistency
        textContent += 'Vitamin C (mg): ${widget.recipe.vitaminC}\n';
        textContent +=
            'Thiamine (B1) (mg): ${widget.recipe.thiamine}\n'; // Assuming thiamine property is renamed to thiamine for consistency
        textContent += 'Vitamin A (µg): ${widget.recipe.vitaminA}\n';
        textContent += 'Niacin (B3) (mg): ${widget.recipe.niacin}\n';
        textContent += 'Iron (mg): ${widget.recipe.iron}\n';
        textContent += 'Zinc (mg): ${widget.recipe.zinc}\n';
        textContent += 'Calcium (mg): ${widget.recipe.calcium}\n';
        textContent += 'Sodium (mg): ${widget.recipe.sodium}\n';
        textContent += 'Magnesium (mg): ${widget.recipe.magnesium}\n';

        // Add more details as needed...

        // Write content to the file
        await file.writeAsString(textContent);

        // Show an alert dialog indicating that the file has been saved
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text(Languages.of(context)!
              //                                 .cance),
              content:
                  Text('${Languages.of(context)!.fileDownloaded} $filePath'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(Languages.of(context)!.ok),
                ),
              ],
            );
          },
        );
      } catch (e) {
        throw Exception('Directory for saving files not found: $e');
      }
    } catch (e) {
      debugPrint('Error saving file: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(Languages.of(context)!.error),
            content:
                Text('${Languages.of(context)!.NINTextErrorSavingFile}: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(Languages.of(context)!.ok),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
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
              borderRadius: BorderRadius.circular(10),
            ),
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
          widget.recipe.recipeName,
          style: TextStyle(
            color: ThemeManager.themeText,
            fontSize: AppFontSizes.mediumDefault,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: ThemeManager.themeColor,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your other widgets...
              Center(
                  child: Text(
                Languages.of(context)!.FoodnutrientsIn100g,
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.w700,
                ),
              )),
              const SizedBox(height: 16),

              buildSection(
                Languages.of(context)!.FoodproximateComposition,
                [
                  buildRow(
                    Languages.of(context)!.FinanameProtein,
                    '${widget.recipe.protein.toStringAsFixed(widget.recipe.protein >= 99 ? 0 : 2)} g',
                    Icons.accessibility,
                    TColor.primaryColor1.withOpacity(0.2),
                  ),
                  buildRow(
                    Languages.of(context)!.FinanameFat,
                    '${widget.recipe.totalFat.toStringAsFixed(widget.recipe.totalFat >= 99 ? 0 : 2)} g',
                    Icons.accessibility,
                    Colors.white,
                  ),
                  buildRow(
                      Languages.of(context)!.FinanameDietaryFibre,
                      '${widget.recipe.totalDietaryFibre.toStringAsFixed(widget.recipe.totalDietaryFibre >= 99 ? 0 : 2)} g',
                      Icons.accessibility,
                      TColor.primaryColor1.withOpacity(0.2)),
                  buildRow(
                    Languages.of(context)!.FinanameCarbohydrate,
                    '${widget.recipe.carbohydrate.toStringAsFixed(widget.recipe.carbohydrate >= 99 ? 0 : 2)} g',
                    Icons.accessibility,
                    Colors.white,
                  ),
                  buildRow(
                    Languages.of(context)!.FinanameEnergy,
                    '${widget.recipe.energyJoules.toStringAsFixed(widget.recipe.energyJoules >= 99 ? 0 : 2)} kcal',
                    Icons.accessibility,
                    TColor.primaryColor1.withOpacity(0.2),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              buildSection(
                Languages.of(context)!.Foodvitamins,
                [
                  // buildRow(
                  //   Languages.of(context)!.FinanameFolate,
                  //   '${widget.recipe.riboflavinB2.toStringAsFixed(widget.recipe.riboflavinB2 >= 99 ? 0 : 2)} µg',
                  //   Icons.accessibility,
                  //   Colors.white,
                  // ),
                  buildRow(
                    Languages.of(context)!.FinanameRiboflavin,
                    '${widget.recipe.riboflavinB2.toStringAsFixed(widget.recipe.riboflavinB2 >= 99 ? 0 : 2)} mg',
                    Icons.accessibility,
                    Colors.white,
                  ),
                  buildRow(
                    Languages.of(context)!.FinanameVitaminb6,
                    '${widget.recipe.vitaminB6.toStringAsFixed(widget.recipe.vitaminB6 >= 99 ? 0 : 2)} mg',
                    Icons.accessibility,
                    TColor.primaryColor1.withOpacity(0.2),
                  ),

                  buildRow(
                    Languages.of(context)!.FinanameFolate,
                    '${widget.recipe.totalFolateB9.toStringAsFixed(widget.recipe.totalFolateB9 >= 99 ? 0 : 2)} µg',
                    Icons.accessibility,
                    Colors.white,
                  ),
                  buildRow(
                    Languages.of(context)!.FinanameVitaminC,
                    '${widget.recipe.vitaminC.toStringAsFixed(widget.recipe.vitaminC >= 99 ? 0 : 2)} mg',
                    Icons.accessibility,
                    TColor.primaryColor1.withOpacity(0.2),
                  ),
                  buildRow(
                    Languages.of(context)!.FinanameThiamine,
                    '${widget.recipe.thiamine.toStringAsFixed(widget.recipe.thiamine >= 99 ? 0 : 2)} mg',
                    Icons.accessibility,
                    Colors.white,
                  ),
                  buildRow(
                    Languages.of(context)!.FinanameVitaminA,
                    '${widget.recipe.vitaminA.toStringAsFixed(widget.recipe.vitaminA >= 99 ? 0 : 2)} µg',
                    Icons.accessibility,
                    TColor.primaryColor1.withOpacity(0.2),
                  ),
                  buildRow(
                    Languages.of(context)!.FinanameNiacin,
                    '${widget.recipe.niacin.toStringAsFixed(widget.recipe.niacin >= 99 ? 0 : 2)} mg',
                    Icons.accessibility,
                    Colors.white,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              buildSection(
                Languages.of(context)!.Foodminerals,
                [
                  buildRow(
                    Languages.of(context)!.FinanameIron,
                    '${widget.recipe.iron.toStringAsFixed(widget.recipe.iron >= 99 ? 0 : 2)} mg',
                    Icons.accessibility,
                    TColor.primaryColor1.withOpacity(0.2),
                  ),
                  buildRow(
                    Languages.of(context)!.FinanameZinc,
                    '${widget.recipe.zinc.toStringAsFixed(widget.recipe.zinc >= 99 ? 0 : 2)} mg',
                    Icons.accessibility,
                    Colors.white,
                  ),
                  buildRow(
                    Languages.of(context)!.FinanameCalcium,
                    '${widget.recipe.calcium.toStringAsFixed(widget.recipe.calcium >= 99 ? 0 : 2)} mg',
                    Icons.accessibility,
                    TColor.primaryColor1.withOpacity(0.2),
                  ),
                  buildRow(
                    Languages.of(context)!.FinanameSodium,
                    '${widget.recipe.sodium.toStringAsFixed(widget.recipe.sodium >= 99 ? 0 : 2)} mg',
                    Icons.accessibility,
                    Colors.white,
                  ),
                  buildRow(
                    Languages.of(context)!.FinanameMagnesium,
                    '${widget.recipe.magnesium.toStringAsFixed(widget.recipe.magnesium >= 99 ? 0 : 2)} mg',
                    Icons.accessibility,
                    TColor.primaryColor1.withOpacity(0.2),
                  ),
                ],
              ),
              Container(
                height: 50,
                // width: media.width * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius as needed
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: _generateAndSaveRecipeDetails,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Languages.of(context)!.TextAppDownloadFile,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: AppFontSizes.mediumDefault),
                        ),
                        const Icon(Icons.download)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              sizedBox12(),
              Center(
                  child: buildBarcodeSection(
                      'Barcode', generateBarcodeData(widget.recipe), context)),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper method to build a section with a barcode
Widget buildBarcodeSection(String title, String barcodeData, context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title,
        style: const TextStyle(
            fontSize: AppFontSizes.mediumDefault,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      const SizedBox(height: 8),
      // Assuming BarcodeWidget is a widget from a library
      Container(
        color: Colors.white,
        child: BarcodeWidget(
          barcode: Barcode.qrCode(),
          color: Colors.black,

          width: 200,
          height: 200,
          data: barcodeData,
          // Add other properties as needed
          // For example, you might want to set height, width, color, etc.
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        width: 120,
        //  height: 35,
        child: RoundButton(
          title: Languages.of(context)!.labelShareAppButton,
          type: RoundButtonType.bgGradient,
          fontSize: AppFontSizes.smallDefault,
          fontWeight: FontWeight.w400,
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const ActivityTrackerView(),
            //   ),
            // );
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => UpdateProfilePage()));
            Share.share(barcodeData);
          },
        ),
      ),
    ],
  );
}

String generateBarcodeData(Recipe recipe) {
  // Convert double values to String with fixed precision
  String protein = 'Protein (g): ${recipe.protein.toStringAsFixed(2)}';
  String totalFat = 'Total Fat (g): ${recipe.totalFat.toStringAsFixed(2)}';
  String dietaryFiber =
      'Dietary Fiber (g): ${recipe.totalDietaryFibre.toStringAsFixed(2)}';
  String carbohydrate =
      'Carbohydrate (g): ${recipe.carbohydrate.toStringAsFixed(2)}';
  String energy = 'Energy (kcal): ${recipe.energyJoules.toStringAsFixed(2)}';

  String riboflavin =
      'Riboflavin (Vitamin B2) (mg): ${recipe.riboflavinB2.toStringAsFixed(2)}';
  String niacin = 'Niacin (mg): ${recipe.niacin.toStringAsFixed(2)}';
  String folate =
      'Folate (Vitamin B9) (mg): ${recipe.totalFolateB9.toStringAsFixed(2)}';
  String vitaminC = 'Vitamin C (mg): ${recipe.vitaminC.toStringAsFixed(2)}';
  String vitaminA = 'Vitamin A (IU): ${recipe.vitaminA.toStringAsFixed(2)}';

  String iron = 'Iron (mg): ${recipe.iron.toStringAsFixed(2)}';
  String zinc = 'Zinc (mg): ${recipe.zinc.toStringAsFixed(2)}';
  String sodium = 'Sodium (mg): ${recipe.sodium.toStringAsFixed(2)}';
  String calcium = 'Calcium (mg): ${recipe.calcium.toStringAsFixed(2)}';
  String magnesium = 'Magnesium (mg): ${recipe.magnesium.toStringAsFixed(2)}';

  String thiamine =
      'Thiamine (Vitamin B1) (mg): ${recipe.thiamine.toStringAsFixed(2)}';
  String vitaminB6 = 'Vitamin B6 (mg): ${recipe.vitaminB6.toStringAsFixed(2)}';

  return "Food Name: ${recipe.recipeName}  \nQuantity: 100 gram \n\n Proximate Composition \n$protein\n$totalFat\n$dietaryFiber\n$carbohydrate\n$energy\n\n Vitamins \n$riboflavin\n$niacin\n$folate\n$vitaminC\n$vitaminA\n$thiamine\n$vitaminB6\n\n Minerals \n$iron\n$zinc\n$sodium\n$calcium\n$magnesium\n";
}

// Helper method to build a section with a title and a table
Widget buildSection(String title, List<Widget> rows) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: AppFontSizes.mediumDefault,
            fontWeight: FontWeight.bold,
            color: ThemeManager.themeText),
      ),
      const SizedBox(height: 8),
      Column(
        children: rows,
      ),
      const SizedBox(height: 16),
    ],
  );
}

// Helper method to build a Row
Widget buildRow(String label, String value, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      border: Border.all(color: TColor.primaryColor1.withOpacity(0.5)),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8.0),
        bottomLeft: Radius.circular(8.0),
        bottomRight: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
      color: color.withOpacity(0.5),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.black),
        const SizedBox(width: 8),
        SizedBox(
          width: 200,
          child: Text(
            label,
            style: const TextStyle(
                fontSize: AppFontSizes.mediumDefault, color: Colors.black),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
              fontSize: AppFontSizes.mediumDefault, color: Colors.black),
        ),
      ],
    ),
  );
}
