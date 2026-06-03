import 'dart:convert';
import 'dart:io';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Classes/Food%20Classes/foodtableingredient.dart';
import 'package:http/http.dart' as http;
import 'package:nin2byo2i/Classes/earclassforuser.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';

import 'package:intl/intl.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';

import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';

import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/AddDishScreen.dart';

import 'package:nin2byo2i/view/SuggestionComponents/BmiSuggestion.dart';
import 'package:nin2byo2i/view/SuggestionComponents/CarbIntakeResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/DDSResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/FatIntakeResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/ProteinIntakeResultContainer%20.dart';
import 'package:nin2byo2i/view/SuggestionComponents/RefinedSugarIntakeResultContainer.dart';
import 'package:nin2byo2i/view/SuggestionComponents/SaltIntakeResultContainer.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';

//food diary page
class IngredientQuantityPage extends StatefulWidget {
  const IngredientQuantityPage({super.key});

  @override
  State<IngredientQuantityPage> createState() => _IngredientQuantityPageState();
}

class _IngredientQuantityPageState extends State<IngredientQuantityPage> {
  final UserProfileController _controller = UserProfileController();
  bool isLoadingScreenCheck = true;
  String selectedOption = "Full Day";
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
  late String currentDate;
  late String currentDate2;
  List<Meal> mealsFood = [];
  DateTime? selectedStartDate; // Define selectedStartDate
  DateTime? selectedEndDate; // D
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    currentDate = getCurrentDate();
    currentDate2 = getCurrentDate();
    fetchMeals();
    loadEarValues();
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

  String convertDateFormat(String date) {
    List<String> parts = date.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

    String monthName = DateFormat('MMMM').format(DateTime(year, month, day));
    String formattedDate = "$day $monthName $year";
    debugPrint("Fdsgdsgfdhdh $formattedDate");
    return formattedDate;
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  Future<List<Meal>> fetchMeals() async {
    setState(() {
      isLoadingScreenCheck = true;
    });
    mealsFood = [];
    try {
      List<Meal> meals =
          await _controller.festchmealtabelCustom(currentDate, currentDate2);
      setState(() {
        isLoadingScreenCheck = false;
        mealsFood = meals;
      });
      return meals;
    } catch (e) {
      debugPrint("gfdhfgjfgjghjkghkghk");
      // _scaffoldKey.currentState?.showSnackBar(SnackBar(
      //     duration: Duration(milliseconds: 1500),
      //     content: Text('Error fetching meals: $e')));
      rethrow;
    }
  }

  DateTime? selectedDate;
  final String _selectedOption = 'Today';
  void updateDateRange(String selectedOption) {
    DateTime now = DateTime.now();
    switch (selectedOption) {
      case 'Today':
        setState(() {
          currentDate = getCurrentDate();
          currentDate2 = getCurrentDate();
          fetchMeals();
        });
        break;
      case 'Week':
        DateTime sevenDaysAgo = now.subtract(const Duration(days: 6));
        setState(() {
          currentDate =
              "${sevenDaysAgo.year}-${_formatNumber(sevenDaysAgo.month)}-${_formatNumber(sevenDaysAgo.day)}";
          currentDate2 = getCurrentDate();
          fetchMeals();
        });
        break;
      case 'Month':
        DateTime thirtyOneDaysAgo = now.subtract(const Duration(days: 30));
        setState(() {
          currentDate =
              "${thirtyOneDaysAgo.year}-${_formatNumber(thirtyOneDaysAgo.month)}-${_formatNumber(thirtyOneDaysAgo.day)}";
          currentDate2 = getCurrentDate();
          fetchMeals();
        });
        break;
      default:
        break;
    }
  }

  Future<void> _refresh() async {
    await fetchMeals();
    setState(() {});
  }

  Future<void> _generateAndSaveCSVFile() async {
    try {
      final userProfileController =
          Provider.of<UserProfileController>(context, listen: false);
      final userProfile = userProfileController.userProfile;
      final userName =
          '${userProfile?.firstName ?? ""} ${userProfile?.lastName ?? ""}';

      // Get the directory for saving files
      // final directory = await DownloadsPathProvider.downloadsDirectory;
      final directory = await getApplicationDocumentsDirectory();
      // Define the file path
      String filePath =
          '${directory.path}/dietary_diary_repor_${currentDate}_to_$currentDate2.csv';

      // Create a CSV file
      File file = File(filePath);

      // Create CSV content
      String csvContent = '';

      csvContent += 'Diet Diary\n';
      csvContent += 'Start Date:,${convertDateFormat(currentDate)}\n';
      csvContent += 'End Date:,${convertDateFormat(currentDate2)}\n\n';
      csvContent += 'Name:,$userName\n';
      csvContent += 'Email:,${userProfile?.email}\n';
      csvContent += 'Age:,${userProfile?.age} years\n';
      csvContent += 'Gender:,${userProfile?.gender}\n';
      csvContent += 'bmi:,${userProfile?.bmi} \n';

      csvContent += '\n'; // Add empty row for spacing

      // Adding header row

      // Adding data rows for each date
      for (var meal in mealsFood) {
        csvContent += '\n\n Date : ${convertDateFormat(meal.date)}\n';
        csvContent += 'Nutrient,Value,EAR\n';
        csvContent +=
            'Calories (Kcal),${meal.totalmealCalories.toStringAsFixed(1)},${_profileFuture.energy}\n';
        csvContent +=
            'Protein (g),${meal.mealProteins.toStringAsFixed(1)},${_profileFuture.protein}\n';
        csvContent +=
            'Carbs (g),${meal.mealCarbs.toStringAsFixed(1)},${_profileFuture.carbohydrate}\n';
        csvContent +=
            'Fat (g),${meal.mealFats.toStringAsFixed(1)},${_profileFuture.fatsOilsVisible}\n';
        csvContent +=
            'Fibers (g),${meal.mealFibers.toStringAsFixed(1)},${_profileFuture.fiber}\n';
        csvContent +=
            'Calcium (mg),${meal.mealCalcium.toStringAsFixed(1)},${_profileFuture.calcium}\n';
        csvContent +=
            'Iron (mg),${meal.mealIron.toStringAsFixed(1)},${_profileFuture.iron}\n';
        csvContent +=
            'Zinc (mg),${meal.mealZinc.toStringAsFixed(1)},${_profileFuture.zinc}\n';
        csvContent +=
            'Magnesium (mg),${meal.mealMagnesium.toStringAsFixed(1)},${_profileFuture.magnesium}\n';
        csvContent +=
            'Thiamine (B1) (mg),${meal.mealThiamineB1.toStringAsFixed(1)},${_profileFuture.thiamine}\n';
        csvContent +=
            'Riboflavin (B2) (mg),${meal.mealRiboflavinB2.toStringAsFixed(1)},${_profileFuture.riboflavin}\n';
        csvContent +=
            'Niacin (B3) (mg),${meal.mealNiacinB3.toStringAsFixed(1)},${_profileFuture.niacin}\n';
        csvContent +=
            'Folates (B9) (mcg),${meal.mealFolatesB9.toStringAsFixed(1)},${_profileFuture.folate}\n';
        csvContent +=
            'Retinol (Vitamin A) (mcg),${meal.mealRetinolVitA.toStringAsFixed(1)},${_profileFuture.vitA}\n';
      }

      // Write content to the file
      await file.writeAsString(csvContent);

      // Show an alert dialog indicating that the file has been saved
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(Languages.of(context)!.NINTextSuccess),
            content: Text(
                '${Languages.of(context)!.NINTextDietaryDiaryReportSavedTo} $filePath'),
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

  //TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final userProfileController = Provider.of<UserProfileController>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        // Do nothing when the back button is pressed

        return true;
      },
      child: MaterialApp(
        home: Scaffold(
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
              Languages.of(context)!.ninTextMyNutrientIntakeToday,
              style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.w700),
            ),
          ),
          backgroundColor: ThemeManager.themeColor,
          body: isLoadingScreenCheck
              ? const CommonDataLoadingScreen()
              : Center(
                  child: RefreshIndicator(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Text("${mealsFood[0].totalmealCalories.toString()}"),
                                for (int i = 0; i < mealsFood.length; i++)
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF007BC1),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              Languages.of(context)!
                                                  .ninTextMyNutrientIntakeToday,
                                              style: const TextStyle(
                                                  fontSize: AppFontSizes
                                                      .mediumDefault,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: media.width * 0.9,
                                          decoration: BoxDecoration(
                                            color: TColor.primaryColor2
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                sizedBox12(),
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           left: 8.0,
                                                //           right: 8.0),
                                                //   child: Container(
                                                //     height: 40,
                                                //     padding:
                                                //         EdgeInsets.symmetric(
                                                //             vertical: 5.0),
                                                //     decoration: BoxDecoration(
                                                //       // border: Border.all(
                                                //       //   color: TColor.primaryColor1,
                                                //       //   width: 2,
                                                //       // ),
                                                //       color: Color.fromARGB(
                                                //           255, 34, 104, 161),
                                                //     ),
                                                //     child: Padding(
                                                //       padding: EdgeInsets.only(
                                                //           left: 5.0),
                                                //       child: Row(
                                                //         mainAxisAlignment:
                                                //             MainAxisAlignment
                                                //                 .start,
                                                //         children: [
                                                //           Container(
                                                //             width: 147,
                                                //             child: Padding(
                                                //               padding: EdgeInsets
                                                //                   .only(
                                                //                       left:
                                                //                           5.0),
                                                //               child: Text(
                                                //                 Languages.of(
                                                //                         context)!
                                                //                     .NINTextNutrient,
                                                //                 style: TextStyle(
                                                //                     color: Colors
                                                //                         .white),
                                                //               ),
                                                //             ),
                                                //           ),
                                                //           Container(
                                                //             width: 147,
                                                //             child: Text(
                                                //                 textAlign:
                                                //                     TextAlign
                                                //                         .center,
                                                //                 "${Languages.of(context)!.NINTextValue}",
                                                //                 style: TextStyle(
                                                //                     color: Colors
                                                //                         .white)),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          // bottom: 8.0,
                                                          left: 8.0,
                                                          right: 8.0),
                                                  child: Container(
                                                    height: 40,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            vertical: 5.0),
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255,
                                                          34,
                                                          104,
                                                          161), // Use the provided color
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                147, // Adjust the width according to your needs
                                                            child: Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .NINTextNutrient,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                147, // Adjust the width according to your needs
                                                            child: Text(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                Languages.of(context)!.NINTextValue,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        ],
                                                      ),
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
                                                            mealsFood[i].totalmealCalories.toStringAsFixed(mealsFood[i].totalmealCalories >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.energy.toStringAsFixed(_profileFuture.energy >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
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
                                                            mealsFood[i].mealProteins.toStringAsFixed(mealsFood[i].mealProteins >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.protein.toStringAsFixed(_profileFuture.protein >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
                                                                .mealProteins *
                                                            100 /
                                                            (_profileFuture
                                                                        .protein ==
                                                                    0
                                                                ? 1
                                                                : _profileFuture
                                                                    .protein),
                                                      ),
                                                      customtablerow(
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
                                                            mealsFood[i].mealFats.toStringAsFixed(mealsFood[i].mealFats >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.fatsOilsVisible.toStringAsFixed(_profileFuture.fatsOilsVisible >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
                                                                .mealFats *
                                                            100 /
                                                            (_profileFuture
                                                                        .fatsOilsVisible ==
                                                                    0
                                                                ? 1
                                                                : _profileFuture
                                                                    .fatsOilsVisible),
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
                                                            mealsFood[i].mealCarbs.toStringAsFixed(mealsFood[i].mealCarbs >= 99 ? 0 : 2),
                                                        earValue:
                                                            '${_profileFuture.carbohydrate.toStringAsFixed(_profileFuture.carbohydrate >= 99 ? 0 : 2)} *',
                                                        percentage: mealsFood[i]
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
                                                            mealsFood[i].mealCalcium.toStringAsFixed(mealsFood[i].mealCalcium >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.calcium.toStringAsFixed(_profileFuture.calcium >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
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
                                                            mealsFood[i].mealFibers.toStringAsFixed(mealsFood[i].mealFibers >= 99 ? 0 : 2),
                                                        earValue:
                                                            '${_profileFuture.fiber.toStringAsFixed(_profileFuture.fiber >= 99 ? 0 : 2)} **',
                                                        percentage: mealsFood[i]
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
                                                            mealsFood[i].mealIron.toStringAsFixed(mealsFood[i].mealIron >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.iron.toStringAsFixed(_profileFuture.iron >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
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
                                                            mealsFood[i].mealZinc.toStringAsFixed(mealsFood[i].mealZinc >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.zinc.toStringAsFixed(_profileFuture.zinc >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
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
                                                            mealsFood[i].mealMagnesium.toStringAsFixed(mealsFood[i].mealMagnesium >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.magnesium.toStringAsFixed(_profileFuture.magnesium >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
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
                                                            mealsFood[i].mealThiamineB1.toStringAsFixed(mealsFood[i].mealThiamineB1 >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.thiamine.toStringAsFixed(_profileFuture.thiamine >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
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
                                                            mealsFood[i].mealRiboflavinB2.toStringAsFixed(mealsFood[i].mealRiboflavinB2 >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.riboflavin.toStringAsFixed(_profileFuture.riboflavin >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
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
                                                            mealsFood[i].mealNiacinB3.toStringAsFixed(mealsFood[i].mealNiacinB3 >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.niacin.toStringAsFixed(_profileFuture.niacin >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
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
                                                            mealsFood[i].mealFolatesB9.toStringAsFixed(mealsFood[i].mealFolatesB9 >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.folate.toStringAsFixed(_profileFuture.folate >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
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
                                                            mealsFood[i].mealRetinolVitA.toStringAsFixed(mealsFood[i].mealRetinolVitA >= 99 ? 0 : 2),
                                                        earValue:
                                                            _profileFuture.vitA.toStringAsFixed(_profileFuture.vitA >= 99 ? 0 : 2),
                                                        percentage: mealsFood[i]
                                                                .mealRetinolVitA *
                                                            100 /
                                                            (_profileFuture
                                                                        .vitA ==
                                                                    0
                                                                ? 1
                                                                : _profileFuture
                                                                    .vitA),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                sizedBox12(),
                                // Container(
                                //   height: 50,
                                //   width: media.width * 0.95,
                                //   decoration: BoxDecoration(
                                //     border: Border.all(),
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(
                                //         10.0), // Adjust the radius as needed
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.grey.withOpacity(0.5),
                                //         spreadRadius: 2,
                                //         blurRadius: 5,
                                //         offset: Offset(
                                //             0, 3), // changes position of shadow
                                //       ),
                                //     ],
                                //   ),
                                //   child: InkWell(
                                //     onTap: _generateAndSaveCSVFile,
                                //     child: Center(
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.center,
                                //         children: [
                                //           Text(
                                //             Languages.of(context)!
                                //                 .TextAppDownloadFile,
                                //             style: TextStyle(
                                //                 color: ThemeManager.themeText,
                                //                 fontWeight: FontWeight.w700,
                                //                 fontSize: AppFontSizes.mediumDefault),
                                //           ),
                                //           Icon(Icons.download)
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                //  sizedBox30(),

                                sizedBox30()
                              ],
                            ),
                          )),
                          // Container(
                          //   height: 50,
                          //   width: 100,
                          //   decoration: BoxDecoration(
                          //     color: TColor.primaryColor1,
                          //     borderRadius: BorderRadius.circular(
                          //         10.0), // Adjust the radius as needed
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey.withOpacity(0.5),
                          //         spreadRadius: 2,
                          //         blurRadius: 5,
                          //         offset:
                          //             Offset(0, 3), // changes position of shadow
                          //       ),
                          //     ],
                          //   ),
                          //   child: InkWell(
                          //     onTap: _generateAndSaveWordDocument,
                          //     child: Center(
                          //       child: Text(
                          //         'Download Word File',
                          //         style: TextStyle(
                          //           color: ThemeManager.themeText,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _generateAndSaveWordDocument,
          //   backgroundColor: TColor.primaryColor1,
          //   elevation: 5, // Adjust elevation as needed
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(
          //         0.0), // Set radius to 0 for square shape
          //   ),
          //   child: Text(
          //     'Download Word File',
          //     style: TextStyle(
          //       color: ThemeManager.themeText,
          //     ),
          //   ),
          // ),
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
    var media = MediaQuery.of(context).size;
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: color, // Use the provided color
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 147, // Adjust the width according to your needs
              child: Text(ingredientName),
            ),
            SizedBox(
              width: 147, // Adjust the width according to your needs
              child: Text(textAlign: TextAlign.center, ingredientValue),
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
//                   //       fontSize: AppFontSizes

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
//                       fontSize: AppFontSizes

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
    var media = MediaQuery.of(context).size;
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
              child: Text(
                value,
                style: TextStyle(
                    color: ThemeManager.themeText,
                    fontSize: AppFontSizes.smallDefault,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
