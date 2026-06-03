import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nin2byo2i/Classes/Food%20Classes/foodtableingredient.dart';
import 'package:http/http.dart' as http;
import 'package:nin2byo2i/Classes/earclassforuser.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:intl/intl.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';
import 'package:nin2byo2i/common_widget/ErrorMessageDisplay.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/AnalyseFoodIntakes.dart';
import 'package:nin2byo2i/view/Food/DDSAnalyse.dart';
import 'package:nin2byo2i/view/Food/DishInDetailView.dart';
import 'package:nin2byo2i/view/Food/FavouriteDishList.dart';
import 'package:nin2byo2i/view/Food/AddDishScreen.dart';
import 'package:nin2byo2i/view/Food/FoodAnalyse.dart';
import 'package:nin2byo2i/view/Food/Top10FoodList.dart';
import 'package:nin2byo2i/view/Food/customtablerowforfat.dart';
import 'package:nin2byo2i/view/Food/dietaryDiary.dart';

import 'package:nin2byo2i/view/SuggestionComponents/CarbIntakeResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/DDSResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/FatIntakeResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/ProteinIntakeResultContainer%20.dart';
import 'package:nin2byo2i/view/SuggestionComponents/RefinedSugarIntakeResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/SaltIntakeResultContainer.dart';
import 'package:nin2byo2i/view/home/customProgressBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

//food diary page
class showfoodtableListOfUser extends StatefulWidget {
  const showfoodtableListOfUser({super.key});

  @override
  State<showfoodtableListOfUser> createState() =>
      _showfoodtableListOfUserState();
}

class _showfoodtableListOfUserState extends State<showfoodtableListOfUser> {
  final UserProfileController _controller = UserProfileController();
  bool isLoadingScreenCheck = true;
  String selectedOption = "Full Day";
  late String currentDate;
  late List<Meal> mealsFood = [];

  bool isExpanded = false;
  int NumberingforEarlyMorning = 1;
  int NumberingforBreakfast = 1;
  int NumberingforMidMorning = 1;
  int NumberingforLunch = 1;
  int NumberingforEvening = 1;
  int NumberingforDinner = 1;
  int NumberingforBedTime = 1;
  EarForUser _profileFuture = EarForUser(
    gender: "waiting",
    age: "waiting",
    group: "waiting",
    workLevel: "waiting",
    energy: 0.0,
    protein: 0.0,
    fatsOilsVisible: 0.0,
    fiber: 0.0,
    calcium: 0.0,
    magnesium: 0.0,
    iron: 0.0,
    zinc: 0.0,
    thiamine: 0.0,
    riboflavin: 0.0,
    niacin: 0.0,
    folate: 0.0,
    vitA: 0.0,
    iodine: 0.0,
    vitB12: 0.0,
    vitC: 0.0,
    carbohydrate: 0.0,
  );
  Map<String, double> consumedPercentages = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDate = getCurrentDate();
    fetchMeals();
    loadEarValues();
    loadSavedOption();
    loadSugarSalt();
  }

  double salt = 0, sugar = 0;
  Future<void> loadSugarSalt() async {
    final data =
        await UserProfileController.fetchSaltAndSugarData2(currentDate);
    debugPrint("sdfgfdhfghjgfjf $currentDate ${data?['Salt']}  ${data?['Sugar']}");
    setState(() {
      salt = data!['Salt']!;
      sugar = data['Sugar']!;
    });
  }

  Future<void> loadEarValues() async {
    _profileFuture = (await _controller.getProfileEar());
    setState(() {});
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year}-${_formatNumber(now.month)}-${_formatNumber(now.day)}";
    return formattedDate;
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Delete Food'),
          content: Text(Languages.of(context)!.confirmDeleteFood),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(Languages.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                // Perform delete operation here
                // For demonstration, just debugPrint a message
                debugPrint('Food deleted!');
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(Languages.of(context)!.ninTextDelete),
            ),
          ],
        );
      },
    );
  }

  String _formatNumber(int number) {
    // Helper function to ensure the number is formatted as two digits (e.g., '02' instead of '2')
    return number.toString().padLeft(2, '0');
  }

  double average = 0;
  Color currentcoloris = Colors.white;
  Future<List<Meal>> fetchMeals() async {
    setState(() {
      isLoadingScreenCheck = true;
    });
    mealsFood = [];
    try {
      List<Meal> meals =
          await _controller.festchmealtabel(currentDate, selectedOption);
      setState(() {
        isLoadingScreenCheck = false;
        mealsFood = meals;
        average = 0;
        currentcoloris = Colors.white;
        if (selectedOption == "Full Day") {
          for (int i = 0; i < mealsFood.length; i++) {
            consumedPercentages['Calories'] = mealsFood[0].totalmealCalories /
                (_profileFuture.energy == 0 ? 1 : _profileFuture.energy);
            consumedPercentages['Protein'] = mealsFood[0].mealProteins /
                (_profileFuture.protein == 0 ? 1 : _profileFuture.protein);
            consumedPercentages['Fat'] = mealsFood[0].mealFats /
                (_profileFuture.fatsOilsVisible == 0
                    ? 1
                    : _profileFuture.fatsOilsVisible);
            consumedPercentages['Carbohydrates'] = mealsFood[0].mealCarbs /
                (_profileFuture.carbohydrate == 0
                    ? 1
                    : _profileFuture.carbohydrate);
            consumedPercentages['Calcium'] = mealsFood[0].mealCalcium /
                (_profileFuture.calcium == 0 ? 1 : _profileFuture.calcium);
            consumedPercentages['Fiber'] = mealsFood[0].mealFibers /
                (_profileFuture.fiber == 0 ? 1 : _profileFuture.fiber);
            consumedPercentages['Iron'] = mealsFood[0].mealIron /
                (_profileFuture.iron == 0 ? 1 : _profileFuture.iron);
            consumedPercentages['Zinc'] = mealsFood[0].mealZinc /
                (_profileFuture.zinc == 0 ? 1 : _profileFuture.zinc);
            consumedPercentages['Magnesium'] = mealsFood[0].mealMagnesium /
                (_profileFuture.magnesium == 0 ? 1 : _profileFuture.magnesium);
            consumedPercentages['Thiamine (B1)'] = mealsFood[0].mealThiamineB1 /
                (_profileFuture.thiamine == 0 ? 1 : _profileFuture.thiamine);
            consumedPercentages['Riboflavin (B2)'] =
                mealsFood[0].mealRiboflavinB2 /
                    (_profileFuture.riboflavin == 0
                        ? 1
                        : _profileFuture.riboflavin);
            consumedPercentages['Niacin (B3)'] = mealsFood[0].mealNiacinB3 /
                (_profileFuture.niacin == 0 ? 1 : _profileFuture.niacin);
            consumedPercentages['Folates (B9)'] = mealsFood[0].mealFolatesB9 /
                (_profileFuture.folate == 0 ? 1 : _profileFuture.folate);
            consumedPercentages['Retinol (Vit A)'] =
                mealsFood[0].mealRetinolVitA /
                    (_profileFuture.vitA == 0 ? 1 : _profileFuture.vitA);

            // Cap values at 1 if they exceed it
            for (var entry in consumedPercentages.entries) {
              if (entry.value > 1) {
                consumedPercentages[entry.key] = 1;
              }
            }
          }

          double totalValue = 0.0;
          int totalElements = consumedPercentages.length;

          consumedPercentages.forEach((key, value) {
            debugPrint("gfhg $value");
            totalValue += value;
          });

          // Calculate average
          average = totalValue / totalElements;
          debugPrint(
              "dfvgbfhfgjgjhgh $consumedPercentages  grtytr$average $totalElements");
          if (average > 1) {
            currentcoloris = Colors.green;
          } else if (average > 0.49) {
            currentcoloris = const Color.fromARGB(255, 18, 142, 180);
          } else {
            currentcoloris = Colors.orange;
          }
        }
      });

      return meals;
    } catch (e) {
      // Handle the error and show a Snackbar
      // You should replace 'showSnackbar' with the actual code to show a Snackbar in your application
      SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(milliseconds: 1500),
          content: Text('${Languages.of(context)!.errorFetchingMeals} $e'));
      debugPrint('error couth $e');
      // You can also rethrow the error or return a default value as needed
      rethrow; // Rethrow the error or return an empty list, for example
    }
  }

  //String selectedOption = "today"; // Default selection
  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
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
                foregroundColor: TColor.primaryColor1, // Color of the "OK" button
              ),
            ), dialogTheme: DialogThemeData(backgroundColor: Color.fromARGB(
                255, 91, 92, 92)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        selectedDate = picked; // Assign picked to selectedDate
        // Call your function with the selected date
        // _loadData(formattedDate);
        currentDate = formattedDate.toString();
        fetchMeals();
        loadSugarSalt();
      });
    }
  }

  Future<void> _refresh() async {
    await fetchMeals();
    setState(() {});
  }

  //TextEditingController _searchController = TextEditingController();
  String selectedOptionbyuser = 'Calories';

  Future<void> loadSavedOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOptionbyuser = prefs.getString('selectedOption') ?? 'Calories';
    });
  }

  Future<void> saveSelectedOption(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedOption', value);
  }

  String selectedOptionbyuserReturnValue(Dish dish) {
    switch (selectedOptionbyuser) {
      case 'Calories':
        return "${dish.totalCalories.toStringAsFixed(dish.totalCalories >= 99 ? 0 : 2)}  Kcal";
      case 'Proteins':
        return "${dish.totalProteins.toStringAsFixed(dish.totalProteins >= 99 ? 0 : 2)} g";
      case 'Carbohydrate':
        return "${dish.totalCarbs.toStringAsFixed(dish.totalCarbs >= 99 ? 0 : 2)} g";
      case 'Fat':
        return "${dish.totalFats.toStringAsFixed(dish.totalFats >= 99 ? 0 : 2)} g";
      case 'Fibre':
        return "${dish.totalFibers.toStringAsFixed(dish.totalFibers >= 99 ? 0 : 2)} g";
      case 'Calcium':
        return "${dish.totalCalcium.toStringAsFixed(dish.totalCalcium >= 99 ? 0 : 2)} mg";
      case 'Iron':
        return "${dish.totalIron.toStringAsFixed(dish.totalIron >= 99 ? 0 : 2)} mg";
      case 'Zinc':
        return "${dish.totalZinc.toStringAsFixed(dish.totalZinc >= 99 ? 0 : 2)} mg";
      case 'Magnesium':
        return "${dish.totalMagnesium.toStringAsFixed(dish.totalMagnesium >= 99 ? 0 : 2)} mg";
      case 'Thiamine (B1)':
        return "${dish.totalThiamineB1.toStringAsFixed(dish.totalThiamineB1 >= 99 ? 0 : 2)} mg";
      case 'Riboflavin (B2)':
        return "${dish.totalRiboflavinB2.toStringAsFixed(dish.totalRiboflavinB2 >= 99 ? 0 : 2)} mg";
      case 'Niacin (B3)':
        return "${dish.totalNiacinB3.toStringAsFixed(dish.totalNiacinB3 >= 99 ? 0 : 2)} mg";
      case 'Folates (B9)':
        return "${dish.totalFolatesB9.toStringAsFixed(dish.totalFolatesB9 >= 99 ? 0 : 2)} µg";
      case 'Vitamin A':
        return "${dish.totalRetinolVitA.toStringAsFixed(dish.totalRetinolVitA >= 99 ? 0 : 2)} µg";
      case 'Vitamin B^':
        return "${dish.totalRetinolVitA.toStringAsFixed(dish.totalRetinolVitA >= 99 ? 0 : 2)} µg";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        // Do nothing when the back button is pressed
        Navigator.pushNamed(context, '/root');
        return false;
      },
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeManager.themeColor,
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              Languages.of(context)!.labelMealList,
              style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.w700),
            ),
            actions: [
              InkWell(
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouriteNutrition(),
                    ),
                  );
                },
                child: Container(
                    margin: const EdgeInsets.all(8),
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ThemeManager.themelightColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                    // Image.asset(
                    //   "assets/img/black_btn.png",
                    //   width: 15,
                    //   height: 15,
                    //   fit: BoxFit.contain,
                    // ),
                    ),
              ),
              // Add the DropdownButton to the AppBar
            ],
          ),
          backgroundColor: ThemeManager.themeColor,
          body: isLoadingScreenCheck
              ? const CommonDataLoadingScreen()
              : RefreshIndicator(
                  color: TColor
                      .secondaryColor1, // Set the color of the refresh indicator
                  backgroundColor: TColor.primaryColor1,
                  onRefresh: _refresh,
                  child: WillPopScope(
                    onWillPop: () async {
                      // Do nothing when the back button is pressed
                      return false;
                    },
                    child: Column(
                      children: [
                        // Center(
                        //   child: Container(
                        //     width: 200,
                        //     height: 200,
                        //     color: currentcoloris,
                        //     child: Center(
                        //       child: Text(
                        //         'Hello World!',
                        //         style: TextStyle(
                        //           fontSize: AppFontSizes.mediumDefault,
                        //           color: Colors.black,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Expanded(
                        //   child: ListView.builder(
                        //     shrinkWrap: true,
                        //     physics: NeverScrollableScrollPhysics(),
                        //     itemCount: mealsFood[1].rlist.length,
                        //     itemBuilder: (context, dishIndex) {
                        //       Dish dish = mealsFood[0].rlist[dishIndex];

                        //       return InkWell(
                        //         onTap: () {
                        //           debugPrint("dish id id hhhh${dish.dishId}");
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //               builder: (context) =>
                        //                   FoodDetailsPage(dish: dish),
                        //             ),
                        //           );
                        //         },
                        //         child: EachMealListCustomWidget(
                        //           labelText1: ' ${dish.dishName}',
                        //           labelText2:
                        //               '${dish.totalCalories.toStringAsFixed(1)} kcal',
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        //              totalmealCalories: json['mealEnergy'],
                        // mealProteins: json['mealProteins'],
                        // mealCarbs: json['mealCarbs'],
                        // mealFats: json['mealFats'],
                        // mealFibers: json['mealFibers'],

                        // for (int i = 0; i < mealsFood.length; i++)
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                // color: Color(0xFF007BC1),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF007BC1),
                                  borderRadius: BorderRadius.only(
                                    // topLeft: Radius.circular(20),
                                    // topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                  ),
                                ),
                                padding: const EdgeInsets.all(
                                    16.0), // Add padding to the container
                                child: Column(
                                  children: [
                                    Container(
                                      width: 315,
                                      height: 50,
                                      decoration: ShapeDecoration(
                                        color: ThemeManager.themelightColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        shadows: const [
                                          BoxShadow(
                                            color: Color(0x111D1617),
                                            blurRadius: 40,
                                            offset: Offset(0, 10),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: Icon(Icons.search),
                                          // ),
                                          // Expanded(
                                          //   child: TextField(
                                          //     controller: _searchController,
                                          //     decoration: InputDecoration(
                                          //       hintText: 'Search...',
                                          //       border: InputBorder.none,
                                          //     ),
                                          //   ),
                                          // ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 150,
                                            height: 35,
                                            decoration: ShapeDecoration(
                                              color: const Color.fromARGB(
                                                  255, 189, 20, 124),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              shadows: const [
                                                BoxShadow(
                                                  color: Color(0x111D1617),
                                                  blurRadius: 40,
                                                  offset: Offset(0, 10),
                                                  spreadRadius: 0,
                                                )
                                              ],
                                            ),
                                            child: DropdownButton<String>(
                                              value: selectedOption,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              dropdownColor: const Color.fromARGB(
                                                  255, 189, 20, 124),
                                              icon: const Icon(Icons.expand_more,
                                                  color: Colors.white),
                                              underline: Container(),
                                              menuMaxHeight: 400,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  selectedOption = newValue!;
                                                  // Call your function to reload data based on the selected option
                                                  fetchMeals();
                                                });
                                              },
                                              items: <String>[
                                                'Full Day',
                                                'Early Morning',
                                                'Breakfast',
                                                'Mid Morning',
                                                'Lunch',
                                                'Evening',
                                                'Dinner',
                                                'Bed Time'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          value,
                                                          style: const TextStyle(
                                                              fontSize: AppFontSizes
                                                                  .smallDefault,
                                                              color: Colors
                                                                  .white // Change the text color
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              _selectDate(context);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.date_range,
                                                color: ThemeManager.themeText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            16), // Add spacing between search bar and Container
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        OptionsForFoodTable(
                                          imagePath: "assets/images/fork 2.png",
                                          text: Languages.of(context)!
                                              .labelAddDish,
                                          f: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddDishScreen(),
                                              ),
                                            );
                                            fetchMeals();
                                            loadSugarSalt();
                                          },
                                        ),
                                        OptionsForFoodTable(
                                          imagePath:
                                              "assets/images/Chef Hat.png",
                                          text: Languages.of(context)!
                                              .labelAnalyze,
                                          f: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    // AnalyseFoodIntakes(),
                                                    IngredientQuantityPage(),
                                              ),
                                            );
                                          },
                                        ),
                                        OptionsForFoodTable(
                                          imagePath:
                                              "assets/images/search-26272.png",
                                          text: Languages.of(context)!
                                              .mainlabelFoodAnalyse,
                                          f: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FoodAnalyse(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   color:
                              //       Color(0xFF007BC1), // Green background color
                              //   child: Divider(
                              //     color: Colors.white,
                              //     thickness: 2,
                              //     height: 20,
                              //     indent: 20,
                              //     endIndent: 20,
                              //   ),
                              // ),
                              // Container(
                              //   //  width: 200,
                              //   // height: ,
                              //   // color: currentcoloris,
                              //   decoration: BoxDecoration(
                              //     color: Color(0xFF007BC1),
                              //     borderRadius: BorderRadius.only(
                              //       // topLeft: Radius.circular(20),
                              //       // topRight: Radius.circular(20),
                              //       bottomLeft: Radius.circular(40),
                              //       bottomRight: Radius.circular(40),
                              //     ),
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(
                              //         top: 8.0, bottom: 8),
                              //     child: Row(
                              //       children: [
                              //         Expanded(
                              //           child: Column(
                              //             children: [
                              //               Text(
                              //                 Languages.of(context)!
                              //                     .labelCaloriestaken,
                              //                 style: TextStyle(
                              //                     color: Colors.white),
                              //               ),
                              //               CustomGradientWidgettotal(
                              //                 imageAsset: 'assets/img/burn.png',
                              //                 value:
                              //                     '${mealsFood[0].totalmealCalories.toStringAsFixed(mealsFood[0].totalmealCalories >= 99 ? 0 : 2)} / ${_profileFuture.energy >= 99 ? _profileFuture.energy.toStringAsFixed(0) : _profileFuture.energy.toStringAsFixed(2)}',
                              //               ),
                              //               Text(
                              //                 Languages.of(context)!
                              //                     .labelProteins,
                              //                 style: TextStyle(
                              //                     color: Colors.white),
                              //               ),
                              //               CustomGradientWidgettotal(
                              //                 imageAsset: 'assets/img/burn.png',
                              //                 value:
                              //                     '${mealsFood[0].mealProteins.toStringAsFixed(mealsFood[0].mealProteins >= 99 ? 0 : 2)} / ${_profileFuture.protein >= 99 ? _profileFuture.protein.toStringAsFixed(0) : _profileFuture.protein.toStringAsFixed(2)}',
                              //               ),
                              //               Text(
                              //                 Languages.of(context)!.labelFats,
                              //                 style: TextStyle(
                              //                     color: Colors.white),
                              //               ),
                              //               CustomGradientWidgettotal(
                              //                 imageAsset: 'assets/img/burn.png',
                              //                 value:
                              //                     '${mealsFood[0].mealFats.toStringAsFixed(mealsFood[0].mealFats >= 99 ? 0 : 2)} / ${_profileFuture.fatsOilsVisible >= 99 ? _profileFuture.fatsOilsVisible.toStringAsFixed(0) : _profileFuture.fatsOilsVisible.toStringAsFixed(2)}',
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         Expanded(
                              //           child: Column(
                              //             children: [
                              //               Text(
                              //                 Languages.of(context)!.labelCarbs,
                              //                 style: TextStyle(
                              //                     color: Colors.white),
                              //               ),
                              //               CustomGradientWidgettotal(
                              //                 imageAsset: 'assets/img/burn.png',
                              //                 value:
                              //                     '${mealsFood[0].mealCarbs.toStringAsFixed(mealsFood[0].mealCarbs >= 99 ? 0 : 2)} / ${_profileFuture.carbohydrate >= 99 ? _profileFuture.carbohydrate.toStringAsFixed(0) : _profileFuture.carbohydrate.toStringAsFixed(2)}',
                              //               ),
                              //               Text(
                              //                 Languages.of(context)!
                              //                     .labelCalcium,
                              //                 style: TextStyle(
                              //                     color: Colors.white),
                              //               ),
                              //               CustomGradientWidgettotal(
                              //                 imageAsset: 'assets/img/burn.png',
                              //                 value:
                              //                     '${mealsFood[0].mealCalcium.toStringAsFixed(mealsFood[0].mealCalcium >= 99 ? 0 : 2)} / ${_profileFuture.calcium >= 99 ? _profileFuture.calcium.toStringAsFixed(0) : _profileFuture.calcium.toStringAsFixed(2)}',
                              //               ),
                              //               Text(
                              //                 Languages.of(context)!
                              //                     .labelFibers,
                              //                 style: TextStyle(
                              //                     color: Colors.white),
                              //               ),
                              //               CustomGradientWidgettotal(
                              //                 imageAsset: 'assets/img/burn.png',
                              //                 value:
                              //                     '${mealsFood[0].mealFibers.toStringAsFixed(mealsFood[0].mealFibers >= 99 ? 0 : 2)} / ${_profileFuture.fiber >= 99 ? _profileFuture.fiber.toStringAsFixed(0) : _profileFuture.fiber.toStringAsFixed(2)}',
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         Expanded(
                              //           child: Column(
                              //             children: [
                              //               Text(
                              //                 Languages.of(context)!.labelIron,
                              //                 style: TextStyle(
                              //                     color: Colors.white),
                              //               ),
                              //               CustomGradientWidgettotal(
                              //                 imageAsset: 'assets/img/burn.png',
                              //                 value:
                              //                     '${mealsFood[0].mealIron.toStringAsFixed(mealsFood[0].mealIron >= 99 ? 0 : 2)} / ${_profileFuture.iron >= 99 ? _profileFuture.iron.toStringAsFixed(0) : _profileFuture.iron.toStringAsFixed(2)}',
                              //               ),
                              //               Text(
                              //                 Languages.of(context)!.labelZinc,
                              //                 style: TextStyle(
                              //                     color: Colors.white),
                              //               ),
                              //               CustomGradientWidgettotal(
                              //                 imageAsset: 'assets/img/burn.png',
                              //                 value:
                              //                     '${mealsFood[0].mealZinc.toStringAsFixed(mealsFood[0].mealZinc >= 99 ? 0 : 2)} / ${_profileFuture.zinc >= 99 ? _profileFuture.zinc.toStringAsFixed(0) : _profileFuture.zinc.toStringAsFixed(2)}',
                              //               ),
                              //               Text(
                              //                 Languages.of(context)!
                              //                     .labelMagnesium,
                              //                 style: TextStyle(
                              //                     color: Colors.white),
                              //               ),
                              //               CustomGradientWidgettotal(
                              //                 imageAsset: 'assets/img/burn.png',
                              //                 value:
                              //                     '${mealsFood[0].mealMagnesium.toStringAsFixed(mealsFood[0].mealMagnesium >= 99 ? 0 : 2)} / ${_profileFuture.magnesium >= 99 ? _profileFuture.magnesium.toStringAsFixed(0) : _profileFuture.magnesium.toStringAsFixed(2)}',
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              sizedBox12(),
                              // Text("${mealsFood[0].totalmealCalories.toString()}"),
                              for (int i = 0; i < mealsFood.length; i++)
                                Column(
                                  children: [
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   children: [
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(
                                    //           top: 12.0,
                                    //           bottom: 12,
                                    //           right: 20,
                                    //           left: 20),
                                    //       child: Text(
                                    //         // Languages.of(context)!.labelRecentMeal,
                                    //         ' ${Languages.of(context)!.NINTextMealsTakenOn} $currentDate ($selectedOption)',
                                    //         style: TextStyle(
                                    //           color: TColor.primaryColor1,
                                    //           fontSize: AppFontSizes.mediumDefault,
                                    //           fontFamily: 'Poppins',
                                    //           fontWeight: FontWeight.w500,
                                    //           height: 0.09,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12.0,
                                              bottom: 12,
                                              right: 20,
                                              left: 20),
                                          child: SizedBox(
                                            width: media.width * 0.88,
                                            child: Text(
                                              // Languages.of(context)!.labelRecentMeal,
                                              "${Languages.of(context)!.ninTextMyNutrientIntake} ${Languages.of(context)!.ninTextOn} ${DateFormatter.convertDate(currentDate)} ",
                                              style: TextStyle(
                                                color: ThemeManager.themeText,
                                                fontSize:
                                                    AppFontSizes.mediumDefault,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                // height: 0.09,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Text(
                                    //   Languages.of(context)!
                                    //       .TextAppTotalNutrientTaken,
                                    //   style: TextStyle(
                                    //     color: Colors.black,
                                    //     fontSize: AppFontSizes.mediumDefault, // Set the title color
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFBBDDFF),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),

                                        // decoration: BoxDecoration(
                                        //   borderRadius:
                                        //       BorderRadius.circular(10),
                                        //   // border: Border.all(
                                        //   //   color: Colors.grey,
                                        //   //   width: 2,
                                        //   // ),
                                        //   color: const Color.fromARGB(
                                        //       255, 233, 231, 231),
                                        // ),
                                        child: ExpansionTile(
                                          title: Text(
                                            "${Languages.of(context)!.ninTextMyNutrientIntake} ${Languages.of(context)!.ninTextOn}  ${DateFormatter.convertDate(currentDate)} – ${Languages.of(context)!.ninTextWithReferenceToEAR} ",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors
                                                  .black, // Set the title colorS
                                            ),
                                          ),
                                          children: [
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Container(
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        // border: Border.all(
                                                        //   color: TColor.primaryColor1,
                                                        //   width: 2,
                                                        // ),
                                                        border: Border.all(
                                                          color: const Color.fromARGB(
                                                              255,
                                                              34,
                                                              104,
                                                              161), // Assuming TColor.primaryColor1 is defined somewhere
                                                          width: 2,
                                                        ),
                                                        color: const Color.fromARGB(
                                                            255, 34, 104, 161),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          SizedBox(
                                                            width: 110,
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          5.0),
                                                              child: Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .NINTextNutrient,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 60,
                                                            child: Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .NINTextValue,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                          SizedBox(
                                                            width: 80,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    Languages.of(
                                                                            context)!
                                                                        .NINTextEAR,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                                Tooltip(
                                                                  message:
                                                                      'EAR Information',
                                                                  child:
                                                                      IconButton(
                                                                    icon: const Icon(
                                                                      Icons
                                                                          .info,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 20,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      // Show BMR information here
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (_) =>
                                                                                AlertDialog(
                                                                          // title:
                                                                          //     Text('EAR'),
                                                                          content:
                                                                              Text(Languages.of(context)!.estimatedAverageRequirement),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text(Languages.of(context)!.NINTextClose),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 100,
                                                            child: Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .NINTextPercentage,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //     height:
                                                  //         10), // Add some spacing between header and data
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0,
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Column(
                                                      children: [
                                                        customtablerow(
                                                          color: Colors.white,
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .energy ==
                                                                  0,
                                                          ingredientName: Languages
                                                                  .of(context)!
                                                              .NINTextEnergyKcal,
                                                          ingredientValue:
                                                              mealsFood[0].totalmealCalories.toStringAsFixed(mealsFood[0].totalmealCalories >= 99 ? 0 : 2),
                                                          earValue:
                                                              _profileFuture.energy.toStringAsFixed(_profileFuture.energy >= 99 ? 0 : 2),
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .totalmealCalories *
                                                              100 /
                                                              (_profileFuture
                                                                          .energy ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .energy),
                                                        ),
                                                        customtablerow(
                                                          color: TColor
                                                              .primaryColor1
                                                              .withOpacity(0.2),
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .protein ==
                                                                  0,
                                                          ingredientName:
                                                              Languages.of(
                                                                      context)!
                                                                  .NINTextProteinG,
                                                          ingredientValue:
                                                              mealsFood[0].mealProteins.toStringAsFixed(mealsFood[0].mealProteins >= 99 ? 0 : 2),
                                                          earValue:
                                                              _profileFuture.protein.toStringAsFixed(_profileFuture.protein >= 99 ? 0 : 2),
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealProteins *
                                                              100 /
                                                              (_profileFuture
                                                                          .protein ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .protein),
                                                        ),
                                                        customtablerowforfat(
                                                          color: Colors.white,
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .fatsOilsVisible ==
                                                                  0,
                                                          ingredientName:
                                                              Languages.of(
                                                                      context)!
                                                                  .NINTextFatG,
                                                          ingredientValue:
                                                              mealsFood[0].mealFats.toStringAsFixed(mealsFood[0].mealFats >= 99 ? 0 : 2),
                                                          earValue: 'N/A',
                                                          //    '${_profileFuture.fatsOilsVisible.toStringAsFixed(_profileFuture.fatsOilsVisible >= 99 ? 0 : 2)}',
                                                          percentage: (mealsFood[
                                                                          i]
                                                                      .mealFats *
                                                                  9 *
                                                                  100) /
                                                              (mealsFood[i]
                                                                  .totalmealCalories),
                                                        ),
                                                        customtablerow(
                                                          color: TColor
                                                              .primaryColor1
                                                              .withOpacity(0.2),
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .carbohydrate ==
                                                                  0,
                                                          ingredientName: Languages
                                                                  .of(context)!
                                                              .NINTextCarbohydratesG,
                                                          ingredientValue:
                                                              mealsFood[0].mealCarbs.toStringAsFixed(mealsFood[0].mealCarbs >= 99 ? 0 : 2),
                                                          earValue: 'N/A  *',
                                                          //   '${_profileFuture.carbohydrate.toStringAsFixed(_profileFuture.carbohydrate >= 99 ? 0 : 2)} *',
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealCarbs *
                                                              100 /
                                                              (_profileFuture
                                                                          .carbohydrate ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .carbohydrate),
                                                        ),
                                                        customtablerow(
                                                          color: Colors.white,
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .calcium ==
                                                                  0,
                                                          ingredientName: Languages
                                                                  .of(context)!
                                                              .NINTextCalciumMg,
                                                          ingredientValue:
                                                              mealsFood[0].mealCalcium.toStringAsFixed(mealsFood[0].mealCalcium >= 99 ? 0 : 2),
                                                          earValue:
                                                              _profileFuture.calcium.toStringAsFixed(_profileFuture.calcium >= 99 ? 0 : 2),
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealCalcium *
                                                              100 /
                                                              (_profileFuture
                                                                          .calcium ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .calcium),
                                                        ),
                                                        customtablerow(
                                                          color: TColor
                                                              .primaryColor1
                                                              .withOpacity(0.2),
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .fiber ==
                                                                  0,
                                                          ingredientName:
                                                              Languages.of(
                                                                      context)!
                                                                  .NINTextFiberG,
                                                          ingredientValue:
                                                              mealsFood[0].mealFibers.toStringAsFixed(mealsFood[0].mealFibers >= 99 ? 0 : 2),
                                                          earValue: 'N/A  **',
                                                          //    '${_profileFuture.fiber.toStringAsFixed(_profileFuture.fiber >= 99 ? 0 : 2)} **',
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealFibers *
                                                              100 /
                                                              (_profileFuture
                                                                          .fiber ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .fiber),
                                                        ),
                                                        customtablerow(
                                                          color: Colors.white,
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .iron ==
                                                                  0,
                                                          ingredientName:
                                                              Languages.of(
                                                                      context)!
                                                                  .NINTextIronMg,
                                                          ingredientValue:
                                                              mealsFood[0].mealIron.toStringAsFixed(mealsFood[0].mealIron >= 99 ? 0 : 2),
                                                          earValue:
                                                              _profileFuture.iron.toStringAsFixed(_profileFuture.iron >= 99 ? 0 : 2),
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealIron *
                                                              100 /
                                                              (_profileFuture
                                                                          .iron ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .iron),
                                                        ),
                                                        customtablerow(
                                                          color: TColor
                                                              .primaryColor1
                                                              .withOpacity(0.2),
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .zinc ==
                                                                  0,
                                                          ingredientName:
                                                              Languages.of(
                                                                      context)!
                                                                  .NINTextZincMg,
                                                          ingredientValue:
                                                              mealsFood[0].mealZinc.toStringAsFixed(mealsFood[0].mealZinc >= 99 ? 0 : 2),
                                                          earValue:
                                                              _profileFuture.zinc.toStringAsFixed(_profileFuture.zinc >= 99 ? 0 : 2),
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealZinc *
                                                              100 /
                                                              (_profileFuture
                                                                          .zinc ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .zinc),
                                                        ),
                                                        customtablerow(
                                                          color: Colors.white,
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .magnesium ==
                                                                  0,
                                                          ingredientName: Languages
                                                                  .of(context)!
                                                              .NINTextMagnesiumMg,
                                                          ingredientValue:
                                                              mealsFood[0].mealMagnesium.toStringAsFixed(mealsFood[0].mealMagnesium >= 99 ? 0 : 2),
                                                          earValue:
                                                              _profileFuture.magnesium.toStringAsFixed(_profileFuture.magnesium >= 99 ? 0 : 2),
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealMagnesium *
                                                              100 /
                                                              (_profileFuture
                                                                          .magnesium ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .magnesium),
                                                        ),
                                                        customtablerow(
                                                          color: TColor
                                                              .primaryColor1
                                                              .withOpacity(0.2),
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .thiamine ==
                                                                  0,
                                                          ingredientName: Languages
                                                                  .of(context)!
                                                              .NINTextThiamineB1Mg,
                                                          ingredientValue:
                                                              mealsFood[0].mealThiamineB1.toStringAsFixed(mealsFood[0].mealThiamineB1 >= 99 ? 0 : 2),
                                                          earValue:
                                                              _profileFuture.thiamine.toStringAsFixed(_profileFuture.thiamine >= 99 ? 0 : 2),
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealThiamineB1 *
                                                              100 /
                                                              (_profileFuture
                                                                          .thiamine ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .thiamine),
                                                        ),
                                                        customtablerow(
                                                          color: Colors.white,
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .riboflavin ==
                                                                  0,
                                                          ingredientName: Languages
                                                                  .of(context)!
                                                              .NINTextRiboflavinB2Mg,
                                                          ingredientValue:
                                                              mealsFood[0].mealRiboflavinB2.toStringAsFixed(mealsFood[0].mealRiboflavinB2 >= 99 ? 0 : 2),
                                                          earValue:
                                                              _profileFuture.riboflavin.toStringAsFixed(_profileFuture.riboflavin >= 99 ? 0 : 2),
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealRiboflavinB2 *
                                                              100 /
                                                              (_profileFuture
                                                                          .riboflavin ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .riboflavin),
                                                        ),
                                                        customtablerow(
                                                          color: TColor
                                                              .primaryColor1
                                                              .withOpacity(0.2),
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .niacin ==
                                                                  0,
                                                          ingredientName: Languages
                                                                  .of(context)!
                                                              .NINTextNiacinB3Mg,
                                                          ingredientValue:
                                                              mealsFood[0].mealNiacinB3.toStringAsFixed(mealsFood[0].mealNiacinB3 >= 99 ? 0 : 2),
                                                          earValue:
                                                              _profileFuture.niacin.toStringAsFixed(_profileFuture.niacin >= 99 ? 0 : 2),
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealNiacinB3 *
                                                              100 /
                                                              (_profileFuture
                                                                          .niacin ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .niacin),
                                                        ),
                                                        customtablerow(
                                                          color: Colors.white,
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .folate ==
                                                                  0,
                                                          ingredientName: Languages
                                                                  .of(context)!
                                                              .NINTextFolatesB9Mcg,
                                                          ingredientValue:
                                                              mealsFood[0].mealFolatesB9.toStringAsFixed(mealsFood[0].mealFolatesB9 >= 99 ? 0 : 2),
                                                          earValue:
                                                              _profileFuture.folate.toStringAsFixed(_profileFuture.folate >= 99 ? 0 : 2),
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealFolatesB9 *
                                                              100 /
                                                              (_profileFuture
                                                                          .folate ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .folate),
                                                        ),
                                                        customtablerow(
                                                          color: TColor
                                                              .primaryColor1
                                                              .withOpacity(0.2),
                                                          percentageNotAvailable:
                                                              _profileFuture
                                                                      .vitA ==
                                                                  0,
                                                          ingredientName: Languages
                                                                  .of(context)!
                                                              .NINTextRetinolVitAMcg,
                                                          ingredientValue:
                                                              mealsFood[0].mealRetinolVitA.toStringAsFixed(mealsFood[0].mealRetinolVitA >= 99 ? 0 : 2),
                                                          earValue:
                                                              _profileFuture.vitA.toStringAsFixed(_profileFuture.vitA >= 99 ? 0 : 2),
                                                          percentage: mealsFood[
                                                                      0]
                                                                  .mealRetinolVitA *
                                                              100 /
                                                              (_profileFuture
                                                                          .vitA ==
                                                                      0
                                                                  ? 1
                                                                  : _profileFuture
                                                                      .vitA),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  media.width *
                                                                      0.85,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                // color: TColor
                                                                //     .primaryColor1
                                                                //     .withOpacity(
                                                                //         0.2),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      Languages.of(
                                                                              context)!
                                                                          .ninTextAdequateIntakeCarbs // style:
                                                                      // style:
                                                                      //     TextStyle(
                                                                      //   fontWeight:
                                                                      //       FontWeight
                                                                      //           .bold,
                                                                      //   fontSize:
                                                                      //       16.0,
                                                                      // ),
                                                                      ),
                                                                  const SizedBox(
                                                                      height:
                                                                          8.0),
                                                                  Text(
                                                                      Languages.of(
                                                                              context)!
                                                                          .ninTextAdequateIntakeFiber // style:
                                                                      //     TextStyle(
                                                                      //   fontWeight:
                                                                      //       FontWeight
                                                                      //           .bold,
                                                                      //   fontSize:
                                                                      //       16.0,
                                                                      // ),
                                                                      ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        if (mealsFood[i]
                                                                .totalmealCalories >
                                                            0)
                                                          Column(
                                                            children: [
                                                              const Center(
                                                                  child: Text(
                                                                "Nutrient intake based on AMDR",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      AppFontSizes
                                                                          .mediumDefault,
                                                                ),
                                                              )),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.85,
                                                                child: CarbIntakeResultContainer(
                                                                    carbIntake: (mealsFood[i].mealCarbs *
                                                                            4 *
                                                                            100) /
                                                                        (mealsFood[i]
                                                                            .totalmealCalories)),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.85,
                                                                child:
                                                                    FatIntakeResultContainerI(
                                                                  fatIntake: (mealsFood[i]
                                                                              .mealFats *
                                                                          9 *
                                                                          100) /
                                                                      (mealsFood[
                                                                              i]
                                                                          .totalmealCalories),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.85,
                                                                child:
                                                                    ProteinIntakeResultContainer(
                                                                  proteinIntake: (mealsFood[i]
                                                                              .mealProteins *
                                                                          4 *
                                                                          100) /
                                                                      (mealsFood[
                                                                              i]
                                                                          .totalmealCalories),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.85,
                                                                child:
                                                                    RefinedSugarIntakeResultContainer(
                                                                  sugarIntake:
                                                                      sugar,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.85,
                                                                child:
                                                                    SaltIntakeResultContainer(
                                                                  saltIntake:
                                                                      salt,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.85,
                                                                child:
                                                                    DDSResultContainer(),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        SizedBox(
                                                          width: media.width *
                                                              0.82,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.5,
                                                                // height: 35,
                                                                child:
                                                                    RoundButton(
                                                                  title:
                                                                      "View previous diaries",
                                                                  type: RoundButtonType
                                                                      .bgGradient,
                                                                  fontSize:
                                                                      AppFontSizes
                                                                          .mediumDefault,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                DietryDiary(),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // SingleChildScrollView(
                                    //   scrollDirection: Axis.horizontal,
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceEvenly,
                                    //     children: [
                                    //       CustomGradientWidgettotal(
                                    //         imageAsset: 'assets/img/burn.png',
                                    //         value:
                                    //             '${mealsFood[0].totalmealCalories.toStringAsFixed(1)} Kcal (cal)',
                                    //       ),
                                    //       CustomGradientWidgettotal(
                                    //         imageAsset:
                                    //             'assets/img/proteins.png',
                                    //         value:
                                    //             ' ${mealsFood[0].mealProteins.toStringAsFixed(1)} g (protien)',
                                    //       ),
                                    //       CustomGradientWidgettotal(
                                    //         imageAsset: 'assets/img/egg.png',
                                    //         value:
                                    //             ' ${mealsFood[0].mealFats.toStringAsFixed(1)} g (fats)',
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // SingleChildScrollView(
                                    //   scrollDirection: Axis.horizontal,
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceEvenly,
                                    //     children: [
                                    //       CustomGradientWidgettotal(
                                    //         imageAsset: 'assets/img/carbo.png',
                                    //         value:
                                    //             ' ${mealsFood[0].mealCarbs.toStringAsFixed(mealsFood[0].mealCarbs >= 99 ? 0 : 2)} /${mealsFood[0].mealCarbs.toStringAsFixed(_profileFuture.carbohydrate >= 99 ? 0 : 2)}',
                                    //       ),
                                    //       CustomGradientWidgettotal(
                                    //         imageAsset: 'assets/img/egg.png',
                                    //         value:
                                    //             ' ${mealsFood[0].mealFibers.toStringAsFixed(1)} g (fibers)',
                                    //       ),
                                    //       // CustomGradientWidgetDishTotal(
                                    //       //   imageAsset: 'assets/img/egg.png',
                                    //       //   value:
                                    //       //       'Ingred ${mealsFood[0].totalmealCalories}',
                                    //       // )
                                    //     ],
                                    //   ),
                                    // ),
                                    // sizedBox12(),

                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       left: 20.0,
                                    //       right: 18,
                                    //       bottom: 8,
                                    //       top: 8),
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(15.0),
                                    //       color: ThemeManager.themelightColor,
                                    //     ),
                                    //     child: Column(
                                    //       children: [
                                    //         ListTile(
                                    //           title: Row(
                                    //             children: [
                                    //               SizedBox(
                                    //                 width: 250,
                                    //                 child: Text(
                                    //                   Languages.of(context)!
                                    //                       .mainlabelTotalNutritionTaken,
                                    //                   style: TextStyle(
                                    //                       color: ThemeManager
                                    //                           .themeText),
                                    //                 ),
                                    //               ),
                                    //               Spacer(),
                                    //               Icon(
                                    //                 isExpanded
                                    //                     ? Icons.expand_less
                                    //                     : Icons.expand_more,
                                    //                 color:
                                    //                     ThemeManager.themeText,
                                    //               ),
                                    //             ],
                                    //           ),
                                    //           onTap: () {
                                    //             setState(() {
                                    //               isExpanded = !isExpanded;
                                    //             });
                                    //           },
                                    //         ),
                                    //         if (isExpanded)
                                    //           Padding(
                                    //             padding:
                                    //                 const EdgeInsets.all(10.0),
                                    //             child: SingleChildScrollView(
                                    //               scrollDirection:
                                    //                   Axis.horizontal,
                                    //               child: DataTable(
                                    //                 headingRowColor:
                                    //                     MaterialStateColor
                                    //                         .resolveWith(
                                    //                   (states) =>
                                    //                       const Color.fromARGB(
                                    //                           255,
                                    //                           124,
                                    //                           123,
                                    //                           123),
                                    //                 ),
                                    //                 columns: [
                                    //                   DataColumn(
                                    //                     label: Text(
                                    //                       'Nutrition',
                                    //                       style: TextStyle(
                                    //                           color: ThemeManager
                                    //                               .themeText),
                                    //                     ),
                                    //                     numeric: false,
                                    //                     tooltip:
                                    //                         'Nutrition Name',
                                    //                   ),
                                    //                   DataColumn(
                                    //                     label: Text(
                                    //                       'Value',
                                    //                       style: TextStyle(
                                    //                           color: ThemeManager
                                    //                               .themeText),
                                    //                     ),
                                    //                     numeric: true,
                                    //                     tooltip:
                                    //                         'Weight of Ingredient',
                                    //                   ),
                                    //                   DataColumn(
                                    //                     label: Text(
                                    //                       'EAR',
                                    //                       style: TextStyle(
                                    //                           color: ThemeManager
                                    //                               .themeText),
                                    //                     ),
                                    //                     numeric: true,
                                    //                     tooltip: 'Ear',
                                    //                   ),
                                    //                   DataColumn(
                                    //                     label: Text(
                                    //                       'percentage',
                                    //                       style: TextStyle(
                                    //                           color: ThemeManager
                                    //                               .themeText),
                                    //                     ),
                                    //                     numeric: true,
                                    //                     tooltip: 'Ear',
                                    //                   ),
                                    //                 ],
                                    //                 rows: [
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text(
                                    //                           'Calories (Kcal)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].totalmealCalories.toStringAsFixed(mealsFood[0].totalmealCalories >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.energy.toStringAsFixed(_profileFuture.energy >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .energy !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .totalmealCalories *
                                    //                                 100 /
                                    //                                 (_profileFuture.energy ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .energy),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text('Protein (g)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealProteins.toStringAsFixed(mealsFood[0].mealProteins >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.protein.toStringAsFixed(_profileFuture.protein >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .protein !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealProteins *
                                    //                                 100 /
                                    //                                 (_profileFuture.protein ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .protein),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text('Fat (g)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealFats.toStringAsFixed(mealsFood[0].mealFats >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.fatsOilsVisible.toStringAsFixed(_profileFuture.fatsOilsVisible >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .fatsOilsVisible !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealFats *
                                    //                                 100 /
                                    //                                 (_profileFuture.fatsOilsVisible ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .fatsOilsVisible),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text(
                                    //                           'Carbohydrates (g)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealCarbs.toStringAsFixed(mealsFood[0].mealCarbs >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.carbohydrate.toStringAsFixed(_profileFuture.carbohydrate >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .carbohydrate !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealCarbs *
                                    //                                 100 /
                                    //                                 (_profileFuture.carbohydrate ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .carbohydrate),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text('Calcium (mg)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealCalcium.toStringAsFixed(mealsFood[0].mealCalcium >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.calcium.toStringAsFixed(_profileFuture.calcium >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .calcium !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealCalcium *
                                    //                                 100 /
                                    //                                 (_profileFuture.calcium ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .calcium),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text('Fiber (g)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealFibers.toStringAsFixed(mealsFood[0].mealFibers >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.fiber.toStringAsFixed(_profileFuture.fiber >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .fiber !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealFibers *
                                    //                                 100 /
                                    //                                 (_profileFuture.fiber ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .fiber),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text('Iron (mg)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealIron.toStringAsFixed(mealsFood[0].mealIron >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.iron.toStringAsFixed(_profileFuture.iron >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .iron !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealIron *
                                    //                                 100 /
                                    //                                 (_profileFuture.iron ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .iron),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text('Zinc (mg)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealZinc.toStringAsFixed(mealsFood[0].mealZinc >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.zinc.toStringAsFixed(_profileFuture.zinc >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .zinc !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealZinc *
                                    //                                 100 /
                                    //                                 (_profileFuture.zinc ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .zinc),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text('Magnesium (mg)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealMagnesium.toStringAsFixed(mealsFood[0].mealMagnesium >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.magnesium.toStringAsFixed(_profileFuture.magnesium >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .magnesium !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealMagnesium *
                                    //                                 100 /
                                    //                                 (_profileFuture.magnesium ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .magnesium),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text(
                                    //                           'Thiamine (B1) (mg)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealThiamineB1.toStringAsFixed(mealsFood[0].mealThiamineB1 >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.thiamine.toStringAsFixed(_profileFuture.thiamine >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .thiamine !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealThiamineB1 *
                                    //                                 100 /
                                    //                                 (_profileFuture.thiamine ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .thiamine),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text(
                                    //                           'Riboflavin (B2) (mg)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealRiboflavinB2.toStringAsFixed(mealsFood[0].mealRiboflavinB2 >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.riboflavin.toStringAsFixed(_profileFuture.riboflavin >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .riboflavin !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealRiboflavinB2 *
                                    //                                 100 /
                                    //                                 (_profileFuture.riboflavin ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .riboflavin),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text(
                                    //                           'Niacin (B3) (mg)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealNiacinB3.toStringAsFixed(mealsFood[0].mealNiacinB3 >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.niacin.toStringAsFixed(_profileFuture.niacin >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .niacin !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealNiacinB3 *
                                    //                                 100 /
                                    //                                 (_profileFuture.niacin ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .niacin),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text(
                                    //                           'Folates (B9) (ug)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealFolatesB9.toStringAsFixed(mealsFood[0].mealFolatesB9 >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.folate.toStringAsFixed(_profileFuture.folate >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .folate !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealFolatesB9 *
                                    //                                 100 /
                                    //                                 (_profileFuture.folate ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .folate),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                   DataRow(cells: [
                                    //                     DataCell(
                                    //                       Text(
                                    //                           'Retinol (Vit A) (ug)',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${mealsFood[0].mealRetinolVitA.toStringAsFixed(mealsFood[0].mealRetinolVitA >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(
                                    //                       Text(
                                    //                           '${_profileFuture.vitA.toStringAsFixed(_profileFuture.vitA >= 99 ? 0 : 2)}',
                                    //                           style: TextStyle(
                                    //                               color: ThemeManager
                                    //                                   .themeText)),
                                    //                     ),
                                    //                     DataCell(_profileFuture
                                    //                                 .vitA !=
                                    //                             0
                                    //                         ? MyHorizontalProgressBar(
                                    //                             percentage: mealsFood[
                                    //                                         0]
                                    //                                     .mealRetinolVitA *
                                    //                                 100 /
                                    //                                 (_profileFuture.vitA ==
                                    //                                         0
                                    //                                     ? 1
                                    //                                     : _profileFuture
                                    //                                         .vitA),
                                    //                           )
                                    //                         : Text("NA")),
                                    //                   ]),
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //           )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Container(
                                    //     width: screenWidth * 0.9,
                                    //     decoration: BoxDecoration(
                                    //       gradient: LinearGradient(colors: [
                                    //         TColor.primaryColor1.withOpacity(0.2),
                                    //         TColor.secondaryColor1.withOpacity(0.2)
                                    //       ]),
                                    //       // color: Colors.blueAccent,
                                    //       borderRadius: BorderRadius.circular(15),
                                    //     ),
                                    //     child: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         Padding(
                                    //           padding:
                                    //               const EdgeInsets.only(left: 16.0),
                                    //           child: Text(
                                    //             'BreakFast',
                                    //             style: TextStyle(
                                    //                 color: ThemeManager.themeText),
                                    //           ),
                                    //         ),
                                    //         for (int j = 0;
                                    //             j < mealsFood[0].rlist.length;
                                    //             j++)
                                    //           if (mealsFood[i].rlist[j].mealtype ==
                                    //               'Early Morning')
                                    //             InkWell(
                                    //               onTap: () {
                                    //                 debugPrint(
                                    //                     "dish id id hhhh${mealsFood[i].rlist[j].dishId}");
                                    //                 Navigator.push(
                                    //                   context,
                                    //                   MaterialPageRoute(
                                    //                     builder: (context) =>
                                    //                         FoodDetailsPage(
                                    //                             dish: mealsFood[i]
                                    //                                 .rlist[j]),
                                    //                   ),
                                    //                 );
                                    //               },
                                    //               child: EachMealListCustomWidget(
                                    //                 labelText1:
                                    //                     ' ${mealsFood[i].rlist[j].dishName}',
                                    //                 labelText2:
                                    //                     '${mealsFood[i].rlist[j].totalCalories.toStringAsFixed(1)} kcal',
                                    //                 labelText3:
                                    //                     ' ${mealsFood[i].rlist[j].mealtype}',
                                    //                 // 'mealtype',
                                    //               ),
                                    //             ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF007BC1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(0x111D1617),
                                              blurRadius: 40,
                                              offset: Offset(0, 10),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  bottom: 8,
                                                  left: 12),
                                              child: SizedBox(
                                                width: media.width * 0.55,
                                                child: Text(
                                                  // Languages.of(context)!.labelRecentMeal,
                                                  //    '${Languages.of(context)!.NINTextMealsTakenOn} $currentDate ($selectedOption) ',
                                                  "${Languages.of(context)!.ninTextMyNutrientIntake} ${Languages.of(context)!.ninTextOn}  ${DateFormatter.convertDate(currentDate)} - $selectedOption",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: AppFontSizes
                                                        .mediumDefault,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w900,
                                                    // height: 0.09,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: 5,
                                            // ),
                                            Container(
                                              // width: 150,
                                              height: 30,
                                              decoration: ShapeDecoration(
                                                color: const Color.fromARGB(
                                                    255, 189, 20, 124),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                shadows: const [
                                                  BoxShadow(
                                                    color: Color(0x111D1617),
                                                    blurRadius: 40,
                                                    offset: Offset(0, 10),
                                                    spreadRadius: 0,
                                                  )
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Center(
                                                  child: DropdownButton<String>(
                                                    value: selectedOptionbyuser,
                                                    // icon: Icon(Icons.expand_more,
                                                    //     color: ThemeManager
                                                    //         .themeColor),
                                                    // hint: Text(
                                                    //   selectedOptionbyuser,
                                                    //   textAlign: TextAlign.center,
                                                    //   style: TextStyle(
                                                    //       color: ThemeManager
                                                    //           .themeColor,
                                                    //       fontSize: AppFontSizes.smallDefault,),
                                                    // ),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 189, 20, 124),
                                                    icon: Icon(
                                                        Icons.expand_more,
                                                        color: ThemeManager
                                                            .themeColor),
                                                    menuMaxHeight: 200,
                                                    underline: Container(),
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        selectedOptionbyuser =
                                                            newValue!;
                                                      });
                                                      saveSelectedOption(
                                                          newValue!);
                                                    },
                                                    items: <String>[
                                                      'Calories',
                                                      'Proteins',
                                                      'Carbohydrate',
                                                      'Fat',
                                                      'Fibre',
                                                      'Calcium',
                                                      'Iron',
                                                      'Zinc',
                                                      'Magnesium',
                                                      'Thiamine (B1)',
                                                      'Riboflavin (B2)',
                                                      'Niacin (B3)',
                                                      'Folates (B9)',
                                                      'Vitamin A',
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (selectedOption == 'Full Day' ||
                                        selectedOption == 'Early Morning')
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: screenWidth * 0.9,
                                          decoration: BoxDecoration(
                                            // gradient: LinearGradient(colors: [
                                            //   TColor.primaryColor1.withOpacity(0.2),
                                            //   TColor.secondaryColor1.withOpacity(0.2)
                                            // ]),
                                            color: const Color(0xFFBBDDFF),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 220,
                                                        child: Text(
                                                          Languages.of(context)!
                                                              .mainlabelEarlyMorning,
                                                          style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Other widgets you may have
                                                  ],
                                                ),
                                              ),
                                              for (int j = 0;
                                                  j < mealsFood[0].rlist.length;
                                                  j++)
                                                if (mealsFood[i]
                                                        .rlist[j]
                                                        .mealtype ==
                                                    'Early Morning')
                                                  // if(NumberingforFood++)
                                                  InkWell(
                                                    onTap: () {
                                                      debugPrint(
                                                          "dish id id hhhh${mealsFood[i].rlist[j].dishId}");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FoodDetailsPage(
                                                                  dish: mealsFood[
                                                                          i]
                                                                      .rlist[j]),
                                                        ),
                                                      );
                                                    },
                                                    child:
                                                        buildEachMealListCustomWidget(
                                                      valueforOneUnit:
                                                          mealsFood[i]
                                                              .rlist[j]
                                                              .valueforOneUnit,
                                                      unit: mealsFood[i]
                                                          .rlist[j]
                                                          .unit,
                                                      context: context,
                                                      foodid: mealsFood[i]
                                                          .rlist[j]
                                                          .dishId,
                                                      labelText1:
                                                          ' ${mealsFood[i].rlist[j].dishName}',
                                                      labelText2:
                                                          selectedOptionbyuserReturnValue(
                                                              mealsFood[i]
                                                                  .rlist[j]),
                                                      weightTaken:
                                                          '${mealsFood[i].rlist[j].servingSize.toStringAsFixed(mealsFood[i].rlist[j].servingSize >= 99 ? 0 : 2)} ',
                                                      labelText3:
                                                          ' ${mealsFood[i].rlist[j].mealtype}',
                                                      Numbering:
                                                          NumberingforEarlyMorning++,
                                                      //'mealtype',
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (selectedOption == 'Full Day' ||
                                        selectedOption == 'Breakfast')
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: screenWidth * 0.9,
                                          decoration: BoxDecoration(
                                            // gradient: LinearGradient(colors: [
                                            //   TColor.primaryColor1.withOpacity(0.2),
                                            //   TColor.secondaryColor1.withOpacity(0.2)
                                            // ]),
                                            color: const Color(0xFFBBDDFF),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 220,
                                                        child: Text(
                                                          Languages.of(context)!
                                                              .labelBreakfast,
                                                          style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Other widgets you may have
                                                  ],
                                                ),
                                              ),
                                              for (int j = 0;
                                                  j < mealsFood[0].rlist.length;
                                                  j++)
                                                if (mealsFood[i]
                                                        .rlist[j]
                                                        .mealtype ==
                                                    'Breakfast')
                                                  InkWell(
                                                    onTap: () {
                                                      debugPrint(
                                                          "dish id id hhhh${mealsFood[i].rlist[j].dishId}");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FoodDetailsPage(
                                                                  dish: mealsFood[
                                                                          i]
                                                                      .rlist[j]),
                                                        ),
                                                      );
                                                    },
                                                    child:
                                                        buildEachMealListCustomWidget(
                                                      valueforOneUnit:
                                                          mealsFood[i]
                                                              .rlist[j]
                                                              .valueforOneUnit,
                                                      unit: mealsFood[i]
                                                          .rlist[j]
                                                          .unit,
                                                      context: context,

                                                      foodid: mealsFood[i]
                                                          .rlist[j]
                                                          .dishId,
                                                      labelText1:
                                                          ' ${mealsFood[i].rlist[j].dishName}',
                                                      labelText2:
                                                          selectedOptionbyuserReturnValue(
                                                              mealsFood[i]
                                                                  .rlist[j]),
                                                      weightTaken:
                                                          mealsFood[i].rlist[j].servingSize.toStringAsFixed(mealsFood[i].rlist[j].servingSize >= 99 ? 0 : 2),
                                                      labelText3:
                                                          ' ${mealsFood[i].rlist[j].mealtype}',
                                                      Numbering:
                                                          NumberingforBreakfast++,
                                                      // 'mealtype',
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (selectedOption == 'Full Day' ||
                                        selectedOption == 'Mid Morning')
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: screenWidth * 0.9,
                                          decoration: BoxDecoration(
                                            // gradient: LinearGradient(colors: [
                                            //   TColor.primaryColor1.withOpacity(0.2),
                                            //   TColor.secondaryColor1.withOpacity(0.2)
                                            // ]),
                                            color: const Color(0xFFBBDDFF),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 220,
                                                        child: Text(
                                                          Languages.of(context)!
                                                              .mainlabelMidMorning,
                                                          style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Other widgets you may have
                                                  ],
                                                ),
                                              ),
                                              for (int j = 0;
                                                  j < mealsFood[0].rlist.length;
                                                  j++)
                                                if (mealsFood[i]
                                                        .rlist[j]
                                                        .mealtype ==
                                                    'Mid Morning')
                                                  InkWell(
                                                    onTap: () {
                                                      debugPrint(
                                                          "dish id id hhhh${mealsFood[i].rlist[j].dishId}");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FoodDetailsPage(
                                                                  dish: mealsFood[
                                                                          i]
                                                                      .rlist[j]),
                                                        ),
                                                      );
                                                    },
                                                    child:
                                                        buildEachMealListCustomWidget(
                                                      valueforOneUnit:
                                                          mealsFood[i]
                                                              .rlist[j]
                                                              .valueforOneUnit,
                                                      unit: mealsFood[i]
                                                          .rlist[j]
                                                          .unit,
                                                      context: context,

                                                      foodid: mealsFood[i]
                                                          .rlist[j]
                                                          .dishId,
                                                      labelText1:
                                                          ' ${mealsFood[i].rlist[j].dishName}',
                                                      labelText2:
                                                          selectedOptionbyuserReturnValue(
                                                              mealsFood[i]
                                                                  .rlist[j]),
                                                      weightTaken:
                                                          '${mealsFood[i].rlist[j].servingSize.toStringAsFixed(mealsFood[i].rlist[j].servingSize >= 99 ? 0 : 2)} ',
                                                      labelText3:
                                                          ' ${mealsFood[i].rlist[j].mealtype}',
                                                      Numbering:
                                                          NumberingforMidMorning++,
                                                      // 'mealtype',
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (selectedOption == 'Full Day' ||
                                        selectedOption == 'Lunch')
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: screenWidth * 0.9,
                                          decoration: BoxDecoration(
                                            // gradient: LinearGradient(colors: [
                                            //   TColor.primaryColor1.withOpacity(0.2),
                                            //   TColor.secondaryColor1.withOpacity(0.2)
                                            // ]),
                                            color: const Color(0xFFBBDDFF),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 220,
                                                        child: Text(
                                                          Languages.of(context)!
                                                              .labelLunch,
                                                          style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Other widgets you may have
                                                  ],
                                                ),
                                              ),
                                              for (int j = 0;
                                                  j < mealsFood[0].rlist.length;
                                                  j++)
                                                if (mealsFood[i]
                                                        .rlist[j]
                                                        .mealtype ==
                                                    'Lunch')
                                                  InkWell(
                                                    onTap: () {
                                                      debugPrint(
                                                          "dish id id hhhh${mealsFood[i].rlist[j].dishId}");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FoodDetailsPage(
                                                                  dish: mealsFood[
                                                                          i]
                                                                      .rlist[j]),
                                                        ),
                                                      );
                                                    },
                                                    child:
                                                        buildEachMealListCustomWidget(
                                                      valueforOneUnit:
                                                          mealsFood[i]
                                                              .rlist[j]
                                                              .valueforOneUnit,
                                                      unit: mealsFood[i]
                                                          .rlist[j]
                                                          .unit,
                                                      context: context,

                                                      foodid: mealsFood[i]
                                                          .rlist[j]
                                                          .dishId,
                                                      labelText1:
                                                          ' ${mealsFood[i].rlist[j].dishName}',
                                                      labelText2:
                                                          selectedOptionbyuserReturnValue(
                                                              mealsFood[i]
                                                                  .rlist[j]),
                                                      weightTaken:
                                                          '${mealsFood[i].rlist[j].servingSize.toStringAsFixed(mealsFood[i].rlist[j].servingSize >= 99 ? 0 : 2)} ',
                                                      labelText3:
                                                          ' ${mealsFood[i].rlist[j].mealtype}',
                                                      Numbering:
                                                          NumberingforLunch++,
                                                      // 'mealtype',
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (selectedOption == 'Full Day' ||
                                        selectedOption == 'Evening')
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: screenWidth * 0.9,
                                          decoration: BoxDecoration(
                                            // gradient: LinearGradient(colors: [
                                            //   TColor.primaryColor1.withOpacity(0.2),
                                            //   TColor.secondaryColor1.withOpacity(0.2)
                                            // ]),
                                            color: const Color(0xFFBBDDFF),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 220,
                                                        child: Text(
                                                          Languages.of(context)!
                                                              .mainlabelEvening,
                                                          style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Other widgets you may have
                                                  ],
                                                ),
                                              ),
                                              for (int j = 0;
                                                  j < mealsFood[0].rlist.length;
                                                  j++)
                                                if (mealsFood[i]
                                                        .rlist[j]
                                                        .mealtype ==
                                                    'Evening')
                                                  InkWell(
                                                    onTap: () {
                                                      debugPrint(
                                                          "dish id id hhhh${mealsFood[i].rlist[j].dishId}");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FoodDetailsPage(
                                                                  dish: mealsFood[
                                                                          i]
                                                                      .rlist[j]),
                                                        ),
                                                      );
                                                    },
                                                    child:
                                                        buildEachMealListCustomWidget(
                                                      valueforOneUnit:
                                                          mealsFood[i]
                                                              .rlist[j]
                                                              .valueforOneUnit,
                                                      unit: mealsFood[i]
                                                          .rlist[j]
                                                          .unit,
                                                      context: context,

                                                      foodid: mealsFood[i]
                                                          .rlist[j]
                                                          .dishId,
                                                      labelText1:
                                                          ' ${mealsFood[i].rlist[j].dishName}',
                                                      labelText2:
                                                          selectedOptionbyuserReturnValue(
                                                              mealsFood[i]
                                                                  .rlist[j]),
                                                      weightTaken:
                                                          '${mealsFood[i].rlist[j].servingSize.toStringAsFixed(mealsFood[i].rlist[j].servingSize >= 99 ? 0 : 2)} ',
                                                      labelText3:
                                                          ' ${mealsFood[i].rlist[j].mealtype}',
                                                      Numbering:
                                                          NumberingforEvening++,
                                                      // 'mealtype',
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (selectedOption == 'Full Day' ||
                                        selectedOption == 'Dinner')
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: screenWidth * 0.9,
                                          decoration: BoxDecoration(
                                            // gradient: LinearGradient(colors: [
                                            //   TColor.primaryColor1.withOpacity(0.2),
                                            //   TColor.secondaryColor1.withOpacity(0.2)
                                            // ]),
                                            color: const Color(0xFFBBDDFF),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 220,
                                                        child: Text(
                                                          Languages.of(context)!
                                                              .labelDinner,
                                                          style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Other widgets you may have
                                                  ],
                                                ),
                                              ),
                                              for (int j = 0;
                                                  j < mealsFood[0].rlist.length;
                                                  j++)
                                                if (mealsFood[i]
                                                        .rlist[j]
                                                        .mealtype ==
                                                    'Dinner')
                                                  InkWell(
                                                    onTap: () {
                                                      debugPrint(
                                                          "dish id id hhhh${mealsFood[i].rlist[j].dishId}");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FoodDetailsPage(
                                                                  dish: mealsFood[
                                                                          i]
                                                                      .rlist[j]),
                                                        ),
                                                      );
                                                    },
                                                    child:
                                                        buildEachMealListCustomWidget(
                                                      valueforOneUnit:
                                                          mealsFood[i]
                                                              .rlist[j]
                                                              .valueforOneUnit,
                                                      unit: mealsFood[i]
                                                          .rlist[j]
                                                          .unit,
                                                      context: context,

                                                      foodid: mealsFood[i]
                                                          .rlist[j]
                                                          .dishId,
                                                      labelText1:
                                                          ' ${mealsFood[i].rlist[j].dishName}',
                                                      labelText2:
                                                          selectedOptionbyuserReturnValue(
                                                              mealsFood[i]
                                                                  .rlist[j]),
                                                      weightTaken:
                                                          '${mealsFood[i].rlist[j].servingSize.toStringAsFixed(mealsFood[i].rlist[j].servingSize >= 99 ? 0 : 2)} ',
                                                      labelText3:
                                                          ' ${mealsFood[i].rlist[j].mealtype}',
                                                      Numbering:
                                                          NumberingforDinner++,
                                                      // 'mealtype',
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (selectedOption == 'Full Day' ||
                                        selectedOption == 'Bed Time')
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: screenWidth * 0.9,
                                          decoration: BoxDecoration(
                                            // gradient: LinearGradient(colors: [
                                            //   TColor.primaryColor1.withOpacity(0.2),
                                            //   TColor.secondaryColor1.withOpacity(0.2)
                                            // ]),
                                            color: const Color(0xFFBBDDFF),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        // width: 220,
                                                        child: Text(
                                                          Languages.of(context)!
                                                              .mainlabelBedtime,
                                                          style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Other widgets you may have
                                                  ],
                                                ),
                                              ),
                                              for (int j = 0;
                                                  j < mealsFood[0].rlist.length;
                                                  j++)
                                                if (mealsFood[i]
                                                        .rlist[j]
                                                        .mealtype ==
                                                    'Bed Time')
                                                  InkWell(
                                                    onTap: () {
                                                      debugPrint(
                                                          "dish id id hhhh${mealsFood[i].rlist[j].dishId}");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FoodDetailsPage(
                                                                  dish: mealsFood[
                                                                          i]
                                                                      .rlist[j]),
                                                        ),
                                                      );
                                                    },
                                                    child:
                                                        buildEachMealListCustomWidget(
                                                      valueforOneUnit:
                                                          mealsFood[i]
                                                              .rlist[j]
                                                              .valueforOneUnit,
                                                      unit: mealsFood[i]
                                                          .rlist[j]
                                                          .unit,
                                                      context: context,

                                                      foodid: mealsFood[i]
                                                          .rlist[j]
                                                          .dishId,
                                                      labelText1:
                                                          ' ${mealsFood[i].rlist[j].dishName}',
                                                      labelText2:
                                                          selectedOptionbyuserReturnValue(
                                                              mealsFood[i]
                                                                  .rlist[j]),
                                                      weightTaken:
                                                          '${mealsFood[i].rlist[j].servingSize.toStringAsFixed(mealsFood[i].rlist[j].servingSize >= 99 ? 0 : 2)} ',
                                                      labelText3:
                                                          ' ${mealsFood[i].rlist[j].mealtype}',
                                                      Numbering:
                                                          NumberingforBedTime++,
                                                      // 'mealtype',
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    Text(
                                      '${NumberingforEarlyMorning = 1} ${NumberingforBreakfast = 1} ${NumberingforMidMorning = 1} ${NumberingforLunch = 1} ${NumberingforEvening = 1} ${NumberingforDinner = 1} ${NumberingforBedTime = 1}',
                                      style: TextStyle(
                                          color: ThemeManager.themeColor),
                                    )
                                  ],
                                ),

                              // SizedBox(
                              //   height: 400,
                              // )
                              // ListView.builder(
                              //   shrinkWrap: true,
                              //   physics: NeverScrollableScrollPhysics(),
                              //   itemCount: mealsFood[0].rlist.length,
                              //   itemBuilder: (context, dishIndex) {
                              //     Dish dish = mealsFood[i].rlist[dishIndex];

                              //     return InkWell(
                              //       onTap: () {
                              //         debugPrint("dish id id hhhh${dish.dishId}");
                              //         Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) =>
                              //                 FoodDetailsPage(dish: dish),
                              //           ),
                              //         );
                              //       },
                              //       child: EachMealListCustomWidget(
                              //         labelText1: ' ${dish.dishName}',
                              //         labelText2:
                              //             '${dish.totalCalories.toStringAsFixed(1)} kcal',
                              //       ),
                              //     );
                              //   },
                              // ),
                            ],
                          ),
                        )),
                        // Expanded(
                        //     child: ListView.builder(
                        //   itemCount: mealsFood.length,
                        //   itemBuilder: (context, mealIndex) {
                        //     Meal meal = mealsFood[mealIndex];
                        //     return SingleChildScrollView(
                        //       child: Column(
                        //         children: [
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             children: [
                        //               Padding(
                        //                 padding: const EdgeInsets.all(20.0),
                        //                 child: Text(
                        //                   'Recent Meals',
                        //                   style: TextStyle(
                        //                     color: ThemeManager.themeText,
                        //                     fontSize: AppFontSizes.mediumDefault,
                        //                     fontFamily: 'Poppins',
                        //                     fontWeight: FontWeight.w500,
                        //                     height: 0.09,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           ListView.builder(
                        //             shrinkWrap: true,
                        //             physics: NeverScrollableScrollPhysics(),
                        //             itemCount: mealsFood[0].rlist.length,
                        //             itemBuilder: (context, dishIndex) {
                        //               Dish dish = meal.rlist[dishIndex];

                        //               return InkWell(
                        //                 onTap: () {
                        //                   debugPrint("dish id id hhhh${dish.dishId}");
                        //                   Navigator.push(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                       builder: (context) =>
                        //                           FoodDetailsPage(dish: dish),
                        //                     ),
                        //                   );
                        //                 },
                        //                 child: EachMealListCustomWidget(
                        //                   labelText1: ' ${dish.dishName}',
                        //                   labelText2:
                        //                       '${dish.totalCalories.toStringAsFixed(1)} kcal',
                        //                 ),
                        //               );
                        //             },
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // )),
                        // Expanded(
                        //   child: FutureBuilder<List<Meal>>(
                        //     future: fetchMeals(),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.connectionState ==
                        //           ConnectionState.waiting) {
                        //         return Center(child: CircularProgressIndicator());
                        //       } else if (snapshot.hasError) {
                        //         // return Text('Error: ${snapshot.error}');
                        //         return ErrorPage(errorMessage: '${snapshot.error}');
                        //       } else if (snapshot.hasData) {
                        //         // Check if snapshot.data is not null
                        //         return ListView.builder(
                        //           itemCount: snapshot.data!.length,
                        //           itemBuilder: (context, mealIndex) {
                        //             Meal meal = snapshot.data![mealIndex];
                        //             return SingleChildScrollView(
                        //               child: Column(
                        //                 children: [
                        //                   Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.start,
                        //                     children: [
                        //                       Padding(
                        //                         padding: const EdgeInsets.all(20.0),
                        //                         child: Text(
                        //                           'Recent Meals',
                        //                           style: TextStyle(
                        //                             color: ThemeManager.themeText,
                        //                             fontSize: AppFontSizes.mediumDefault,
                        //                             fontFamily: 'Poppins',
                        //                             fontWeight: FontWeight.w500,
                        //                             height: 0.09,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   ListView.builder(
                        //                     shrinkWrap: true,
                        //                     physics: NeverScrollableScrollPhysics(),
                        //                     itemCount: meal.rlist.length,
                        //                     itemBuilder: (context, dishIndex) {
                        //                       Dish dish = meal.rlist[dishIndex];

                        //                       return InkWell(
                        //                         onTap: () {
                        //                           debugPrint(
                        //                               "dish id id hhhh${dish.dishId}");
                        //                           Navigator.push(
                        //                             context,
                        //                             MaterialPageRoute(
                        //                               builder: (context) =>
                        //                                   FoodDetailsPage(dish: dish),
                        //                             ),
                        //                           );
                        //                         },
                        //                         child: EachMealListCustomWidget(
                        //                           labelText1: ' ${dish.dishName}',
                        //                           labelText2:
                        //                               '${dish.totalCalories.toStringAsFixed(1)} kcal',
                        //                         ),
                        //                       );
                        //                     },
                        //                   ),
                        //                 ],
                        //               ),
                        //             );
                        //           },
                        //         );
                        //         // MealListWidget(
                        //         //     meals: snapshot.data!); // Use snapshot.data!
                        //       } else {
                        //         return Text('No data available.');
                        //       }
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildEachMealListCustomWidget({
    required BuildContext context,
    required String labelText1,
    required String labelText2,
    required String labelText3,
    required String weightTaken,
    required String unit,
    required double valueforOneUnit,
    required int Numbering,
    required int foodid,
  }) {
    void editDishQuantity(
      BuildContext context,
      int foodid,
      String unit,
      double valueforOneUnit,
    ) {
      double ServingSizeFinal = 0;
      TextEditingController quantityController = TextEditingController();
      TextEditingController gramtoQuantity = TextEditingController();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          void calculateResult() {
            setState(() {
              // Get the entered number
              double enteredNumber =
                  double.tryParse(quantityController.text) ?? 0.0;
              ServingSizeFinal = (enteredNumber * valueforOneUnit);
              gramtoQuantity.text = (enteredNumber * valueforOneUnit)
                  .toStringAsFixed(
                      (enteredNumber * valueforOneUnit) >= 99 ? 0 : 2);

              setState(() {});
            });
          }

          void calculateResultgramTounit() {
            setState(() {
              // Get the entered number
              double enteredNumber =
                  double.tryParse(gramtoQuantity.text) ?? 0.0;
              quantityController.text = (enteredNumber / valueforOneUnit)
                  .toStringAsFixed(
                      (enteredNumber / valueforOneUnit) >= 99 ? 0 : 2);

              setState(() {});
            });
          }

          return AlertDialog(
            title: Text(Languages.of(context)!.editQuantity),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'One $unit = ${(valueforOneUnit.toStringAsFixed(valueforOneUnit >= 99 ? 0 : 2))}'), // Display value for one unit
                TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                      labelText:
                          Languages.of(context)!.mainlabelNumberOfServing),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    calculateResult();
                  },
                ),
                TextField(
                  controller: gramtoQuantity,
                  decoration: InputDecoration(
                      labelText: Languages.of(context)!.mainlabelNewWeightInG),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    calculateResultgramTounit();
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text(Languages.of(context)!.cancel),
              ),
              TextButton(
                onPressed: () async {
                  int numberOfUnits =
                      int.tryParse(quantityController.text) ?? 0;
                  debugPrint('Number of units: $numberOfUnits');
                  // double newQuantity = numberOfUnits *
                  // //     valueforOneUnit; // Calculate total quantity
                  // debugPrint('New quantity: $newQuantity');
                  await _controller.updateDishQuantity(
                      foodid, ServingSizeFinal);
                  loadSugarSalt();
                  // Call your API here to update the dish quantity
                  // await _controller.updateDishQuantity(foodid, newQuantity);
                  // Assuming _controller is an instance of your controller class
                  debugPrint('Quantity updated!');
                  Navigator.of(context).pop(); // Close dialog
                  fetchMeals();
                  // Uncomment if fetchMeals is a method in this class
                },
                child: Text(Languages.of(context)!.update),
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 8.0, top: 0, bottom: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: SizedBox(
                      width: 110,
                      child: Text(
                        "$Numbering. $labelText1",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: AppFontSizes.mediumDefault,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 220,
                  //   child: Text(
                  //     labelText3,
                  //     style: TextStyle(
                  //       color: TColor.primaryColor1,
                  //       fontSize: AppFontSizes.smallDefault,,
                  //       fontFamily: 'Poppins',
                  //       fontWeight: FontWeight.w400,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    // '$labelText2 / taken:$weightTaken g',
                    '$weightTaken g / $labelText2 ',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: AppFontSizes.smallDefault,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 20,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // title: Text('Delete Food'),
                            content:
                                Text(Languages.of(context)!.confirmDeleteFood),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close dialog
                                },
                                child: Text(Languages.of(context)!.cancel),
                              ),
                              TextButton(
                                onPressed: () async {
                                  // Perform delete operation here
                                  debugPrint('Food deleted!');
                                  await _controller.deleteDish(foodid);
                                  debugPrint('Food deleted!');
                                  Navigator.of(context).pop(); // Close dialog
                                  fetchMeals();
                                },
                                child:
                                    Text(Languages.of(context)!.ninTextDelete),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      editDishQuantity(context, foodid, unit, valueforOneUnit);
                    },
                  ),
                ],
              ),
              const SizedBox(width: 2.0),
            ],
          ),
        ),
      ),
    );
  }
}

class customtablerow extends StatelessWidget {
  const customtablerow({
    Key? key,
    required this.ingredientName,
    required this.ingredientValue,
    required this.earValue,
    required this.percentage,
    required this.percentageNotAvailable,
    required this.color, // Added color field
  }) : super(key: key);

  final String ingredientName;
  final String ingredientValue;
  final String earValue;
  final double percentage;
  final bool percentageNotAvailable;
  final Color color; // New color field

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: const Border(
          left: BorderSide(
            color: Color.fromARGB(255, 34, 104, 161),
            width: 2,
          ),
          right: BorderSide(
            color: Color.fromARGB(255, 34, 104, 161),
            width: 2,
          ),
          bottom: BorderSide(
            color: Color.fromARGB(255, 34, 104, 161),
            width: 2,
          ),
        ),
        color: color == TColor.primaryColor1.withOpacity(0.2) ? null : color,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 110, // Adjust the width according to your needs
              child: Text(ingredientName),
            ),
            SizedBox(
              width: 60, // Adjust the width according to your needs
              child: Text(ingredientValue),
            ),
            SizedBox(
              width: 60, // Adjust the width according to your needs
              child: Text(earValue),
            ),
            SizedBox(
              width: 115, // Adjust the width according to your needs
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  percentageNotAvailable
                      ? const Text("N/A")
                      : MyHorizontalProgressBar(
                          percentage: percentage,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class EachMealListCustomWidget extends StatelessWidget {
//   // final IconData icon;
//   final String labelText1;
//   final String labelText2;
//   final String labelText3;
//   final String weightTaken;
//   final int Numbering;
//   final int foodid;
//   final BuildContext context;

//   const EachMealListCustomWidget({
//     Key? key,
//     required this.labelText1,
//     required this.labelText2,
//     required this.labelText3,
//     required this.weightTaken,
//     required this.Numbering,
//     required this.foodid,
//     required this.context,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 4.0, right: 8.0, top: 0, bottom: 6),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           padding: EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: ThemeManager.themelightColor,
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Row(
//             children: [
//               SizedBox(width: 12.0),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: 140,
//                     child: Text(
//                       "$Numbering $labelText1",
//                       style: TextStyle(
//                         color: ThemeManager.themeText,
//                         fontSize: AppFontSizes.mediumDefault,
//                         fontFamily: 'Poppins',
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   // SizedBox(
//                   //   width: 220,
//                   //   child: Text(
//                   //     labelText3,
//                   //     style: TextStyle(
//                   //       color: TColor.primaryColor1,
//                   //       fontSize: AppFontSizes.smallDefault,,
//                   //       fontFamily: 'Poppins',
//                   //       fontWeight: FontWeight.w400,
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//               Spacer(),
//               Row(
//                 children: [
//                   Text(
//                     // '$labelText2 / taken:$weightTaken g',
//                     '$weightTaken g / $labelText2 ',
//                     style: TextStyle(
//                       color: ThemeManager.themeText,
//                       fontSize: AppFontSizes.smallDefault,,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       Icons.delete,
//                       color: Colors.red,
//                     ),
//                     onPressed: () {
//                       final UserProfileController _controller =
//                           UserProfileController();
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text('Delete Food'),
//                             content:
//                                 Text('Are you sure you want to delete food?'),
//                             actions: <Widget>[
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop(); // Close dialog
//                                 },
//                                 child: Text('Cancel'),
//                               ),
//                               TextButton(
//                                 onPressed: () async {
//                                   await _controller.deleteDish(foodid);

//                                   // Perform delete operation here
//                                   // For demonstration, just debugPrint a message
//                                   debugPrint('Food deleted!');
//                                   Navigator.of(context).pop(); // Close dialog
//                                   Navigator.pushNamed(context, '/root');
//                                 },
//                                 child: Text('Delete'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(width: 12.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class OptionsForFoodTable extends StatelessWidget {
  final String imagePath; // Path to the PNG image
  final String text;
  final Function f;

  const OptionsForFoodTable(
      {Key? key, required this.imagePath, required this.text, required this.f})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            f();
          },
          child: Container(
            width: 72,
            height: 71,
            decoration: ShapeDecoration(
              color: ThemeManager.themelightColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipOval(
              child: Container(
                width: 42,
                height: 41,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ThemeManager
                      .themelightColor, // Set the background color for the circular container
                ),
                child: Center(
                  child: Image.asset(
                    imagePath,
                    width: 24, // Adjust the width of the image
                    height: 24, // Adjust the height of the image
                    color: ThemeManager.themeText,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 90,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomGradientWidgettotal extends StatelessWidget {
  final String imageAsset;
  final String value;

  const CustomGradientWidgettotal({super.key, required this.imageAsset, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFAAD5E5),
          // color: Color.fromARGB(255, 168, 215, 253),
          // gradient: LinearGradient(
          //   colors: [
          //     TColor.primaryColor2.withOpacity(0.2),
          //     TColor.primaryColor1.withOpacity(0.2),
          //   ],
          // ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imageAsset,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value,
                  style: TextStyle(
                      color: ThemeManager.themeText,
                      fontSize: AppFontSizes.smallDefault,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
