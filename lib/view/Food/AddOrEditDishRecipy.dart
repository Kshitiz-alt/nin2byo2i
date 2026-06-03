import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/constants/server.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';
import 'package:nin2byo2i/common_widget/custom%20indicator%20small.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:intl/intl.dart';
import 'package:nin2byo2i/view/Food/ReportMissingIngredients.dart';
import 'package:nin2byo2i/view/Food/addNewIngredients.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//edit page of recipy and seve it on personal dish list
class AddDishEdit extends StatefulWidget {
  final String dishType;
  final String dishTypeSendForBackened;
  final String RecipeName;

  const AddDishEdit({
    super.key,
    required this.dishType,
    required this.dishTypeSendForBackened,
    required this.RecipeName,
  });
  @override
  _AddDishEditState createState() => _AddDishEditState();
}

class _AddDishEditState extends State<AddDishEdit> {
  TextEditingController dishQuantityController = TextEditingController();
  // TextEditingController mealTypeController = TextEditingController();
  TextEditingController servingSizeController = TextEditingController();
  TextEditingController servingunitValue = TextEditingController();
  bool isLoadingScreenCheck = true;
  bool isLoadingForRawFood = true;
  // List<String> ingredientSuggestions = [
  //   'Corn oil',
  //   // 'Buttermilk',
  //   // 'Whipping cream',
  //   // Add other ingredient suggestions here
  // ];
  Future<List<Map<String, String>>>? ingredientSuggestions;
  final UserProfileController _controller = UserProfileController();
  late Map<String, dynamic> Recipe = {
    // "recipeId": 3,
    // "recipeName": "Pulao",
    // "ingredients": [
    //   {"ingredientName": "ARISITHIPPILI", "weight": 1.0},
    //   {"ingredientName": "PEAS green", "weight": 200.0},
    //   {
    //     "ingredientName": "COOKING OIL (Gnut,ging,palm,must,coconut",
    //     "weight": 20.0
    //   },
    //   {"ingredientName": "RICE, raw, milled", "weight": 200.0},
    //   {"ingredientName": "ONION, small", "weight": 50.0},
    //   {"ingredientName": "CARDAMOM", "weight": 1.0},
    //   {"ingredientName": "CUMIN SEEDS", "weight": 1.0},
    //   {"ingredientName": "PEPPER, dry", "weight": 1.0},
    // ],
  };
  String unitName = '';
  double unitValue = 0.0;
  bool checkisAscending = false;
  bool checkisExpanded = false;
  bool checkisExpandedforAll = false;
  String selectedSortOptionforTop10food = "carbohydrate";
  String selectedTypeforTop10food = "All";
  String selectedTypeforAllfood = "All";
  List<Map<String, dynamic>> Top10foodList = [];
  List<Map<String, dynamic>> selectedTypeforAllfoodfoodList = [];
  String checkString(String input) {
    if (input == "Âµg") {
      return "µg";
    } else {
      return input;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializedata();
    selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    fetchDataFromApi(selectedSortOptionforTop10food, selectedTypeforTop10food);
    fetchDataFromApiforAllFood(selectedTypeforAllfood);
  }

  Future<void> fetchDataFromApi(String parameter, String type) async {
    try {
      List<Map<String, dynamic>> data =
          await _controller.fetchallIngredientsDataFromApi(parameter, type);
      setState(() {
        Top10foodList = data;
        _sortFoodList();
      });
    } catch (e) {
      debugPrint('Failed to fetch data: $e');
      // Handle error
    }
  }

  String capitalize(String s) {
    if (s.isEmpty) {
      return s;
    }
    List<String> words = s.split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(' ');
  }

  Future<void> fetchDataFromApiforAllFood(String type) async {
    try {
      List<Map<String, dynamic>> data = await _controller
          .fetchallIngredientsDataFromApiOntheBasisioFType(type);
      setState(() {
        selectedTypeforAllfoodfoodList = data;
        _sortFoodList();
      });
    } catch (e) {
      debugPrint('Failed to fetch data: $e');
      // Handle error
    }
  }

  // Method to sort foodList based on the selected sorting option
  void _sortFoodList() {
    Top10foodList.sort((a, b) {
      if (checkisAscending) {
        return a['nutritionName'].compareTo(b['nutritionName']);
      } else {
        return b['nutritionName'].compareTo(a['nutritionName']);
      }
    });
  }

  void _showWeightDialog(String foodName, String foodCode, String category) {
    debugPrint("dfffffffffffffffffff $foodName $foodCode ");
    TextEditingController weightController1 = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themeColor,
          title: Text(
            '${Languages.of(context)!.NINTextEnterWeightFor}$foodName',
            style: TextStyle(color: ThemeManager.themeText),
          ),
          content: TextFormField(
            controller: weightController1,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: Languages.of(context)!.mainlabelWeightInG,
              labelStyle: TextStyle(
                  color: ThemeManager.themeText), // Change label text color
              // Optionally, you can also change the text color of the input text
              // You can adjust the color according to your preference
              // For example:
              // hintStyle: TextStyle(color: Colors.grey), // Change hint text color
            ),
            style: TextStyle(color: ThemeManager.themeText),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                Languages.of(context)!.cancel,
                style: TextStyle(color: ThemeManager.themeText),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  String name = foodName;
                  double weight =
                      double.tryParse(weightController1.text) ?? 0.0;

                  if (name.isNotEmpty && weight > 0) {
                    bool ingredientFound = false;
                    for (var ingredient in Recipe["ingredients"]) {
                      if (ingredient["ingredientName"] == name) {
                        ingredient["ingredientQuantity"] = weight;
                        ingredient["foodCode"] = foodCode;
                        ingredient["category"] = category;
                        ingredientFound = true;
                        break; // Stop searching once the ingredient is found and updated
                      }
                    }
                    if (!ingredientFound) {
                      Recipe["ingredients"].add({
                        "ingredientName": name,
                        "ingredientQuantity": weight,
                        "foodCode": foodCode,
                        "category": category
                      });
                    }
                    isIngredientChanged = true;
                  }

                  debugPrint("kjdgdjgndfhhhmfgmgf ${Recipe["ingredients"]}");

                  Navigator.pop(context);
                });
                _calculateIngredients();
                CalculateFor100gram();

                // Add the ingredient to the list
                // setState(() {
                //   // ingredientList.add({
                //   //   'ingredientName': foodName,
                //   //   'ingredientQuantity': double.parse(weightController.text),
                //   // });
                // });
                // debugPrint("gfffffffffd $ingredientList");

                //Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                Languages.of(context)!.submit,
                style: TextStyle(color: ThemeManager.themeText),
              ),
            ),
          ],
        );
      },
    );
  }

  String selectedDate = ""; // Initialize with an empty string
  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime lastWeek =
        currentDate.subtract(const Duration(days: 6)); // Last 7 days

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: lastWeek,
      lastDate: currentDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor:
                ThemeManager.themelightColor, // Background color of the header

            colorScheme: ColorScheme.dark(
              primary: TColor.primaryColor1, // Background color of the calendar
              onPrimary: Colors.white, // Text color of the calendar
              surface: TColor.primaryColor1, // Background color of the modal
              onSurface: Colors.white, // Text color of the modal
            ), // Background color of the modal
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    TColor.primaryColor1, // Color of the "OK" button
              ),
            ),
            dialogTheme: DialogThemeData(
                backgroundColor: Color.fromARGB(255, 91, 92, 92)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != currentDate) {
      setState(() {
        selectedDate = DateFormat("yyyy-MM-dd").format(picked);
      });
    }
  }

  List<DataRow> tableRows = [];
  List<DataRow> tableRowsper100gram = [];
  Future<void> initializedata() async {
    ingredientSuggestions = UserProfileController().IngredientsListtemp();
    final data = await _controller.getRecipes(widget.RecipeName);
    if (mounted) {
      setState(() {
        isLoadingScreenCheck = false;
        Recipe = data ?? {};
        unitName = Recipe["unit"];
        unitValue = Recipe["valueForOneUnit"];
        servingunitValue.text = unitValue.toStringAsFixed(0);
        dishQuantityController.text =
            ((Recipe["totalCookedQuantity"])!).toString();

        // totalCookedQuantity = ((double.tryParse(servingSizeController.text)! *
        //     Recipe["totalCookedQuantity"])!);
        debugPrint("fdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfd $Recipe");
      });
      _calculateIngredients();
      CalculateFor100gram();
    }
  }

  // double resultTotalQuantity = 0.0;
  double ServingSizeFinal = 0;
  TextEditingController ControllerresultTotalQuantity = TextEditingController();
  void calculateResult() {
    setState(() {
      // Get the entered number
      double enteredNumber = double.tryParse(servingSizeController.text) ?? 0.0;

      // Perform the calculation
      // resultTotalQuantity = enteredNumber * unitValue;
      ServingSizeFinal = enteredNumber * unitValue;
      ControllerresultTotalQuantity.text = (enteredNumber * unitValue)
          .toStringAsFixed((enteredNumber * unitValue) >= 99 ? 0 : 2);
    });
  }

  void calculateResultusingControllerresultTotalQuantity() {
    setState(() {
      // Get the entered number
      double enteredNumber = double.tryParse(servingSizeController.text) ?? 0.0;

      // Perform the calculation
      // resultTotalQuantity = enteredNumber * unitValue;
      servingSizeController.text =
          (double.parse(ControllerresultTotalQuantity.text) / unitValue)
              .toStringAsFixed(
                  (double.parse(ControllerresultTotalQuantity.text) /
                              unitValue) >=
                          99
                      ? 0
                      : 2);
    });
  }

  void _showEditIngredientDialog(
      int index, String ingredientName, double currentWeight) {
    TextEditingController weightController = TextEditingController();
    weightController.text = currentWeight.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themeColor,
          title: Text(
            Languages.of(context)!.mainlabelEditIngredientsWeight,
            style: TextStyle(color: ThemeManager.themeText),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${Languages.of(context)!.mainlabelIngredient}: $ingredientName',
                style: TextStyle(color: ThemeManager.themeText),
              ),
              TextField(
                controller: weightController,
                decoration: InputDecoration(
                    labelText: Languages.of(context)!.mainlabelNewWeightInG),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                Languages.of(context)!.cancel,
                style: TextStyle(color: ThemeManager.themeText),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  double newWeight =
                      double.tryParse(weightController.text) ?? 0.0;
                  if (newWeight > 0) {
                    Recipe["ingredients"][index]["ingredientQuantity"] =
                        newWeight;
                    isIngredientChanged = true;
                  }

                  Navigator.pop(context);
                });
                _calculateIngredients();
                CalculateFor100gram();
              },
              child: Text(
                Languages.of(context)!.update,
                style: TextStyle(color: ThemeManager.themeText),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> doesIngredientExist(String ingredientName) async {
    // Wait for ingredientSuggestions to resolve
    var suggestions = await ingredientSuggestions;

    // Check if suggestions is null or empty
    if (suggestions == null || suggestions.isEmpty) {
      return false;
    }

    // Iterate over suggestions
    for (var suggestion in suggestions) {
      // Check if the current suggestion contains foodName
      if (suggestion['foodName'] == ingredientName) {
        return true;
      }
    }
    return false;
  }

  String foodcodeforIndividualIngredients = '';
  String foodcodeforIndividualIngredientsCode = '';
  bool isIngredientChanged = false;
  bool isExpanded = false;
  bool isExpanded2 = false;
  void _showAddIngredientDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themeColor,
          title: Text(
            Languages.of(context)!.mainlabelAddIngredientFrom,
            style: TextStyle(color: ThemeManager.themeText),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 64,
                  decoration: ShapeDecoration(
                    color: ThemeManager.themelightColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1, color: ThemeManager.themelightColor),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: TypeAheadField<Map<String, String>>(
                        controller: nameController,
                        suggestionsCallback: (pattern) async {
                          final ingredients = await ingredientSuggestions!;

                          return ingredients
                              .where((ingredient) => ingredient['foodName']!
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                              .toList();
                        },
                        builder: (context, controller, focusNode) {
                          return TextField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              labelText: Languages.of(context)!
                                  .labelEnterIngredientName,
                              labelStyle: TextStyle(
                                color: ThemeManager.themeText,
                              ),
                              hintStyle: TextStyle(
                                color: ThemeManager.themeText,
                              ),
                            ),
                            style: TextStyle(
                              color: ThemeManager.themeText,
                            ),
                          );
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.network(
                                "${API.server}/images/${suggestion['foodCode']}.PNG",
                                errorBuilder: (context, error, stackTrace) {
                                  return SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(
                                      'assets/img/raw food.jpeg.png',
                                      fit: BoxFit.contain,
                                    ),
                                  );
                                },
                              ),
                            ),
                            title: Text(
                              suggestion['foodName'] ?? '',
                              style: TextStyle(
                                color: ThemeManager.themeText,
                              ),
                            ),
                          );
                        },
                        emptyBuilder: (context) {
                          return ListTile(
                            title: Text(
                              Languages.of(context)!.ninTextOthersSpecify,
                              style: TextStyle(
                                color: ThemeManager.themeText,
                              ),
                            ),
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodFormPage(),
                                ),
                              );

                              initializedata();
                            },
                          );
                        },
                        onSelected: (suggestion) {
                          nameController.text = suggestion['foodName'] ?? '';

                          setState(() {
                            foodcodeforIndividualIngredients =
                                suggestion['foodCode'] ?? '';

                            foodcodeforIndividualIngredientsCode =
                                suggestion['category'] ?? '';
                          });
                        },
                      )
                      // child: TypeAheadFormField(
                      //   textFieldConfiguration: TextFieldConfiguration(
                      //     controller: nameController,
                      //     decoration: InputDecoration(
                      //       labelText:
                      //           Languages.of(context)!.labelEnterIngredientName,
                      //       labelStyle: TextStyle(
                      //         color: ThemeManager.themeText,
                      //       ),
                      //       hintStyle: TextStyle(
                      //         color: ThemeManager.themeText,
                      //       ),
                      //       border: InputBorder.none,
                      //     ),
                      //     style: TextStyle(
                      //       color: ThemeManager.themeText,
                      //     ),
                      //   ),
                      //   suggestionsCallback: (pattern) {
                      //     return ingredientSuggestions.where((ingredient) =>
                      //         ingredient
                      //             .toLowerCase()
                      //             .contains(pattern.toLowerCase()));
                      //   },
                      //   suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      //     color: ThemeManager.themelightColor,
                      //   ),
                      //   itemBuilder: (context, suggestion) {
                      //     return ListTile(
                      //       title: Text(
                      //         suggestion,
                      //         style: TextStyle(color: ThemeManager.themeText),
                      //       ),
                      //     );
                      //   },
                      //   onSuggestionSelected: (suggestion) {
                      //     nameController.text = suggestion;
                      //   },
                      // ),
                      ),
                ),
              ),
              // TextField(
              //   controller: nameController,
              //   decoration: InputDecoration(labelText: 'Ingredient Name'),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 64,
                  decoration: ShapeDecoration(
                    color: ThemeManager.themelightColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: ThemeManager.themelightColor,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: weightController,
                      decoration: InputDecoration(
                        labelText: Languages.of(context)!.mainlabelWeightInG,
                        labelStyle: TextStyle(
                          color: ThemeManager.themeText,
                        ),
                        hintStyle: TextStyle(
                          color: ThemeManager.themeText,
                        ),
                        contentPadding: const EdgeInsets.only(
                            bottom: 5.0), // Adjust this value as needed
                        border: InputBorder.none, // Remove bottom line
                      ),
                      style: TextStyle(
                        color: ThemeManager.themeText,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                Languages.of(context)!.cancel,
                style: TextStyle(color: ThemeManager.themeText),
              ),
            ),
            TextButton(
              onPressed: () async {
                bool ingredientExists =
                    await doesIngredientExist(nameController.text);
                // bool isPresent = isElementPresent(
                //     ingredientNameController.text, addedIngredients);
                debugPrint("dfbhhnghgfjf $ingredientExists ");
                if (!ingredientExists) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        // title: Text('Ingredients Not Available'),
                        content: const Text('Ingredients are not available.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReportMissingIngredients()
                                      // OptionPage(
                                      //       dishTypeSendForBackened:
                                      //           widget.dishTypeSendForBackened,
                                      //       optionName: widget.dishType,
                                      //       image: getImagePath(),
                                      //     )
                                      ));
                            },
                            child: const Text('Report missing Ingredient'),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }
                setState(() {
                  String name = nameController.text;
                  double weight = double.tryParse(weightController.text) ?? 0.0;

                  if (name.isNotEmpty && weight > 0) {
                    Recipe["ingredients"].add({
                      "ingredientName": name,
                      "ingredientQuantity": weight,
                      'foodCode': foodcodeforIndividualIngredients,
                      'category': foodcodeforIndividualIngredientsCode,
                    });
                    isIngredientChanged = true;
                  }
                  debugPrint("kjdgdjgndfhhhmfgmgf ${Recipe["ingredients"]}");

                  Navigator.pop(context);
                });
                _calculateIngredients();
                CalculateFor100gram();
              },
              child: Text(
                Languages.of(context)!.add,
                style: TextStyle(color: ThemeManager.themeText),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditRecipeNameDialog() async {
    TextEditingController newNameController = TextEditingController();

    newNameController.text = Recipe["recipeName"] + '_myCustome';
    if (isIngredientChanged) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ThemeManager.themeColor,
            title: Text(
              Languages.of(context)!.NINTextEditRecipeName,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: newNameController,
                  // decoration: InputDecoration(labelText: 'New Recipe Name'),
                  decoration: InputDecoration(
                    labelText: Languages.of(context)!.NINTextNewRecipeName,
                    labelStyle: TextStyle(
                      color: ThemeManager.themeText,
                    ),
                    hintStyle: TextStyle(
                      color: ThemeManager.themeText,
                    ),
                    contentPadding: const EdgeInsets.only(
                        bottom: 5.0), // Adjust this value as needed
                    border: InputBorder.none, // Remove bottom line
                  ),
                  style: TextStyle(
                    color: ThemeManager.themeText,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  Languages.of(context)!.cancel,
                  style: TextStyle(color: ThemeManager.themeText),
                ),
              ),
              TextButton(
                onPressed: () async {
                  String newName = newNameController.text;

                  if (newName.isNotEmpty &&
                      dishQuantityController.text.isNotEmpty &&
                      ControllerresultTotalQuantity.text.isNotEmpty) {
                    Recipe["recipeName"] = newName;
                    Recipe["dishQuantity"] =
                        double.tryParse(dishQuantityController.text) ?? 0.0;

                    Recipe["mealType"] = widget.dishTypeSendForBackened;
                    Recipe["servingSize"] = ControllerresultTotalQuantity.text;

                    debugPrint("kjdgdjgndfhhhmfgmgf $Recipe");
                    await _controller.addDishByRecipe(selectedDate, Recipe);
                    await _controller.saveDishPersonal(
                        recipeId: 1,
                        recipeName: newName,
                        totalCookedQuantity:
                            (double.tryParse(dishQuantityController.text) ??
                                    0.0)
                                .toString(),
                        servingUnit: Recipe["unit"],
                        valueForOneUnit: unitValue.toString(),
                        ingredients: Recipe["ingredients"]);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          Languages.of(context)!.NINTextSubmitted,
                          style: TextStyle(color: ThemeManager.themeText),
                        ),
                      ),
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    // Display a Snackbar if any field is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          Languages.of(context)!.NINTextPleaseEnterAllFields,
                          style: TextStyle(color: ThemeManager.themeText),
                        ),
                      ),
                    );
                  }
                  // setState(() {

                  // });
                },
                child: Text(
                  Languages.of(context)!.submit,
                  style: TextStyle(color: ThemeManager.themeText),
                ),
              ),
            ],
          );
        },
      );
    } else {
      if (dishQuantityController.text.isNotEmpty &&
          ControllerresultTotalQuantity.text.isNotEmpty) {
        Recipe["dishQuantity"] =
            double.tryParse(dishQuantityController.text) ?? 0.0;
        Recipe["mealType"] = widget.dishTypeSendForBackened;
        Recipe["servingSize"] =
            (double.tryParse(ControllerresultTotalQuantity.text)!);

        debugPrint("kjdgdjgndfhhhmfgmgf $Recipe");
        await _controller.addDishByRecipe(selectedDate, Recipe);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              Languages.of(context)!.NINTextSubmitted,
              style: TextStyle(color: ThemeManager.themeText),
            ),
          ),
        );
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd').format(now);
        final data1 = await _controller.GetCaloriesEarned(formattedDate);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }
      // debugPrint("kjdgdjgndfhhhmfgmgf $Recipe");
      // await _controller.addDishByRecipe(Recipe);
      // Navigator.pop(context);
      // Navigator.pop(context);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Please enter all fields.'),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double commonwidth = MediaQuery.of(context).size.width;
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
              width: 15,
              color: ThemeManager.themeText,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.mainlabelEditRecipy,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: isLoadingScreenCheck
          ? const CommonDataLoadingScreen()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: media.width * 0.4,
                          child: Text(
                            '${Languages.of(context)!.labelSelectDate}:',
                            style: TextStyle(
                                fontSize: AppFontSizes.mediumDefault,
                                color: ThemeManager.themeText),
                          ),
                        ),
                        SizedBox(
                          width: media.width * 0.3,
                          child: Text(
                            DateFormatter.convertDate(selectedDate),
                            style: TextStyle(
                                fontSize: AppFontSizes.mediumDefault,
                                fontWeight: FontWeight.bold,
                                color: ThemeManager.themeText),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today,
                              color: ThemeManager.themeText),
                          onPressed: () => _selectDate(context),
                          tooltip: Languages.of(context)!.labelSelectDate,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: commonwidth * 0.6,
                            child: Text(
                                '${Languages.of(context)!.mainlabelRecipeName}: ${Recipe["recipeName"]}',
                                style: TextStyle(
                                    color: ThemeManager.themeText,
                                    fontSize: AppFontSizes.largeDefault,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: commonwidth * 0.25,
                            child: ElevatedButton(
                              onPressed: _showEditRecipeNameDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: TColor
                                    .secondaryColor1, // Set the background color to light blue
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      25.0), // Set the border radius
                                ),
                              ),
                              child: Text(
                                Languages.of(context)!.submit,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    sizedBox30(),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12.0),
                        color: ThemeManager.themelightColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('Recipe ID: ${Recipe["recipeId"]}',
                          //     style: TextStyle(fontSize: AppFontSizes.mediumDefault)),
                          // SizedBox(height: 12.0),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text('Recipe Name: ${Recipe["recipeName"]}',
                          //         style: TextStyle(
                          //             fontSize: AppFontSizes.mediumDefault, fontWeight: FontWeight.bold)),
                          //     // IconButton(
                          //     //   icon: Icon(Icons.edit),
                          //     //   onPressed: _showEditRecipeNameDialog,
                          //     // ),
                          //   ],
                          // ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              Text(
                                  '${Languages.of(context)!.mainlabelIngredient}:',
                                  style: TextStyle(
                                      color: ThemeManager.themeText,
                                      fontSize: AppFontSizes.mediumDefault,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16.0),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: ThemeManager.themelightColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                    onPressed: _showAddIngredientDialog),
                              ),
                              // ElevatedButton(
                              //   onPressed: _showAddIngredientDialog,
                              //   child: Text('Add Ingredient'),
                              // ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (Recipe.isNotEmpty)
                                for (int i = 0;
                                    i < Recipe["ingredients"].length;
                                    i++)
                                  Column(
                                    children: [
                                      const Divider(), // Add Divider between each ingredient
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    // Show image in modal dialog
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                        backgroundColor:
                                                            ThemeManager
                                                                .themeColor,
                                                        content: Container(
                                                          color: ThemeManager
                                                              .themeColor,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  IconButton(
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(); // Close the dialog
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 16),
                                                              SizedBox(
                                                                width: 500,
                                                                child: Image
                                                                    .network(
                                                                  "${API.server}/images/${Recipe["ingredients"][i]['foodCode']}.PNG",
                                                                  loadingBuilder: (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null) {
                                                                      // Image is fully loaded
                                                                      return child;
                                                                    } else {
                                                                      // Image is still loading
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          value: loadingProgress.expectedTotalBytes != null
                                                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                              : null,
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                  errorBuilder: (BuildContext
                                                                          context,
                                                                      Object
                                                                          error,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                    // Error occurred while loading image
                                                                    return SizedBox(
                                                                      width:
                                                                          500,
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/img/raw food.jpeg.png',

                                                                        // height: 50,
                                                                        // width: 100,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: Image.network(
                                                      "${API.server}/images/${Recipe["ingredients"][i]['foodCode']}.PNG",
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          // Image is fully loaded
                                                          return child;
                                                        } else {
                                                          // Image is still loading
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object error,
                                                              StackTrace?
                                                                  stackTrace) {
                                                        // Error occurred while loading image
                                                        return SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child: Image.asset(
                                                            'assets/img/raw food.jpeg.png',

                                                            // height: 50,
                                                            // width: 100,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              // Icon(Icons.food_bank,
                                              //     color: Colors
                                              //         .green), // Replace with appropriate icon
                                              const SizedBox(width: 8.0),
                                              SizedBox(
                                                width: commonwidth * 0.33,
                                                child: Text(
                                                  '${Recipe["ingredients"][i]["ingredientName"]}: ${Recipe["ingredients"][i]["ingredientQuantity"].toStringAsFixed(Recipe["ingredients"][i]["ingredientQuantity"] >= 99 ? 0 : 2)} g',
                                                  style: TextStyle(
                                                      color: ThemeManager
                                                          .themeText,
                                                      fontSize: AppFontSizes
                                                          .mediumDefault),
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () async {
                                              bool temp = false;
                                              await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    // title: Text(
                                                    //     "Confirm Deletion"),
                                                    content: Text(Languages.of(
                                                            context)!
                                                        .confirmDeleteIngredient),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text(
                                                            Languages.of(
                                                                    context)!
                                                                .cancel),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text(
                                                            Languages.of(
                                                                    context)!
                                                                .ninTextDelete),
                                                        onPressed: () {
                                                          temp = true;
                                                          // Recipe["ingredients"]
                                                          //     .removeAt(i);

                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              if (temp) {
                                                setState(() {
                                                  Recipe["ingredients"]
                                                      .removeAt(i);
                                                  isIngredientChanged = true;
                                                  _calculateIngredients();
                                                  _calculateIngredientsfor100gram(
                                                      context);
                                                });
                                              }
                                            },
                                            // onPressed: () {
                                            //   setState(() {
                                            //     Recipe["ingredients"]
                                            //         .removeAt(i);
                                            //     isIngredientChanged = true;
                                            //     _calculateIngredients();
                                            //     _calculateIngredientsfor100gram(
                                            //         context);
                                            //   });
                                            // },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.edit,
                                                color: Colors.blue),
                                            onPressed: () {
                                              _showEditIngredientDialog(
                                                i,
                                                Recipe["ingredients"][i]
                                                    ["ingredientName"],
                                                Recipe["ingredients"][i]
                                                    ["ingredientQuantity"],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                            ],
                          ),
                          sizedBox12(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: ThemeManager.themeColor,
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          Languages.of(context)!
                                              .mainlabelAddIngredientFrom,
                                          style: TextStyle(
                                              color: ThemeManager.themeText),
                                        ),
                                      ),
                                      // Spacer(),
                                      // Icon(
                                      //   checkisExpanded
                                      //       ? Icons.expand_less
                                      //       : Icons.expand_more,
                                      //   color: ThemeManager.themeText,
                                      // ),
                                    ],
                                  ),
                                  // onTap: () {
                                  //   setState(() {
                                  //     checkisExpanded = !checkisExpanded;
                                  //   });
                                  // },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color:
                                          TColor.primaryColor2.withOpacity(0.3),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Row(
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  Languages.of(context)!
                                                      .mainlabelAddFromNutrientSpecifcFood,
                                                  style: TextStyle(
                                                      color: ThemeManager
                                                          .themeText),
                                                ),
                                              ),
                                              const Spacer(),
                                              Icon(
                                                checkisExpanded
                                                    ? Icons.expand_less
                                                    : Icons.add,
                                                color: ThemeManager.themeText,
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            setState(() {
                                              checkisExpanded =
                                                  !checkisExpanded;
                                            });
                                          },
                                        ),
                                        if (checkisExpanded)
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 16.0),
                                                  height: 30,
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 189, 20, 124),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 189, 20, 124),
                                                    icon: const Icon(
                                                        Icons.expand_more,
                                                        color: Colors.white),
                                                    underline: Container(),
                                                    menuMaxHeight: 400,
                                                    value:
                                                        selectedTypeforTop10food,
                                                    items: <String>[
                                                      'Non Vegetarian',
                                                      'Vegetarian',
                                                      'All'
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedTypeforTop10food =
                                                            newValue!;
                                                        fetchDataFromApi(
                                                            selectedSortOptionforTop10food,
                                                            selectedTypeforTop10food);
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 189, 20, 124),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: DropdownButton<
                                                          String>(
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        dropdownColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                189, 20, 124),
                                                        icon: const Icon(
                                                            Icons.expand_more,
                                                            color:
                                                                Colors.white),
                                                        underline: Container(),
                                                        value:
                                                            selectedSortOptionforTop10food,
                                                        items: <String>[
                                                          // 'selenium',
                                                          // 'copper',
                                                          // 'manganese',
                                                          // 'zinc',
                                                          // 'magnesium',
                                                          // 'phosphorus',
                                                          // 'potassium',
                                                          // 'iron',
                                                          // 'total fat',
                                                          // 'carbohydrate',
                                                          // 'Protein',
                                                          // 'Total dietary fibre',
                                                          // 'cholesterol',
                                                          // "sodium",
                                                          // 'calcium'
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
                                                        ].map((String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value
                                                                .toLowerCase(),
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedSortOptionforTop10food =
                                                                newValue!;
                                                            fetchDataFromApi(
                                                                selectedSortOptionforTop10food,
                                                                selectedTypeforTop10food);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      height: 30,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 189, 20, 124),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: DropdownButton<
                                                          String>(
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        dropdownColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                189, 20, 124),
                                                        icon: const Icon(
                                                            Icons.expand_more,
                                                            color:
                                                                Colors.white),
                                                        underline: Container(),
                                                        menuMaxHeight: 400,
                                                        value: checkisAscending
                                                            ? 'Ascending'
                                                            : 'Descending',
                                                        items: <String>[
                                                          'Ascending',
                                                          'Descending'
                                                        ].map((String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            checkisAscending =
                                                                newValue ==
                                                                    'Ascending';
                                                            fetchDataFromApi(
                                                                selectedSortOptionforTop10food,
                                                                selectedTypeforTop10food);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (checkisExpanded)
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height:
                                                  300, // Set the desired height here

                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              decoration: BoxDecoration(
                                                color: TColor.primaryColor1
                                                    .withOpacity(0.2),
                                                // gradient: LinearGradient(
                                                //     colors: TColor.primaryG),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: SingleChildScrollView(
                                                child: SizedBox(
                                                  height:
                                                      300, // Should match the height of the container
                                                  child: ListView.builder(
                                                    itemCount:
                                                        Top10foodList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final foodItem =
                                                          Top10foodList[index];
                                                      return ListTile(
                                                        leading: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child: Image.network(
                                                            "${API.server}/images/${foodItem['foodCode']}.PNG",
                                                            loadingBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Widget
                                                                        child,
                                                                    ImageChunkEvent?
                                                                        loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                // Image is fully loaded
                                                                return child;
                                                              } else {
                                                                // Image is still loading
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    value: loadingProgress.expectedTotalBytes !=
                                                                            null
                                                                        ? loadingProgress.cumulativeBytesLoaded /
                                                                            loadingProgress.expectedTotalBytes!
                                                                        : null,
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            errorBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Object
                                                                        error,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              // Error occurred while loading image
                                                              return SizedBox(
                                                                width: 50,
                                                                height: 50,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/img/raw food.jpeg.png',

                                                                  // height: 50,
                                                                  // width: 100,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),

                                                        title: Text(
                                                            '${index + 1}. ${foodItem['food']}'),
                                                        subtitle: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 16.0),
                                                          child: Text(
                                                              '${capitalize(selectedSortOptionforTop10food)} : ${foodItem['nutritionName'].toStringAsFixed(foodItem['nutritionName'] >= 99 ? 0 : 2)} ${checkString(foodItem['unit'])} '),
                                                        ),
                                                        // Text(
                                                        //   (foodItem['category'] == null
                                                        //       ? '0'
                                                        //       : foodItem['category']),
                                                        // ),
                                                        trailing:
                                                            ElevatedButton(
                                                          onPressed: () {
                                                            _showWeightDialog(
                                                                foodItem[
                                                                    'food'],
                                                                foodItem[
                                                                    'foodCode'],
                                                                foodItem[
                                                                    'category']);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor: TColor
                                                                .secondaryColor1, // Set the background color to light blue
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0), // Set the border radius
                                                            ),
                                                          ),
                                                          child: Text(
                                                              Languages.of(
                                                                      context)!
                                                                  .add),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color:
                                          TColor.primaryColor2.withOpacity(0.3),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Row(
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  Languages.of(context)!
                                                      .mainlabelAddFromAllFoods,
                                                  style: TextStyle(
                                                      color: ThemeManager
                                                          .themeText),
                                                ),
                                              ),
                                              const Spacer(),
                                              Icon(
                                                checkisExpandedforAll
                                                    ? Icons.expand_less
                                                    : Icons.add,
                                                color: ThemeManager.themeText,
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            setState(() {
                                              checkisExpandedforAll =
                                                  !checkisExpandedforAll;
                                            });
                                          },
                                        ),
                                        if (checkisExpandedforAll)
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 16.0),
                                                  height: 30,
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 189, 20, 124),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: DropdownButton<String>(
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 189, 20, 124),
                                                    icon: const Icon(
                                                        Icons.expand_more,
                                                        color: Colors.white),
                                                    underline: Container(),
                                                    value:
                                                        selectedTypeforAllfood,
                                                    items: <String>[
                                                      'Non Vegetarian',
                                                      'Vegetarian',
                                                      'All'
                                                    ].map((String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedTypeforAllfood =
                                                            newValue!;
                                                        fetchDataFromApiforAllFood(
                                                            selectedTypeforAllfood);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (checkisExpandedforAll)
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height:
                                                  300, // Set the desired height here

                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              decoration: BoxDecoration(
                                                color: TColor.primaryColor1
                                                    .withOpacity(0.2),
                                                // gradient: LinearGradient(
                                                //     colors: TColor.primaryG),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: SingleChildScrollView(
                                                child: SizedBox(
                                                  height:
                                                      300, // Should match the height of the container
                                                  child: ListView.builder(
                                                    itemCount:
                                                        selectedTypeforAllfoodfoodList
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final foodItem =
                                                          selectedTypeforAllfoodfoodList[
                                                              index];
                                                      return ListTile(
                                                        leading: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child: Image.network(
                                                            "${API.server}/images/${foodItem['foodCode']}.PNG",
                                                            loadingBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Widget
                                                                        child,
                                                                    ImageChunkEvent?
                                                                        loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                // Image is fully loaded
                                                                return child;
                                                              } else {
                                                                // Image is still loading
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    value: loadingProgress.expectedTotalBytes !=
                                                                            null
                                                                        ? loadingProgress.cumulativeBytesLoaded /
                                                                            loadingProgress.expectedTotalBytes!
                                                                        : null,
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            errorBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Object
                                                                        error,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              // Error occurred while loading image
                                                              return SizedBox(
                                                                width: 50,
                                                                height: 50,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/img/raw food.jpeg.png',

                                                                  // height: 50,
                                                                  // width: 100,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),

                                                        title: Text(
                                                            '${index + 1}. ${foodItem['food']}'),
                                                        subtitle: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 16.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Text('per 100'),
                                                              Text(
                                                                  'Energy: ${foodItem['energy'].toStringAsFixed(foodItem['energy'] >= 99 ? 0 : 2)} Kcal'),
                                                              Text(
                                                                  'protein: ${foodItem['protein'].toStringAsFixed(foodItem['protein'] >= 99 ? 0 : 2)} g'),
                                                              Text(
                                                                  'fat: ${foodItem['total_Fat'].toStringAsFixed(foodItem['total_Fat'] >= 99 ? 0 : 2)} g'),
                                                            ],
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   (foodItem['category'] == null
                                                        //       ? '0'
                                                        //       : foodItem['category']),
                                                        // ),
                                                        trailing:
                                                            ElevatedButton(
                                                          onPressed: () {
                                                            _showWeightDialog(
                                                                foodItem[
                                                                    'food'],
                                                                foodItem[
                                                                    'foodCode'],
                                                                foodItem[
                                                                    'category']);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor: TColor
                                                                .secondaryColor1, // Set the background color to light blue
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25.0), // Set the border radius
                                                            ),
                                                          ),
                                                          child: Text(
                                                              Languages.of(
                                                                      context)!
                                                                  .add),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizedBox30(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 64,
                        decoration: ShapeDecoration(
                          color: ThemeManager.themelightColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1, color: ThemeManager.themelightColor),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: TextField(
                          controller: dishQuantityController,
                          decoration: InputDecoration(
                            labelText:
                                Languages.of(context)!.mainlabelCookedWeightInG,
                            labelStyle: TextStyle(
                                color:
                                    ThemeManager.themeText), // Color for label
                            hintStyle: TextStyle(
                                color:
                                    ThemeManager.themeText), // Color for hint
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeManager
                                    .themeText, // Color for the bottom border
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeManager
                                    .themeText, // Color for the bottom border when focused
                              ),
                            ),
                          ),
                          style: TextStyle(color: ThemeManager.themeText),
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            CalculateFor100gram();
                          },
                        ),
                      ),
                    ),
                    // TextField(
                    //   controller: mealTypeController,
                    //   decoration: InputDecoration(labelText: 'Meal Type'),
                    // ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: Text(
                            '${Languages.of(context)!.NINTextOne} $unitName = ',
                            // ${unitValue.toStringAsFixed(0)} g
                            style: TextStyle(
                                color: ThemeManager.themeText,
                                fontSize: AppFontSizes.mediumDefault,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 150, // Set the width to your desired value
                          child: TextField(
                            controller: servingunitValue,
                            decoration: InputDecoration(
                              // labelText: 'no. of $unitName ', hintText: ''),
                              labelText:
                                  Languages.of(context)!.mainlabelEnterWeight,
                              hintText: '',
                              labelStyle: TextStyle(
                                  color: ThemeManager
                                      .themeText), // Color for label
                              hintStyle: TextStyle(
                                  color:
                                      ThemeManager.themeText), // Color for hint
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ThemeManager
                                      .themeText, // Color for the bottom border
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: ThemeManager
                                      .themeText, // Color for the bottom border when focused
                                ),
                              ),
                            ),
                            style: TextStyle(color: ThemeManager.themeText),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                // debugPrint("fdskljgffdhljkgfjk $value");
                                unitValue =
                                    double.parse((value == '' ? '0.0' : value));
                              });
                              calculateResult();
                              CalculateFor100gram();
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 64,
                        decoration: ShapeDecoration(
                          color: ThemeManager.themelightColor,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1, color: ThemeManager.themelightColor),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 4,
                            ),
                            SizedBox(
                              width: 150, // Set the width to your desired value
                              child: TextField(
                                controller: servingSizeController,
                                decoration: InputDecoration(
                                  // labelText: 'no. of $unitName ', hintText: ''),
                                  labelText: Languages.of(context)!
                                      .mainlabelNumberOfServing,
                                  hintText: '',
                                  labelStyle: TextStyle(
                                      color: ThemeManager
                                          .themeText), // Color for label
                                  hintStyle: TextStyle(
                                      color: ThemeManager
                                          .themeText), // Color for hint
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ThemeManager
                                          .themeText, // Color for the bottom border
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ThemeManager
                                          .themeText, // Color for the bottom border when focused
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: ThemeManager.themeText),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  calculateResult();
                                  CalculateFor100gram();
                                },
                              ),
                            ),
                            Text(
                              ' = ',
                              style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.mediumDefault),
                            ),
                            SizedBox(
                              width: 150, // Set the width to your desired value
                              child: TextField(
                                controller: ControllerresultTotalQuantity,
                                decoration: InputDecoration(
                                  labelText:
                                      Languages.of(context)!.mainlabelWeightInG,
                                  hintText: '',
                                  labelStyle: TextStyle(
                                      color: ThemeManager
                                          .themeText), // Color for label
                                  hintStyle: TextStyle(
                                      color: ThemeManager
                                          .themeText), // Color for hint
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ThemeManager
                                          .themeText, // Color for the bottom border
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ThemeManager
                                          .themeText, // Color for the bottom border when focused
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: ThemeManager.themeText),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  calculateResultusingControllerresultTotalQuantity();
                                  CalculateFor100gram();
                                },
                              ),
                            ),
                            // SizedBox(
                            //   width: 4,
                            // ),
                            // Text(
                            //   ' = $resultTotalQuantity g',
                            //   style: TextStyle(
                            //       fontSize: AppFontSizes.mediumDefault.0, fontWeight: FontWeight.bold),
                            //   textAlign: TextAlign.center,
                            // ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: ThemeManager.themelightColor,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                SizedBox(
                                  width: commonwidth * 0.55,
                                  child: Text(
                                    Languages.of(context)!
                                        .mainlabelNutrientOfAllIngredientsRaw,
                                    style: TextStyle(
                                        color: ThemeManager.themeText),
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  isExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: ThemeManager.themeText,
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                          ),
                          if (isExpanded)
                            isLoadingForRawFood
                                ? const CommonDataLoadingScreenForSmall()
                                : Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: tableRows.isNotEmpty
                                        ? DataTable(
                                            headingRowColor: WidgetStateColor
                                                .resolveWith((states) =>
                                                    const Color(0xFF007BC1)),
                                            columns: [
                                              DataColumn(
                                                label: SizedBox(
                                                  width: 70,
                                                  child: Text(
                                                    Languages.of(context)!
                                                        .NINTextNutrient,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  Languages.of(context)!
                                                      .mainlabelValue,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                numeric: true,
                                                tooltip: 'Weight of Ingredient',
                                              ),
                                            ],
                                            rows: tableRows,
                                          )
                                        : const Text(""),
                                  ),
                        ],
                      ),
                    ),
                    sizedBox12(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: ThemeManager.themelightColor,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: commonwidth * 0.55,
                                      child: Text(
                                          style: TextStyle(
                                              color: ThemeManager.themeText),
                                          '${Languages.of(context)!.mainlabelNutrientsCompostionOfCookedWeight}(${(dishQuantityController.text) == '' ? '0' : dishQuantityController.text} g)'),
                                    ),
                                    sizedBox12(),
                                    SizedBox(
                                      width: commonwidth * 0.55,
                                      child: Text(
                                          style: TextStyle(
                                              fontSize:
                                                  AppFontSizes.smallDefault,
                                              fontWeight: FontWeight.w600,
                                              color: ThemeManager.themeText),
                                          '*Nutrient retention factor not applied'),
                                    ),
                                    // SizedBox(
                                    //   width: commonwidth * 0.6,link
                                    //   child: Text(
                                    //       "for Cooked weight = ${(dishQuantityController.text) == '' ? '0' : dishQuantityController.text} g"),
                                    // ),
                                  ],
                                ),
                                // Text(
                                //     'Nutrients Composition of ${Recipe["recipeName"]}'),
                                // ignore: prefer_const_constructors
                                Spacer(),
                                Icon(
                                  isExpanded2
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: ThemeManager.themeText,
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                _calculateIngredientsfor100gram(context);
                                isExpanded2 = !isExpanded2;
                              });
                            },
                          ),
                          if (isExpanded2)
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: tableRowsper100gram.isNotEmpty
                                  ? DataTable(
                                      columnSpacing: 3.0,
                                      headingRowColor:
                                          WidgetStateColor.resolveWith(
                                              (states) =>
                                                  const Color(0xFF007BC1)),
                                      columns: [
                                        DataColumn(
                                          label: SizedBox(
                                            width: 90,
                                            child: Text(
                                              Languages.of(context)!
                                                  .NINTextNutrient,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 70,
                                            child: Text(
                                              '1 ${Languages.of(context)!.serving} (${unitValue.toStringAsFixed(0)} g)',
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 70,
                                            child: Text(
                                              '${double.parse((servingSizeController.text) == "" ? '0' : servingSizeController.text).toStringAsFixed(double.parse(servingSizeController.text) >= 99 ? 0 : 2)} ${Languages.of(context)!.serving} (${(double.parse(ControllerresultTotalQuantity.text)).toStringAsFixed(double.parse(ControllerresultTotalQuantity.text) >= 99 ? 0 : 2)} g)',
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        const DataColumn(
                                          label: SizedBox(
                                            width: 70,
                                            child: Text(
                                              '100 g ',
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        // DataColumn(
                                        //   label: Text('Nutrition'),
                                        //   numeric: false,
                                        //   tooltip: 'Nutrition Name',
                                        // ),
                                        // DataColumn(
                                        //   label: Text('Weight'),
                                        //   numeric: true,
                                        //   tooltip: 'Weight of Ingredient',
                                        // ),
                                      ],
                                      rows: tableRowsper100gram,
                                    )
                                  : const Text(""),
                            ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 16.0),
                    // ElevatedButton(
                    //   onPressed: _showAddIngredientDialog,
                    //   child: Text('Add Ingredient'),
                    // ),
                    // ElevatedButton(
                    //   onPressed: _showEditRecipeNameDialog,
                    //   child: Text('Submit'),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }

  Map<String, dynamic> IngredientListForTable = {};
  Future<void> _calculateIngredients() async {
    debugPrint("vfdgfdgfhgfgfhjgghj ${Recipe["ingredients"]}");
    setState(() {
      isLoadingForRawFood = true;
    });
    final List<Map<String, dynamic>> addedIngredients =
        (Recipe["ingredients"] as List<dynamic>).cast<Map<String, dynamic>>();

    try {
      IngredientListForTable =
          await _controller.calculateIngredients(addedIngredients);
      // setState(() {});

      _displayNutritionalInfo(IngredientListForTable);
    } catch (error) {
      // Handle error
    }
    setState(() {
      isLoadingForRawFood = false;
    });
  }

  void _displayNutritionalInfo(Map<String, dynamic> responseData) {
    List<dynamic> nutritionalInfoList = responseData['nutritionalInfoList'];
    double totalEnergy = responseData['totalEnergy'];
    double totalProteins = responseData['totalProteins'];
    double totalCarbs = responseData['totalCarbs'];
    double totalFats = responseData['totalFats'];
    double totalFibers = responseData['totalFibers'];

    setState(() {
      tableRows.clear();
      tableRows.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextEnergyKcal}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          '${totalEnergy.toStringAsFixed(totalEnergy >= 99 ? 0 : 2)} ',
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRows.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextProteinG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          totalProteins.toStringAsFixed(totalProteins >= 99 ? 0 : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRows.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextCarbohydratesG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          totalCarbs.toStringAsFixed(totalCarbs >= 99 ? 0 : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRows.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextFatG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          totalFats.toStringAsFixed(totalFats >= 99 ? 0 : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRows.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextFiberG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          totalFibers.toStringAsFixed(totalFibers >= 99 ? 0 : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
    });
  }

  Future<void> _calculateIngredientsfor100gram(context) async {
    // Check if addCookedDishVolume.text is empty or null
    if (dishQuantityController.text.isEmpty ||
        servingSizeController.text.isEmpty) {
      // Show dialog box
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ThemeManager.themeColor,
            title: Text(
              Languages.of(context)!.alert,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            content: Text(
              Languages.of(context)!
                  .mainlabelToSeeNutritionCompositionPleaseEnterNoOfServing,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  Languages.of(context)!.ok,
                  style: TextStyle(color: ThemeManager.themeText),
                ),
              ),
            ],
          );
        },
      );

      // Return from the function
      return;
    }
    CalculateFor100gram();
    // debugPrint(
    //     "vfdgfdgfhgfgfhjgghj $tableRowsper100gram   ${double.parse(dishQuantityController.text)}");
  }

  Future<void> CalculateFor100gram() async {
    final List<Map<String, dynamic>> addedIngredients =
        (Recipe["ingredients"] as List<dynamic>).cast<Map<String, dynamic>>();
    try {
      IngredientListForTable =
          await _controller.calculateIngredients(addedIngredients);
      // responseDataNutrition =
      // await _controller.calculateIngredients(addedIngredients);
      _displayNutritionalInfoper100gram(IngredientListForTable);
    } catch (error) {
      // Handle error
    }
  }

  void _displayNutritionalInfoper100gram(Map<String, dynamic> responseData) {
    // List<dynamic> nutritionalInfoList = responseData['nutritionalInfoList'];
    double totalEnergy = responseData['totalEnergy'];
    double totalProteins = responseData['totalProteins'];
    double totalCarbs = responseData['totalCarbs'];
    double totalFats = responseData['totalFats'];
    double totalFibers = responseData['totalFibers'];

    setState(() {
      tableRowsper100gram.clear();
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(SizedBox(
          width: 90,
          child: Text(
              '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextEnergyKcal}',
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalEnergy / double.parse(dishQuantityController.text)) *
                      unitValue)
                  .toStringAsFixed(((totalEnergy /
                                  double.parse(dishQuantityController.text)) *
                              unitValue) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalEnergy / double.parse(dishQuantityController.text)) *
                      (double.parse(ControllerresultTotalQuantity.text)))
                  .toStringAsFixed(((totalEnergy /
                                  double.parse(dishQuantityController.text)) *
                              (double.parse(
                                  ControllerresultTotalQuantity.text))) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalEnergy / double.parse(dishQuantityController.text)) * 100)
                  .toStringAsFixed(((totalEnergy /
                                  double.parse(dishQuantityController.text)) *
                              100) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(SizedBox(
          width: 70,
          child: Text(
              '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextProteinG}',
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalProteins / double.parse(dishQuantityController.text)) *
                      unitValue)
                  .toStringAsFixed(((totalProteins /
                                  double.parse(dishQuantityController.text)) *
                              unitValue) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalProteins / double.parse(dishQuantityController.text)) *
                      (double.parse(ControllerresultTotalQuantity.text)))
                  .toStringAsFixed(((totalProteins /
                                  double.parse(dishQuantityController.text)) *
                              (double.parse(
                                  ControllerresultTotalQuantity.text))) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalProteins / double.parse(dishQuantityController.text)) *
                      100)
                  .toStringAsFixed(((totalProteins /
                                  double.parse(dishQuantityController.text)) *
                              100) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(SizedBox(
          width: 70,
          child: Text(
              '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextCarbohydratesG}',
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalCarbs / double.parse(dishQuantityController.text)) *
                      unitValue)
                  .toStringAsFixed(((totalCarbs /
                                  double.parse(dishQuantityController.text)) *
                              unitValue) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalCarbs / double.parse(dishQuantityController.text)) *
                      (double.parse(ControllerresultTotalQuantity.text)))
                  .toStringAsFixed(((totalCarbs /
                                  double.parse(dishQuantityController.text)) *
                              (double.parse(
                                  ControllerresultTotalQuantity.text))) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalCarbs / double.parse(dishQuantityController.text)) * 100)
                  .toStringAsFixed(((totalCarbs /
                                  double.parse(dishQuantityController.text)) *
                              100) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(SizedBox(
          width: 70,
          child: Text(
              '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextFatG}',
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFats / double.parse(dishQuantityController.text)) *
                      unitValue)
                  .toStringAsFixed(
                      ((totalFats / double.parse(dishQuantityController.text)) *
                                  unitValue) >=
                              99
                          ? 0
                          : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFats / double.parse(dishQuantityController.text)) *
                      (double.parse(ControllerresultTotalQuantity.text)))
                  .toStringAsFixed(
                      ((totalFats / double.parse(dishQuantityController.text)) *
                                  (double.parse(
                                      ControllerresultTotalQuantity.text))) >=
                              99
                          ? 0
                          : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFats / double.parse(dishQuantityController.text)) * 100)
                  .toStringAsFixed(
                      ((totalFats / double.parse(dishQuantityController.text)) *
                                  100) >=
                              99
                          ? 0
                          : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(SizedBox(
          width: 70,
          child: Text(
              '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextFiberG}',
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFibers / double.parse(dishQuantityController.text)) *
                      unitValue)
                  .toStringAsFixed(((totalFibers /
                                  double.parse(dishQuantityController.text)) *
                              unitValue) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFibers / double.parse(dishQuantityController.text)) *
                      (double.parse(ControllerresultTotalQuantity.text)))
                  .toStringAsFixed(((totalFibers /
                                  double.parse(dishQuantityController.text)) *
                              (double.parse(
                                  ControllerresultTotalQuantity.text))) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFibers / double.parse(dishQuantityController.text)) * 100)
                  .toStringAsFixed(((totalFibers /
                                  double.parse(dishQuantityController.text)) *
                              100) >=
                          99
                      ? 0
                      : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
      ]));
    });
  }
}
