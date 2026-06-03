import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/constants/server.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/custom%20indicator%20small.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/AddDishScreen.dart';
import 'package:intl/intl.dart';
import 'package:nin2byo2i/view/Food/ReportMissingIngredients.dart';
import 'package:nin2byo2i/view/Food/addNewIngredients.dart';

//second page of custom dish
//custome dish second screen in add all the deails of recipy that is making
class AddIngredientsOfFoodPage extends StatefulWidget {
  final String dishName;
  final String optionName;
  final String dishQuantity;
  final String image;
  final String dishTypeSendForBackened;

  const AddIngredientsOfFoodPage(
      {super.key,
      required this.dishName,
      required this.optionName,
      required this.dishQuantity,
      required this.dishTypeSendForBackened,
      required this.image});

  @override
  State<AddIngredientsOfFoodPage> createState() =>
      _AddIngredientsOfFoodPageState();
}

class _AddIngredientsOfFoodPageState extends State<AddIngredientsOfFoodPage> {
  final UserProfileController _controller = UserProfileController();
  final TextEditingController ingredientNameController =
      TextEditingController();
  final TextEditingController ingredientQuantityController =
      TextEditingController();
  final TextEditingController addCookedDishVolume = TextEditingController();
  final TextEditingController addtakenVolume = TextEditingController();
  // final TextEditingController addNumbertakenVolume = TextEditingController();
  final List<Map<String, dynamic>> addedIngredients = [];
  String foodcodeforIndividualIngredients = '';
  String foodcodeforIndividualIngredientsCode = '';
  //strings for success and error
  late String Title, content;
  bool Success = false;
  Future<List<Map<String, String>>>? ingredientSuggestions;
  double quantityPer = 150.0; // Default quantity per gram

  // Map of units and their respective values
  Map<String, double> units = {
    'Katori': 0.0,
    'Tbsp': 0.0,
    'Tea spoon': 0.0,
    'Number': 0.0,
    'Piece': 0.0,

    'Tart': 0.0,
    'Cake': 0.0,
    'Big piece': 0.0,
    // 'Number': 51.0,
    // 'gram': 1.0,
  };
  String selectedUnitMeasure = 'Katori';
  final List<Map<String, dynamic>> ingredients = [
    // {"ingredientName": "Amaranth seed", "weight": 1.0},
    // {"ingredientName": "Amaranth seed", "weight": 100},
    // {"ingredientName": "Bajra", "weight": 100},
  ];
  String selectedUnit = "gram";
  List<DataRow> tableRows = [];
  List<DataRow> tableRowsper100gram = [];
  bool isLoadingForRawFood = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializedata();
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

  Future<void> initializedata() async {
    ingredientSuggestions = UserProfileController().IngredientsListtemp();
    debugPrint("dsgvfghfhfgfg $ingredientSuggestions");

    debugPrint("dfghbfhgfhgjjn $ingredientSuggestions");
  }

  void showCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
    bool isSuccess = false,
    Color contentColor = Colors.black,
  }) {
    if (Success == false) {
      setState(() {
        contentColor = Colors.red;
      });
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themelightColor,
          title: Text(
            title,
            style: TextStyle(
              color: ThemeManager.themeText,
            ),
          ),
          content: Text(
            content,
            style: TextStyle(color: contentColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                Languages.of(context)!.ok,
                style: TextStyle(color: contentColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editIngredient(int index) {
    Map<String, dynamic> ingredient = addedIngredients[index];

    TextEditingController nameController =
        TextEditingController(text: ingredient['ingredientName']);
    TextEditingController quantityController = TextEditingController(
        text: ingredient['ingredientQuantity'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themeColor,
          title: Text(Languages.of(context)!.NINTextEditIngredient),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TextField(
              //   controller: nameController,
              //   decoration: InputDecoration(labelText: 'Ingredient Name'),
              // ),
              const SizedBox(height: 10),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(
                    labelText: Languages.of(context)!.labelIngredientQuantity),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the ingredient with the new values
                setState(() {
                  // addedIngredients[index]['ingredientName'] =
                  //     nameController.text;
                  addedIngredients[index]['ingredientQuantity'] =
                      double.parse(quantityController.text);
                  _calculateIngredients();
                  CalculateFor100gram();
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  bool isExpanded = false;
  bool isExpanded2 = false;
  @override
  Widget build(BuildContext context) {
    // Build your AddIngredientsOfFoodPage with the provided data
    var media = MediaQuery.of(context).size;
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
          Languages.of(context)!.labelAddDishIngredients,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: SizedBox(
            //         width: 200,
            //         height: 35,
            //         child: RoundButton(
            //             title: "Report missing Ingredients",
            //             type: RoundButtonType.bgSGradient,
            //             fontSize: AppFontSizes

            //             fontWeight: FontWeight.w400,
            //             onPressed: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) =>
            //                           ReportMissingIngredients()
            //                       // OptionPage(
            //                       //       dishTypeSendForBackened:
            //                       //           widget.dishTypeSendForBackened,
            //                       //       optionName: widget.dishType,
            //                       //       image: getImagePath(),
            //                       //     )
            //                       ));
            //             }),
            //       ),
            //     ),
            //   ],
            // ),
            Center(
              child: Foodlisttype(
                fObj: {
                  "name": widget.optionName,
                  "image": widget.image,
                  "number": "120+ Foods"
                },
                index: 1,
              ),
            ),
            // TypeAheadField(
            //   textFieldConfiguration: TextFieldConfiguration(
            //     controller: ingredientNameController,
            //     decoration: InputDecoration(
            //       labelText: 'Ingredient Name',
            //       hintText: 'Enter an ingredient name',
            //     ),
            //   ),
            //   suggestionsCallback: (pattern) {
            //     return ingredientSuggestions.where((ingredient) =>
            //         ingredient.toLowerCase().contains(pattern.toLowerCase()));
            //   },
            //   itemBuilder: (context, suggestion) {
            //     return ListTile(
            //       title: Text(suggestion),
            //     );
            //   },
            //   onSuggestionSelected: (suggestion) {
            //     ingredientNameController.text = suggestion;
            //   },
            // ),
            sizedBox30(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 8, top: 8),
              child: Text(
                Languages.of(context)!.labelEnterIngredientName,
                style: TextStyle(
                  color: ThemeManager.themeText,
                  // fontSize: AppFontSizes.mediumDefault,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                      controller: ingredientNameController,
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
                            labelText:
                                Languages.of(context)!.labelEnterIngredientName,
                            labelStyle: TextStyle(
                              color: ThemeManager.themeText,
                            ),
                            hintStyle: TextStyle(
                              color: ThemeManager.themeText,
                            ),
                            border: InputBorder.none,
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
                        ingredientNameController.text =
                            suggestion['foodName'] ?? '';

                        setState(() {
                          foodcodeforIndividualIngredients =
                              suggestion['foodCode'] ?? '';

                          foodcodeforIndividualIngredientsCode =
                              suggestion['category'] ?? '';
                        });
                      },
                    )

                    //  TypeAheadFormField(
                    //   textFieldConfiguration: TextFieldConfiguration(
                    //     controller: ingredientNameController,
                    //     decoration: InputDecoration(
                    //       labelText:
                    //           Languages.of(context)!.labelEnterIngredientName,
                    //       labelStyle: TextStyle(
                    //         color: ThemeManager.themeText,
                    //       ),
                    //       hintStyle: TextStyle(
                    //         color: ThemeManager.themeText,
                    //       ),
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
                    //   itemBuilder: (context, suggestion) {
                    //     return ListTile(
                    //       title: Text(
                    //         suggestion,
                    //         style: TextStyle(color: ThemeManager.themeText),
                    //       ),
                    //     );
                    //   },
                    //   onSuggestionSelected: (suggestion) {
                    //     ingredientNameController.text = suggestion;
                    //   },
                    //   suggestionsBoxDecoration: SuggestionsBoxDecoration(
                    //     color: ThemeManager.themelightColor,
                    //   ),
                    // ),
                    ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 16.0, right: 16, bottom: 8, top: 8),
            //   child: Container(
            //     width: double.infinity,
            //     height: 64,
            //     decoration: ShapeDecoration(
            //       color: ThemeManager.themelightColor,
            //       shape: RoundedRectangleBorder(
            //         side: BorderSide(
            //             width: 1, color: ThemeManager.themelightColor),
            //         borderRadius: BorderRadius.circular(14),
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(16.0),
            //       child: TypeAheadField(
            //         textFieldConfiguration: TextFieldConfiguration(
            //             controller: ingredientNameController,
            //             decoration: InputDecoration(
            //               labelStyle: TextStyle(
            //                 color: ThemeManager.themeText,
            //               ),
            //               // labelText: 'Ingredient Name',
            //               hintText:
            //                   Languages.of(context)!.labelEnterIngredientName,
            //               hintStyle: TextStyle(
            //                 color: ThemeManager.themeText,
            //               ),
            //               border: InputBorder.none, // Remove the default border
            //             ),
            //             style: TextStyle(
            //               color: ThemeManager.themeText,
            //             )),
            //         suggestionsCallback: (pattern) {
            //           return ingredientSuggestions.where((ingredient) =>
            //               ingredient
            //                   .toLowerCase()
            //                   .contains(pattern.toLowerCase()));
            //         },
            //         itemBuilder: (context, suggestion) {
            //           return ListTile(
            //             title: Text(suggestion),
            //           );
            //         },
            //         onSuggestionSelected: (suggestion) {
            //           ingredientNameController.text = suggestion;
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(
                  left: 14.0, right: 16, bottom: 8, top: 8),
              child: Text(
                Languages.of(context)!.labelIngredientQuantity,
                style: TextStyle(
                  color: ThemeManager.themeText,
                  // fontSize: AppFontSizes .mediumDefault,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 8, top: 8),
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
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: ingredientQuantityController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: ThemeManager.themeText,
                      ),
                      // labelText: 'Ingredient Quantity in gm',
                      hintText:
                          '${Languages.of(context)!.labelEnterIngredientQuantity} (gram)',
                      hintStyle: TextStyle(
                        color: ThemeManager.themeText,
                      ),
                      border: InputBorder.none, // This removes the underline
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                    ),
                    style: TextStyle(
                      color: ThemeManager.themeText,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),

            // ElevatedButton(
            //   onPressed: () {
            //     final ingredientName = ingredientNameController.text;
            //     final ingredientQuantity = ingredientQuantityController.text;

            //     if (ingredientName.isNotEmpty &&
            //         ingredientQuantity.isNotEmpty) {
            //       final ingredientData = {
            //         'ingredientName': ingredientName,
            //         'ingredientQuantity':
            //             double.tryParse(ingredientQuantity) ?? 0.0,
            //       };

            //       // Check if the ingredient is already added
            //       final existingIngredientIndex = addedIngredients.indexWhere(
            //           (ingredient) =>
            //               ingredient['ingredientName'] == ingredientName);

            //       if (existingIngredientIndex != -1) {
            //         // Update the quantity if the ingredient is already in the list
            //         setState(() {
            //           addedIngredients[existingIngredientIndex] =
            //               ingredientData;
            //         });
            //       } else {
            //         // Add the ingredient to the list
            //         setState(() {
            //           addedIngredients.add(ingredientData);
            //         });
            //       }

            //       // Clear the input fields
            //       ingredientNameController.clear();
            //       ingredientQuantityController.clear();
            //     }
            //   },
            //   child: Text('Add'),
            // ),
            sizedBox12(),
            Center(
              child: SizedBox(
                width: 80,
                height: 40,
                child: RoundButton(
                  title: "Add",
                  type: RoundButtonType.bgGradient,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.w400,
                  onPressed: () async {
                    bool ingredientExists = await doesIngredientExist(
                        ingredientNameController.text);
                    // bool isPresent = isElementPresent(
                    //     ingredientNameController.text, addedIngredients);
                    debugPrint("dfbhhnghgfjf $ingredientExists ");
                    // if (!ingredientExists) {
                    //   showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return AlertDialog(
                    //         title: Text('Ingredients Not Available'),
                    //         content: Text('Ingredients are not available.'),
                    //         actions: <Widget>[
                    //           TextButton(
                    //             onPressed: () {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) =>
                    //                           ReportMissingIngredients()
                    //                       // OptionPage(
                    //                       //       dishTypeSendForBackened:
                    //                       //           widget.dishTypeSendForBackened,
                    //                       //       optionName: widget.dishType,
                    //                       //       image: getImagePath(),
                    //                       //     )
                    //                       ));
                    //             },
                    //             child: Text('Report missing Ingredient'),
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   );
                    //   return;
                    // }

                    final ingredientName = ingredientNameController.text;
                    final ingredientQuantity =
                        ingredientQuantityController.text;

                    if (ingredientName.isNotEmpty &&
                        ingredientQuantity.isNotEmpty) {
                      final ingredientData = {
                        'ingredientName': ingredientName,
                        'ingredientQuantity':
                            double.tryParse(ingredientQuantity) ?? 0.0,
                        'foodCode': foodcodeforIndividualIngredients,
                        'category': foodcodeforIndividualIngredientsCode,
                      };

                      // Check if the ingredient is already added
                      final existingIngredientIndex =
                          addedIngredients.indexWhere((ingredient) =>
                              ingredient['ingredientName'] == ingredientName);

                      if (existingIngredientIndex != -1) {
                        // Update the quantity if the ingredient is already in the list
                        setState(() {
                          addedIngredients[existingIngredientIndex] =
                              ingredientData;
                        });
                      } else {
                        // Add the ingredient to the list
                        setState(() {
                          addedIngredients.add(ingredientData);
                        });
                        debugPrint("gfghjgjmgkm $addedIngredients");
                      }

                      // Clear the input fields
                      ingredientNameController.clear();
                      ingredientQuantityController.clear();
                    }
                    _calculateIngredients();
                    CalculateFor100gram();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (addedIngredients.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: TColor.secondaryColor1
                      .withOpacity(0.1), // Set your desired background color
                  borderRadius:
                      BorderRadius.circular(20), // Set the border radius
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Added Ingredients:',
                            style: TextStyle(
                              color: ThemeManager.themeText,
                            ),
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     _calculateIngredients();
                        //   },
                        //   child: Text('Calculate Ingredients'),
                        // ),
                      ],
                    ),
                    sizedBox12(),
                    Column(
                      children: addedIngredients
                          .asMap()
                          .entries
                          .map(
                            (entry) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(right: 8, left: 8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      TColor.primaryColor1.withOpacity(0.2),
                                      TColor.primaryColor1.withOpacity(0.2),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          // Show image in modal dialog
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              backgroundColor:
                                                  ThemeManager.themeColor,
                                              content: Container(
                                                color: ThemeManager.themeColor,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.close,
                                                            color: Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 16),
                                                    SizedBox(
                                                      width: 500,
                                                      child: Image.network(
                                                        "${API.server}/images/${entry.value['foodCode']}.PNG",
                                                        loadingBuilder:
                                                            (BuildContext
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
                                                            (BuildContext
                                                                    context,
                                                                Object error,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          // Error occurred while loading image
                                                          return SizedBox(
                                                            width: 500,
                                                            child: Image.asset(
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
                                            "${API.server}/images/${entry.value['foodCode']}.PNG",
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
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
                                            errorBuilder: (BuildContext context,
                                                Object error,
                                                StackTrace? stackTrace) {
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
                                    SizedBox(
                                      width: media.width * 0.33,
                                      child: Text(
                                        '${entry.value['ingredientName']}',
                                        softWrap: true,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          '${entry.value['ingredientQuantity'].toStringAsFixed(entry.value['ingredientQuantity'] >= 99 ? 0 : 2)} g',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        // Center(
                                        //   child: Container(
                                        //       width: 50,
                                        //       height: 50,
                                        //       child: Image.network(
                                        //         "${entry.value['foodCode']}",
                                        //         loadingBuilder:
                                        //             (BuildContext context,
                                        //                 Widget child,
                                        //                 ImageChunkEvent?
                                        //                     loadingProgress) {
                                        //           if (loadingProgress == null) {
                                        //             // Image is fully loaded
                                        //             return child;
                                        //           } else {
                                        //             // Image is still loading
                                        //             return Center(
                                        //               child:
                                        //                   CircularProgressIndicator(
                                        //                 value: loadingProgress
                                        //                             .expectedTotalBytes !=
                                        //                         null
                                        //                     ? loadingProgress
                                        //                             .cumulativeBytesLoaded /
                                        //                         loadingProgress
                                        //                             .expectedTotalBytes!
                                        //                     : null,
                                        //               ),
                                        //             );
                                        //           }
                                        //         },
                                        //         errorBuilder: (BuildContext
                                        //                 context,
                                        //             Object error,
                                        //             StackTrace? stackTrace) {
                                        //           // Error occurred while loading image
                                        //           return Text(
                                        //               'No Image Found');
                                        //         },
                                        //       )),
                                        // ),
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () {
                                            _editIngredient(entry.key);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () async {
                                            bool temp = false;
                                            await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  // title:
                                                  //     Text("Confirm Deletion"),
                                                  content: Text(Languages.of(
                                                          context)!
                                                      .confirmDeleteIngredient),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                          Languages.of(context)!
                                                              .cancel),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text(
                                                          Languages.of(context)!
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
                                                addedIngredients
                                                    .removeAt(entry.key);
                                                _calculateIngredients();
                                                CalculateFor100gram();
                                              });
                                            }
                                          },
                                          // onPressed: () {

                                          //   setState(() {
                                          //     addedIngredients
                                          //         .removeAt(entry.key);
                                          //     _calculateIngredients();
                                          //     CalculateFor100gram();
                                          //   });
                                          // },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
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
                                    width: media.width * 0.55,
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
                                              headingRowColor:
                                                  WidgetStateColor.resolveWith(
                                                (states) =>
                                                    const Color(0xFF007BC1),
                                              ),
                                              columns: [
                                                DataColumn(
                                                  label: Text(
                                                    Languages.of(context)!
                                                        .NINTextNutrient,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  numeric: false,
                                                  tooltip: 'Nutrition Name',
                                                ),
                                                DataColumn(
                                                  label: Text(
                                                    Languages.of(context)!
                                                        .mainlabelValue,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  numeric: true,
                                                  tooltip:
                                                      'Weight of Ingredient',
                                                ),
                                              ],
                                              rows: tableRows,
                                            )
                                          : const Text(""),
                                    ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            sizedBox12(),
            //    SizedBox(height: 8),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 14.0, right: 16, bottom: 8, top: 8),
            //   child: Text(
            //     Languages.of(context)!.labelIngredientQuantity,
            //     style: TextStyle(
            //       color: ThemeManager.themeText,
            //       // fontSize: AppFontSizes .mediumDefault,
            //     ),
            //   ),
            // ),
            sizedBox12(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 8, top: 8),
              child: Text(
                Languages.of(context)!.TextAppEnterCookedWeight,
                style: TextStyle(
                  color: ThemeManager.themeText,
                  // fontSize: AppFontSizes.mediumDefault,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 8, top: 8),
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
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: addCookedDishVolume,
                    onChanged: (text) {
                      // Call your function here, passing the updated text
                      _calculateIngredientsfor100gram(context);
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: ThemeManager.themeText,
                      ),
                      // labelText: 'Ingredient Quantity in gm',
                      hintText: Languages.of(context)!.TextAppCookedWeightGram,
                      hintStyle: TextStyle(
                        color: ThemeManager.themeText,
                      ),
                      border: InputBorder.none, // This removes the underline
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                    ),
                    style: TextStyle(
                      color: ThemeManager.themeText,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ),
            sizedBox12(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 8, top: 8),
              child: Text(
                Languages.of(context)!.TextAppEnterServingSize,
                style: TextStyle(
                  color: ThemeManager.themeText,
                  // fontSize: AppFontSizes.mediumDefault,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 8, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    decoration: ShapeDecoration(
                      color: const Color.fromARGB(255, 189, 20, 124),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1,
                            color: TColor.secondaryColor1.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: DropdownButton<String>(
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: const Color.fromARGB(255, 189, 20, 124),
                        icon:
                            const Icon(Icons.expand_more, color: Colors.white),
                        underline: Container(),
                        menuMaxHeight: 400,
                        value: selectedUnitMeasure,
                        items: units.keys.map((String unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Text(
                              unit,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? selectedUnit) {
                          setState(() {
                            selectedUnitMeasure = selectedUnit!;
                            quantityPer = units[selectedUnit]!;
                          });
                        },
                      ),
                    ),
                  )
                  // Container(
                  //   // width: double.infinity,
                  //   height: 40,
                  //   decoration: ShapeDecoration(
                  //     color: Color.fromARGB(255, 189, 20, 124),
                  //     shape: RoundedRectangleBorder(
                  //       side: BorderSide(
                  //           width: 1,
                  //           color: TColor.secondaryColor1.withOpacity(0.5)),
                  //       borderRadius: BorderRadius.circular(14),
                  //     ),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  //     child: DropdownButton<String>(
                  //       style: TextStyle(color: Colors.white),
                  //       dropdownColor: Color.fromARGB(255, 189, 20, 124),
                  //       icon: Icon(Icons.expand_more, color: Colors.white),
                  //       underline: Container(),
                  //       menuMaxHeight: 400,
                  //       value: units.keys.firstWhere(
                  //         (key) => units[key] == quantityPer,
                  //         orElse: () =>
                  //             units.keys.first, // Provide a default value here
                  //       ),
                  //       // Default value based on quantityPer

                  //       items: units.keys.map((String unit) {
                  //         return DropdownMenuItem<String>(
                  //           value: unit,
                  //           child: Text(
                  //             unit,
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         );
                  //       }).toList(),
                  //       onChanged: (String? selectedUnit) {
                  //         setState(() {
                  //           quantityPer = units[selectedUnit!]!;
                  //           selectedUnitMeasure = selectedUnit;
                  //         });
                  //       },
                  //     ),
                  //   ),
                  // ),
                  ,
                  Text(
                    " = ",
                    style: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.mediumDefault),
                  ),
                  Container(
                    width: 160,
                    height: 40,
                    decoration: ShapeDecoration(
                      color: TColor.primaryColor1.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1,
                            color: TColor.secondaryColor1.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //     bottom: BorderSide(
                    //       color: ThemeManager
                    //           .themeText, // Set the color of the bottom border
                    //       width: 1.0, // Set the width of the bottom border
                    //     ),
                    //   ),
                    // ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 2.0, left: 2.0, top: 8, bottom: 8),
                      child: TextFormField(
                        controller: addtakenVolume,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            color: ThemeManager.themeText,
                          ),
                          // labelText: 'Ingredient Quantity in gm',
                          hintText:
                              'wt. of $selectedUnitMeasure' // Provide a default value here
                          ,
                          // ${units.keys.firstWhere((key) => units[key] == quantityPer) // Default value based on quantityPer
                          // }',
                          hintStyle: TextStyle(
                            color: ThemeManager.themeText,
                          ),

                          border:
                              InputBorder.none, // This removes the underline

                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16.0),
                        ),
                        style: TextStyle(
                          color: ThemeManager.themeText,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 30,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: TColor.primaryColor1.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1,
                              color: TColor.secondaryColor1.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          " g",
                          style: TextStyle(
                              color: ThemeManager.themeText,
                              fontSize: AppFontSizes.mediumDefault),
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  // Container(
                  //   height: 40,
                  //   decoration: ShapeDecoration(
                  //     color: TColor.primaryColor1.withOpacity(0.5),
                  //     shape: RoundedRectangleBorder(
                  //       side: BorderSide(
                  //           width: 1,
                  //           color: TColor.secondaryColor1.withOpacity(0.5)),
                  //       borderRadius: BorderRadius.circular(14),
                  //     ),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: DropdownButton<String>(
                  //       value: selectedUnit,
                  //       onChanged: (newValue) {
                  //         setState(() {
                  //           selectedUnit = newValue.toString();
                  //         });
                  //       },
                  //       items: <String>['ml', 'gram']
                  //           .map<DropdownMenuItem<String>>((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(value),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 16.0, right: 16, bottom: 8, top: 8),
            //   child: Container(
            //     width: double.infinity,
            //     height: 64,
            //     decoration: ShapeDecoration(
            //       color: ThemeManager.themelightColor,
            //       shape: RoundedRectangleBorder(
            //         side: BorderSide(
            //             width: 1, color: ThemeManager.themelightColor),
            //         borderRadius: BorderRadius.circular(14),
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: TextFormField(
            //         controller: addtakenVolume,
            //         decoration: InputDecoration(
            //           labelStyle: TextStyle(
            //             color: ThemeManager.themeText,
            //           ),
            //           // labelText: 'Ingredient Quantity in gm',
            //           hintText:
            //               'Enter Serving weight of ${units.keys.firstWhere((key) => units[key] == quantityPer) // Default value based on quantityPer
            //               } ',
            //           // ${units.keys.firstWhere((key) => units[key] == quantityPer) // Default value based on quantityPer
            //           // }',
            //           hintStyle: TextStyle(
            //             color: ThemeManager.themeText,
            //           ),
            //           border: InputBorder.none, // This removes the underline
            //           contentPadding: EdgeInsets.symmetric(
            //               vertical: 10.0, horizontal: 16.0),
            //         ),
            //         style: TextStyle(
            //           color: ThemeManager.themeText,
            //         ),
            //         keyboardType: TextInputType.number,
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 16.0, right: 16, bottom: 8, top: 8),
            //   child: Container(
            //     width: double.infinity,
            //     height: 64,
            //     decoration: ShapeDecoration(
            //       color: ThemeManager.themelightColor,
            //       shape: RoundedRectangleBorder(
            //         side: BorderSide(
            //             width: 1, color: ThemeManager.themelightColor),
            //         borderRadius: BorderRadius.circular(14),
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: TextFormField(
            //         controller: addNumbertakenVolume,
            //         decoration: InputDecoration(
            //           labelStyle: TextStyle(
            //             color: ThemeManager.themeText,
            //           ),
            //           // labelText: 'Ingredient Quantity in gm',
            //           hintText:
            //               'Enter no. of ${units.keys.firstWhere((key) => units[key] == quantityPer) // Default value based on quantityPer
            //               } ',
            //           // ${units.keys.firstWhere((key) => units[key] == quantityPer) // Default value based on quantityPer
            //           // }',
            //           hintStyle: TextStyle(
            //             color: ThemeManager.themeText,
            //           ),
            //           border: InputBorder.none, // This removes the underline
            //           contentPadding: EdgeInsets.symmetric(
            //               vertical: 10.0, horizontal: 16.0),
            //         ),
            //         style: TextStyle(
            //           color: ThemeManager.themeText,
            //         ),
            //         keyboardType: TextInputType.number,
            //       ),
            //     ),
            //   ),
            // ),
            // sizedBox12(),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: SizedBox(
            //       // width: 70,
            //       height: 50,
            //       child: RoundButton(
            //         title:
            //             'Check Nutrition for 100 gram based on Cooked Valume',
            //         type: RoundButtonType.bgGradient,
            //         fontSize: AppFontSizes

            //         fontWeight: FontWeight.w400,
            //         onPressed: () {
            //           _calculateIngredientsfor100gram(context);
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   height: 40,
            //   decoration: ShapeDecoration(
            //     color: TColor.primaryColor1.withOpacity(0.5),
            //     shape: RoundedRectangleBorder(
            //       side: BorderSide(
            //           width: 1, color: TColor.secondaryColor1.withOpacity(0.5)),
            //       borderRadius: BorderRadius.circular(14),
            //     ),
            //   ),
            //   child: ElevatedButton(
            //       onPressed: () {
            //         _calculateIngredientsfor100gram(context);
            //       },
            //       child: Text("check for 100 gram")),
            // ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
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
                            width: media.width * 0.6,
                            child: Text(
                              Languages.of(context)!
                                  .TextAppNutrientIn100gCooked,
                              style: TextStyle(color: ThemeManager.themeText),
                            ),
                          ),
                          // ignore: prefer_const_constructors
                          Spacer(),
                          Icon(
                            isExpanded2 ? Icons.expand_less : Icons.expand_more,
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
                                headingRowColor: WidgetStateColor.resolveWith(
                                  (states) => const Color(0xFF007BC1),
                                ),
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      Languages.of(context)!.NINTextNutrient,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    numeric: false,
                                    tooltip: 'Nutrition Name',
                                  ),
                                  DataColumn(
                                    label: Text(
                                      Languages.of(context)!.mainlabelValue,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    numeric: true,
                                    tooltip: 'value of Ingredient',
                                  ),
                                ],
                                rows: tableRowsper100gram,
                              )
                            : const Text(""),
                      ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(15.0),
            //         color: Colors.grey[200],
            //       ),
            //       child: tableRowsper100gram.isNotEmpty
            //           ? DataTable(
            //               headingRowColor: MaterialStateColor.resolveWith(
            //                 (states) => Colors.grey,
            //               ),
            //               columns: [
            //                 DataColumn(
            //                   label: Text('Nutrition'),
            //                   numeric: false,
            //                   tooltip: 'Nutrition Name',
            //                 ),
            //                 DataColumn(
            //                   label: Text('Weight'),
            //                   numeric: true,
            //                   tooltip: 'Weight of Ingredient',
            //                 ),
            //               ],
            //               rows: tableRowsper100gram,
            //             )
            //           : Text("")),
            // ),
            Center(
              child: SizedBox(
                width: 200,
                height: 55,
                child: RoundButton(
                  title: Languages.of(context)!.labelSave,
                  type: RoundButtonType.bgGradient,
                  fontSize: AppFontSizes.smallDefault,
                  fontWeight: FontWeight.w400,
                  onPressed: () async {
                    if (addedIngredients.isNotEmpty &&
                        addCookedDishVolume.text.isNotEmpty &&
                        addCookedDishVolume.text.isNotEmpty &&
                        addtakenVolume.text.isNotEmpty) {
                      // You can now use 'addedIngredients' to send the data to your API function
                      //sendDataToAPI(addedIngredients);
                      debugPrint('data is here $addedIngredients');
                      // double ServQuantity = double.parse(addtakenVolume.text) *
                      //     double.parse(addNumbertakenVolume.text);
                      // double.parse(addtakenVolume.text) * quantityPer;
                      // final dishData = {
                      //   'dishName': widget.dishName,
                      //   // 'dishQuantity': int.tryParse(widget.dishQuantity) ?? 0,
                      //   'mealName': widget.dishTypeSendForBackened,
                      //   'dishQuantity': addCookedDishVolume.text,
                      //   'servingSize': ServQuantity
                      // };
                      try {
                        //   await _controller.AddFoodDishCustom(dishData);
                        await _controller.saveDishPersonal(
                            recipeId: 1,
                            recipeName: widget.dishName,
                            totalCookedQuantity:
                                (double.tryParse(addCookedDishVolume.text) ??
                                        0.0)
                                    .toString(),
                            servingUnit: selectedUnitMeasure,
                            valueForOneUnit:
                                (double.tryParse(addtakenVolume.text) ?? 0.0)
                                    .toString(),
                            ingredients: addedIngredients);
                        if (mounted) {
                          // final status =
                          //     await _controller.AddFoodDishIngredients(
                          //         addedIngredients,
                          //         widget.dishName,
                          //         widget.dishTypeSendForBackened);
                          // DateTime now = DateTime.now();
                          // String formattedDate =
                          //     DateFormat('yyyy-MM-dd').format(now);
                          // final data1 = await _controller.GetCaloriesEarned(
                          //     formattedDate);
                          Success = true;
                          Title = Languages.of(context)!.dishAdded;
                          content = Languages.of(context)!
                              .dishAndIngredientsAddedSuccessfully;
                          debugPrint('Sending data to API: $addedIngredients');
                        }
                      } catch (e) {
                        debugPrint("catch dfdfdfdedsgfdsgdrror $e");
                        setState(() {
                          Success = false;
                          Title = Languages.of(context)!.failed;
                          content = "${Languages.of(context)!.error} $e";
                        });
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(Languages.of(context)!.failed),
                            content: Text(Languages.of(context)!
                                .NINTextPleaseEnterAllFields),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      // showCustomDialog(
                      //   context: context,
                      //   title: Languages.of(context)!.failed,
                      //   content:
                      //       Languages.of(context)!.NINTextPleaseEnterAllFields,
                      //   isSuccess: Success, // Set to true for a success message
                      //   contentColor: Colors.green,
                      // );
                    }
                    showCustomDialog(
                      context: context,
                      title: Title,
                      content: content,
                      isSuccess: Success, // Set to true for a success message
                      contentColor: Colors.green,
                    );

                    // showdataAddedDialog();
                  },
                ),
              ),
            ),
            sizedBox30(),
            // ElevatedButton(
            //   onPressed: () async {
            //     if (addedIngredients.isNotEmpty) {
            //       // You can now use 'addedIngredients' to send the data to your API function
            //       //sendDataToAPI(addedIngredients);
            //       debugPrint('data is here $addedIngredients');
            //       final dishData = {
            //         'dishName': widget.dishName,
            //         'dishQuantity': int.tryParse(widget.dishQuantity) ?? 0,
            //         'mealName': widget.optionName,
            //       };
            //       final data = await _controller.AddFoodDish(dishData);
            //       final status = await _controller.AddFoodDishIngredients(
            //           addedIngredients, widget.dishName, widget.optionName);
            //       debugPrint('Sending data to API: $addedIngredients');
            //     }
            //     showdataAddedDialog();
            //   },
            //   child: Text('Submit'),
            // ),
          ],
        ),
      ),
    );
  }

  // Implement your sendDataToAPI function here
  Future<void> sendDataToAPI(List<Map<String, dynamic>> data) async {
    // Your API call logic goes here
  }
  Map<String, dynamic> responseDataNutrition = {};
  Future<void> _calculateIngredients() async {
    setState(() {
      isLoadingForRawFood = true;
    });
    debugPrint("vfdgfdgfhgfgfhjgghj $addedIngredients");
    try {
      responseDataNutrition =
          await _controller.calculateIngredients(addedIngredients);
      _displayNutritionalInfo(responseDataNutrition);
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
          totalEnergy.toStringAsFixed(totalEnergy >= 99 ? 0 : 2),
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
    if (addCookedDishVolume.text.isEmpty) {
      // Show dialog box
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ThemeManager.themeColor,
            title: Text(
              Languages.of(context)!.NINTextAlert,
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
    debugPrint(
        "vfdgfdgfhgfgfhjgghj $tableRowsper100gram   ${double.parse(addCookedDishVolume.text)}");
  }

  Future<void> CalculateFor100gram() async {
    responseDataNutrition =
        await _controller.calculateIngredients(addedIngredients);
    try {
      // responseDataNutrition =
      // await _controller.calculateIngredients(addedIngredients);

      _displayNutritionalInfoper100gram(responseDataNutrition);
    } catch (error) {
      // Handle error
    }
  }

  void _displayNutritionalInfoper100gram(Map<String, dynamic> responseData) {
    List<dynamic> nutritionalInfoList = responseData['nutritionalInfoList'];
    double totalEnergy = responseData['totalEnergy'];
    double totalProteins = responseData['totalProteins'];
    double totalCarbs = responseData['totalCarbs'];
    double totalFats = responseData['totalFats'];
    double totalFibers = responseData['totalFibers'];

    setState(() {
      tableRowsper100gram.clear();
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextEnergyKcal}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          ((totalEnergy / double.parse(addCookedDishVolume.text)) * 100)
              .toStringAsFixed(
                  ((totalEnergy / double.parse(addCookedDishVolume.text)) *
                              100) >=
                          99
                      ? 0
                      : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextProteinG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          ((totalProteins / double.parse(addCookedDishVolume.text)) * 100)
              .toStringAsFixed(
                  ((totalProteins / double.parse(addCookedDishVolume.text)) *
                              100) >=
                          99
                      ? 0
                      : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextCarbohydratesG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          ((totalCarbs / double.parse(addCookedDishVolume.text)) * 100)
              .toStringAsFixed(
                  ((totalCarbs / double.parse(addCookedDishVolume.text)) *
                              100) >=
                          99
                      ? 0
                      : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextFatG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          ((totalFats / double.parse(addCookedDishVolume.text)) * 100)
              .toStringAsFixed(
                  ((totalFats / double.parse(addCookedDishVolume.text)) *
                              100) >=
                          99
                      ? 0
                      : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextFiberG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          ((totalFibers / double.parse(addCookedDishVolume.text)) * 100)
              .toStringAsFixed(
                  ((totalFibers / double.parse(addCookedDishVolume.text)) *
                              100) >=
                          99
                      ? 0
                      : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
    });
  }
}
