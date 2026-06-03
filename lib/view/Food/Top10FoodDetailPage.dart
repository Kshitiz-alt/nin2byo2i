import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/constants/server.dart';

// top 10 food detail page for individual food
class Top10FoodDetailsScreen extends StatefulWidget {
  final int foodId;

  const Top10FoodDetailsScreen({super.key, required this.foodId});

  @override
  _Top10FoodDetailsScreenState createState() => _Top10FoodDetailsScreenState();
}

class _Top10FoodDetailsScreenState extends State<Top10FoodDetailsScreen> {
  late Future<Map<String, dynamic>> foodDetails;
  final UserProfileController controller = UserProfileController();
  bool isLoadingScreenCheck = true;
  @override
  void initState() {
    super.initState();
    initialLoad();
  }

  initialLoad() {
    setState(() {
      isLoadingScreenCheck = false;
    });
    foodDetails = controller.fetchFoodDetailsFromApi(widget.foodId).then(
        (List<Map<String, dynamic>> foodList) =>
            foodList.isNotEmpty ? foodList[0] : {});
    debugPrint("Food Details: $foodDetails");
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingScreenCheck
        ? const CommonDataLoadingScreen()
        : FutureBuilder<Map<String, dynamic>>(
            future: foodDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    color: ThemeManager.themeColor,
                    child: const Column(
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    ));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                Map<String, dynamic> foodItem = snapshot.data!;
                debugPrint("Food Item: $foodItem");
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
                      "${foodItem['name']}",
                      style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.mediumDefault,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  backgroundColor: ThemeManager.themeColor,
                  body: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 300,
                            child: Image.network(
                              "${API.server}/images/${foodItem['foodCode']}.PNG",
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  // Image is fully loaded
                                  return child;
                                } else {
                                  // Image is still loading
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                // Error occurred while loading image
                                return SizedBox(
                                  width: 300,
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

                      // buildRow(
                      //   Languages.of(context)!.Foodprotein,
                      //   '${foodItem['protein'].toStringAsFixed(foodItem['protein'] >= 99 ? 0 : 2)} g',
                      //   Icons.accessibility,
                      //   TColor.primaryColor1.withOpacity(0.2),
                      // ),
                      // buildRow(
                      //   Languages.of(context)!.FoodtotalFat,
                      //   '${foodItem['total_Fat'].toStringAsFixed(foodItem['total_Fat'] >= 99 ? 0 : 2)} g',
                      //   Icons.accessibility,
                      //   Colors.white,
                      // ),
                      // buildRow(
                      //   Languages.of(context)!.Foodenergy,
                      //   '${foodItem['energy'].toStringAsFixed(foodItem['energy'] >= 99 ? 0 : 2)} kcal',
                      //   Icons.accessibility,
                      //   TColor.primaryColor1.withOpacity(0.2),
                      // ),
                      // buildRow(
                      //   Languages.of(context)!.Foodcarbohydrate,
                      //   '${foodItem['carbohydrate'].toStringAsFixed(foodItem['carbohydrate'] >= 99 ? 0 : 2)} g',
                      //   Icons.accessibility,
                      //   Colors.white,
                      // ),
                      Column(
                        children: [
                          buildSection(
                              Languages.of(context)!.FoodproximateComposition, [
                            buildRow(
                              Languages.of(context)!.Foodprotein,
                              '${foodItem['protein'].toStringAsFixed(foodItem['protein'] >= 99 ? 0 : 2)} g',
                              Icons.accessibility,
                              TColor.primaryColor1.withOpacity(0.2),
                            ),
                            buildRow(
                              Languages.of(context)!.FoodtotalFat,
                              '${foodItem['total_Fat'].toStringAsFixed(foodItem['total_Fat'] >= 99 ? 0 : 2)} g',
                              Icons.accessibility,
                              Colors.white,
                            ),
                            buildRow(
                              Languages.of(context)!.FoodtotalDietaryFiber,
                              '${foodItem['total_Dietary_Fibre'].toStringAsFixed(foodItem['total_Dietary_Fibre'] >= 99 ? 0 : 2)} g',
                              Icons.accessibility,
                              TColor.primaryColor1.withOpacity(0.2),
                            ),
                            buildRow(
                              Languages.of(context)!.Foodcarbohydrate,
                              '${foodItem['carbohydrate'].toStringAsFixed(foodItem['carbohydrate'] >= 99 ? 0 : 2)} g',
                              Icons.accessibility,
                              Colors.white,
                            ),
                            buildRow(
                              Languages.of(context)!.Foodenergy,
                              '${foodItem['energy'].toStringAsFixed(foodItem['energy'] >= 99 ? 0 : 2)} Kcal',
                              Icons.accessibility,
                              TColor.primaryColor1.withOpacity(0.2),
                            ),
                          ]),
                          const SizedBox(height: 16),
                          buildSection(Languages.of(context)!.Foodvitamins, [
                            buildRow(
                              Languages.of(context)!.labelRiboflavinB2,
                              '${foodItem['riboflavin_B2'].toStringAsFixed(foodItem['riboflavin_B2'] >= 99 ? 0 : 2)} mg',
                              Icons.accessibility,
                              Colors.white,
                            ),
                            buildRow(
                              Languages.of(context)!.FoodtotalB6,
                              '${foodItem['vitb6'].toStringAsFixed(foodItem['vitb6'] >= 99 ? 0 : 2)} mg',
                              Icons.accessibility,
                              TColor.primaryColor1.withOpacity(0.2),
                            ),
                            buildRow(
                              Languages.of(context)!.FoodtotalB9,
                              '${foodItem['folates_B9'].toStringAsFixed(foodItem['folates_B9'] >= 99 ? 0 : 2)} µg',
                              Icons.accessibility,
                              Colors.white,
                            ),
                            buildRow(
                              Languages.of(context)!.labelVitaminC,
                              '${foodItem['vitc'].toStringAsFixed(foodItem['vitc'] >= 99 ? 0 : 2)} mg',
                              Icons.accessibility,
                              TColor.primaryColor1.withOpacity(0.2),
                            ),
                            buildRow(
                                Languages.of(context)!.labelThiamineB1,
                                '${foodItem['thiamine_B1'].toStringAsFixed(foodItem['thiamine_B1'] >= 99 ? 0 : 2)} mg',
                                Icons.accessibility,
                                Colors.white),
                            buildRow(
                              Languages.of(context)!.labelRetinolVitA,
                              '${foodItem['retinolVit_A'].toStringAsFixed(foodItem['retinolVit_A'] >= 99 ? 0 : 2)} µg',
                              Icons.accessibility,
                              TColor.primaryColor1.withOpacity(0.2),
                            ),
                            buildRow(
                                Languages.of(context)!.labelNiacinB3,
                                '${foodItem['niacin_B3'].toStringAsFixed(foodItem['niacin_B3'] >= 99 ? 0 : 2)} mg',
                                Icons.accessibility,
                                Colors.white),
                          ]),
                          const SizedBox(height: 16),
                          buildSection(Languages.of(context)!.Foodminerals, [
                            buildRow(
                              Languages.of(context)!.Foodiron,
                              '${foodItem['iron'].toStringAsFixed(foodItem['iron'] >= 99 ? 0 : 2)} mg',
                              Icons.accessibility,
                              TColor.primaryColor1.withOpacity(0.2),
                            ),
                            buildRow(
                                Languages.of(context)!.Foodzinc,
                                '${foodItem['zinc'].toStringAsFixed(foodItem['zinc'] >= 99 ? 0 : 2)} mg',
                                Icons.accessibility,
                                Colors.white),
                            buildRow(
                              Languages.of(context)!.Foodcalcium,
                              '${foodItem['calcium'].toStringAsFixed(foodItem['calcium'] >= 99 ? 0 : 2)} mg',
                              Icons.accessibility,
                              TColor.primaryColor1.withOpacity(0.2),
                            ),
                            buildRow(
                                Languages.of(context)!.Foodsodium,
                                '${foodItem['sodium'].toStringAsFixed(foodItem['sodium'] >= 99 ? 0 : 2)} mg',
                                Icons.accessibility,
                                Colors.white),
                            buildRow(
                              Languages.of(context)!.Foodmagnesium,
                              '${foodItem['magnesium'].toStringAsFixed(foodItem['magnesium'] >= 99 ? 0 : 2)} mg',
                              Icons.accessibility,
                              TColor.primaryColor1.withOpacity(0.2),
                            ),
                          ]),
                          // buildSection(
                          //     Languages.of(context)!.FoodproximateComposition,
                          //     []),

                          // buildRow(
                          //   Languages.of(context)!.Foodcalcium,
                          //   '${foodItem['calcium'].toStringAsFixed(foodItem['calcium'] >= 99 ? 0 : 2)} mg',
                          //   Icons.accessibility,
                          //   TColor.primaryColor1.withOpacity(0.2),
                          // ),

                          // buildRow(
                          //   Languages.of(context)!.Foodcategory,
                          //   '${foodItem['category']}',
                          //   Icons.accessibility,
                          //   TColor.primaryColor1.withOpacity(0.2),
                          // ),
                        ],
                      ),

                      //                       buildRow(
                      //                         Languages.of(context)!.Foodcalcium,
                      //                         '${foodItem['calcium'].toStringAsFixed(foodItem['calcium'] >= 99 ? 0 : 2)} mg',
                      //                         Icons.accessibility,
                      //                         Colors.white,
                      //                       ),
                      //                       buildRow(
                      //                         Languages.of(context)!.Foodiron,
                      //                         '${foodItem['iron'].toStringAsFixed(foodItem['iron'] >= 99 ? 0 : 2)} mg',
                      //                         Icons.accessibility,
                      //                         TColor.primaryColor1.withOpacity(0.2),
                      //                       ),
                      // //
                      //                       buildRow(
                      //                         Languages.of(context)!.Foodiron,
                      //                         '${foodItem['retinolVit_A'].toStringAsFixed(foodItem['retinolVit_A'] >= 99 ? 0 : 2)} IU',
                      //                         Icons.accessibility,
                      //                         Colors.white,
                      //                       ),
                      //                       buildRow(
                      //                         Languages.of(context)!.Foodiron,
                      //                         '${foodItem['folates_B9'].toStringAsFixed(foodItem['folates_B9'] >= 99 ? 0 : 2)} mcg',
                      //                         Icons.accessibility,
                      //                         TColor.primaryColor1.withOpacity(0.2),
                      //                       ),
                      //                       buildRow(
                      //                         Languages.of(context)!.Foodiron,
                      //                         '${foodItem['niacin_B3'].toStringAsFixed(foodItem['niacin_B3'] >= 99 ? 0 : 2)} mg',
                      //                         Icons.accessibility,
                      //                         Colors.white,
                      //                       ),
                      //                       buildRow(
                      //                         Languages.of(context)!.Foodiron,
                      //                         '${foodItem['riboflavin_B2'].toStringAsFixed(foodItem['riboflavin_B2'] >= 99 ? 0 : 2)} mg',
                      //                         Icons.accessibility,
                      //                         TColor.primaryColor1.withOpacity(0.2),
                      //                       ),
                      //                       buildRow(
                      //                         Languages.of(context)!.Foodiron,
                      //                         '${foodItem['thiamine_B1'].toStringAsFixed(foodItem['thiamine_B1'] >= 99 ? 0 : 2)} mg',
                      //                         Icons.accessibility,
                      //                         Colors.white,
                      //                       ),

                      //                       buildRow(
                      //                         Languages.of(context)!.Foodmagnesium,
                      //                         '${foodItem['magnesium'].toStringAsFixed(foodItem['magnesium'] >= 99 ? 0 : 2)} mg',
                      //                         Icons.accessibility,
                      //                         TColor.primaryColor1.withOpacity(0.2),
                      //                       ),
                      //                       buildRow(
                      //                         Languages.of(context)!.Foodzinc,
                      //                         '${foodItem['zinc'].toStringAsFixed(foodItem['zinc'] >= 99 ? 0 : 2)} mg',
                      //                         Icons.accessibility,
                      //                         Colors.white,
                      //                       ),

                      //                       buildRow(
                      //                         Languages.of(context)!.FoodtotalDietaryFiber,
                      //                         '${foodItem['total_Dietary_Fibre'].toStringAsFixed(foodItem['total_Dietary_Fibre'] >= 99 ? 0 : 2)} g',
                      //                         Icons.accessibility,
                      //                         TColor.primaryColor1.withOpacity(0.2),
                      //                       ),

                      // Add other rows as needed
                    ],
                  ),
                );
              }
            },
          );
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
