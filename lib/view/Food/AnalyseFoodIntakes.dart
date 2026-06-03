import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nin2byo2i/Classes/Food%20Classes/analysefoodintake.dart';
import 'package:nin2byo2i/Classes/earclassforuser.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/EditDailyNutritionTarget.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

//analyse food intake screen
class AnalyseFoodIntakes extends StatefulWidget {
  const AnalyseFoodIntakes({super.key});

  @override
  _AnalyseFoodIntakesState createState() => _AnalyseFoodIntakesState();
}

class _AnalyseFoodIntakesState extends State<AnalyseFoodIntakes> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadEarValues();
  }

  Map<String, double> consumedPercentages = {};
  Future<void> loadEarValues() async {
    _profileFuture = (await _controller.getProfileEar());
    setState(() {});
  }

  final UserProfileController _controller = UserProfileController();
  EarForUser _profileFuture = EarForUser.fromJson({
    'gender': 'Male',
    'age': '30',
    'group': 'Adults',
    'workLevel': 'Moderate',
    'energy': 0,
    'protein': 0.0,
    'fatsOilsVisible': 0.0,
    'fiber': 0.0,
    'calcium': 0.0,
    'magnesium': 0.0,
    'iron': 0.0,
    'zinc': 0.0,
    'thiamine': 0.0,
    'riboflavin': 0.0,
    'niacin': 0.0,
    'folate': 0.0,
    'vitA': 0.0,
    'iodine': 0.0,
    'vitB12': 0.0,
    'vitC': 0.0,
    'carbohydrate': 0.0,
  });
  @override
  Widget build(BuildContext context) {
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
          Languages.of(context)!.labelAnalyseIngredientsTaken,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {},
        //     child: Container(
        //       margin: const EdgeInsets.all(8),
        //       height: 40,
        //       width: 40,
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //           color: ThemeManager.themelightColor,
        //           borderRadius: BorderRadius.circular(10)),
        //       child: Image.asset(
        //         "assets/img/more_btn.png",
        //         color: ThemeManager.themeText,
        //         width: 15,
        //         height: 15,
        //         fit: BoxFit.contain,
        //       ),
        //     ),
        //   )
        // ],
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _controller.Analysefoodintake(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              var data = snapshot.data as List<dynamic>;
              var apiData = data[0] as Ingredientstaken;
              var uiData = data[1] as Ingredientsleft;

              consumedPercentages['Calories'] = (apiData.takenCalories! /
                  (_profileFuture.energy == 0 ? 1 : _profileFuture.energy));
              consumedPercentages['Protein'] = apiData.takenProteins! /
                  (_profileFuture.protein == 0 ? 1 : _profileFuture.protein);
              consumedPercentages['Fat'] = apiData.takenFats! /
                  (_profileFuture.fatsOilsVisible == 0
                      ? 1
                      : _profileFuture.fatsOilsVisible);
              consumedPercentages['Carbohydrates'] = apiData.takenCarbs! /
                  (_profileFuture.carbohydrate == 0
                      ? 1
                      : _profileFuture.carbohydrate);
              consumedPercentages['Calcium'] = apiData.takenCalcium! /
                  (_profileFuture.calcium == 0 ? 1 : _profileFuture.calcium);
              consumedPercentages['Fiber'] = apiData.takenFibers! /
                  (_profileFuture.fiber == 0 ? 1 : _profileFuture.fiber);
              consumedPercentages['Iron'] = apiData.takenIron! /
                  (_profileFuture.iron == 0 ? 1 : _profileFuture.iron);
              consumedPercentages['Zinc'] = apiData.takenZinc! /
                  (_profileFuture.zinc == 0 ? 1 : _profileFuture.zinc);
              consumedPercentages['Magnesium'] = apiData.takenMagnesium! /
                  (_profileFuture.magnesium == 0
                      ? 1
                      : _profileFuture.magnesium);
              consumedPercentages['Thiamine (B1)'] = apiData.takenThiamineB1! /
                  (_profileFuture.thiamine == 0 ? 1 : _profileFuture.thiamine);
              consumedPercentages['Riboflavin (B2)'] =
                  apiData.takenRiboflavinB2! /
                      (_profileFuture.riboflavin == 0
                          ? 1
                          : _profileFuture.riboflavin);
              consumedPercentages['Niacin (B3)'] = apiData.takenNiacinB3! /
                  (_profileFuture.niacin == 0 ? 1 : _profileFuture.niacin);
              consumedPercentages['Folates (B9)'] = apiData.takenFolatesB9! /
                  (_profileFuture.folate == 0 ? 1 : _profileFuture.folate);
              consumedPercentages['Retinol (Vit A)'] =
                  apiData.takenRetinolVitA! /
                      (_profileFuture.vitA == 0 ? 1 : _profileFuture.vitA);
              debugPrint("dfbgfjghmkhgjmj $consumedPercentages");
              // Cap values at 1 if they exceed it
              // consumedPercentages.entries.forEach((entry) {
              //   if (entry.value > 1) {
              //     consumedPercentages[entry.key] = 1;
              //   }
              // });

              String message =
                  "${Languages.of(context)!.labelTodaysNutritionSummary}:\n\n"
                  "🔵 ${Languages.of(context)!.labelFibers}: ${apiData.takenFibers?.toStringAsFixed(2)}  g\n"
                  "🟢 ${Languages.of(context)!.labelFats}: ${apiData.takenFats?.toStringAsFixed(2)}  g\n"
                  "🟠 ${Languages.of(context)!.labelCarbs}: ${apiData.takenCarbs?.toStringAsFixed(2)}  g\n"
                  "🔴 ${Languages.of(context)!.labelProteins}: ${apiData.takenProteins?.toStringAsFixed(2)}  g\n"
                  "🟤 ${Languages.of(context)!.labelCaloriestaken}: ${apiData.takenCalories?.toStringAsFixed(2)} Kcal\n"
                  "🟣 ${Languages.of(context)!.labelCalcium}: ${apiData.takenCalcium?.toStringAsFixed(2)} mg\n"
                  "🟡 ${Languages.of(context)!.labelNiacinB3}: ${apiData.takenNiacinB3?.toStringAsFixed(2)} mg\n"
                  "🟠 ${Languages.of(context)!.labelThiamineB1}: ${apiData.takenThiamineB1?.toStringAsFixed(2)} mg\n"
                  "🔴 ${Languages.of(context)!.labelIron}: ${apiData.takenIron?.toStringAsFixed(2)} mg\n"
                  "🟤 ${Languages.of(context)!.labelZinc}: ${apiData.takenZinc?.toStringAsFixed(2)} mg\n"
                  "🔵 ${Languages.of(context)!.labelFolatesB9}: ${apiData.takenFolatesB9?.toStringAsFixed(2)} mcg\n"
                  "🟢 ${Languages.of(context)!.labelRiboflavinB2}: ${apiData.takenRiboflavinB2?.toStringAsFixed(2)} mg\n"
                  "🟠 ${Languages.of(context)!.labelRetinolVitA}: ${apiData.takenRetinolVitA?.toStringAsFixed(2)} IU\n"
                  "🔴 ${Languages.of(context)!.labelMagnesium}: ${apiData.takenMagnesium?.toStringAsFixed(2)} mg";

              // String message =
              //     "${Languages.of(context)!.labelTodaysNutritionSummary}:\n\n"
              //     "🔵 ${Languages.of(context)!.labelFibers}: ${apiData.takenFibers?.toStringAsFixed(2)}  g\n"
              //     "🟢 ${Languages.of(context)!.labelFats}: ${apiData.takenFats?.toStringAsFixed(2)}  g\n"
              //     "🟠 ${Languages.of(context)!.labelCarbs}: ${apiData.takenCarbs?.toStringAsFixed(2)}  g\n"
              //     "🔴 ${Languages.of(context)!.labelProteins}: ${apiData.takenProteins?.toStringAsFixed(2)}  g\n"
              //     "🟤 ${Languages.of(context)!.labelCaloriestaken}: ${apiData.takenCalories?.toStringAsFixed(2)} kcal\n"
              //     "🟣 Calcium ${apiData.takenCalcium?.toStringAsFixed(2)} mg\n"
              //     "🟡 NiacinB3 ${apiData.takenNiacinB3?.toStringAsFixed(2)} mg\n"
              //     "🟠 ThiamineB1${apiData.takenThiamineB1?.toStringAsFixed(2)} mg\n"
              //     "🔴 Iron ${apiData.takenIron?.toStringAsFixed(2)} mg\n"
              //     "🟤 Zinc ${apiData.takenZinc?.toStringAsFixed(2)} mg\n"
              //     "🔵 FolatesB9 ${apiData.takenFolatesB9?.toStringAsFixed(2)} mcg\n"
              //     "🟢 RiboflavinB2 ${apiData.takenRiboflavinB2?.toStringAsFixed(2)} mg\n"
              //     "🟠 RetinolVitA ${apiData.takenRetinolVitA?.toStringAsFixed(2)} IU\n"
              //     "🔴 Magnesium ${apiData.takenMagnesium?.toStringAsFixed(2)} mg";

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Center(
                  //   child: Text("Ingredients Taken In %",
                  //       style: TextStyle(
                  //           fontSize: AppFontSizes.mediumDefault.0,
                  //           fontWeight: FontWeight.bold,
                  //           color: ThemeManager.themeText)),
                  // ),
                  // Container(
                  //   height:
                  //       300, // Set a fixed height for the PieChart container
                  //   child: PieChart(
                  //     PieChartData(
                  //       sections: getChartData(uiData, apiData),
                  //     ),
                  //   ),
                  // ),

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent":
                                      consumedPercentages['Carbohydrates'],
                                  'name': Languages.of(context)!.labelCarbs,
                                  "value":
                                      '${apiData.takenCarbs?.toStringAsFixed(1) ?? 0} g',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent": consumedPercentages['Calories'],
                                  'name':
                                      Languages.of(context)!.labelCaloriestaken,
                                  "value":
                                      '${apiData.takenCalories?.toStringAsFixed(1) ?? 0} Kcal',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent": consumedPercentages['Fiber'],
                                  'name': Languages.of(context)!.labelFibers,
                                  "value":
                                      '${apiData.takenFibers?.toStringAsFixed(1)} g',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent": consumedPercentages['Fat'],
                                  'name': Languages.of(context)!.labelFats,
                                  "value":
                                      '${apiData.takenFats?.toStringAsFixed(1)} g',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent": consumedPercentages['Protein'],
                                  'name': Languages.of(context)!.labelProteins,
                                  "value":
                                      '${apiData.takenProteins?.toStringAsFixed(1) ?? 0} g',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent": consumedPercentages['Iron'],
                                  'name': Languages.of(context)!.labelIron,
                                  "value":
                                      '${apiData.takenIron?.toStringAsFixed(1) ?? 0} mg',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent": consumedPercentages['Niacin (B3)'],
                                  'name': Languages.of(context)!.labelNiacinB3,
                                  "value":
                                      '${apiData.takenNiacinB3?.toStringAsFixed(1) ?? 0} mg',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent":
                                      consumedPercentages['Thiamine (B1)'],
                                  'name':
                                      Languages.of(context)!.labelThiamineB1,
                                  "value":
                                      '${apiData.takenThiamineB1?.toStringAsFixed(1) ?? 0} mg',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent": consumedPercentages['Zinc'],
                                  'name': Languages.of(context)!.labelZinc,
                                  "value":
                                      '${apiData.takenZinc?.toStringAsFixed(1) ?? 0} mg',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent":
                                      consumedPercentages['Folates (B9)'],
                                  'name': Languages.of(context)!.labelFolatesB9,
                                  "value":
                                      '${apiData.takenFolatesB9?.toStringAsFixed(1) ?? 0} mcg',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent": consumedPercentages['Magnesium'],
                                  'name': Languages.of(context)!.labelMagnesium,
                                  "value":
                                      '${apiData.takenMagnesium?.toStringAsFixed(1) ?? 0} mg',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent":
                                      consumedPercentages['Riboflavin (B2)'],
                                  'name':
                                      Languages.of(context)!.labelRiboflavinB2,
                                  "value":
                                      '${apiData.takenRiboflavinB2?.toStringAsFixed(1) ?? 0} mg',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: media.width * 0.4,
                              child: CommonViewWidget(
                                fObj: {
                                  "percent":
                                      consumedPercentages['Retinol (Vit A)'],
                                  'name':
                                      Languages.of(context)!.labelRetinolVitA,
                                  "value":
                                      '${apiData.takenRetinolVitA?.toStringAsFixed(1) ?? 0} mcg',
                                  "image": "assets/img/Vector.svg",
                                },
                                index: 2,
                              ),
                            ),
                            // Add another SizedBox or widget for the second widget in this row
                          ],
                        ),
                      ),
                    ],
                  ),

                  // SizedBox(
                  //   height: media.width * 0.4,
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     "Proteins",
                  //     style: TextStyle(
                  //         fontSize:AppFontSizes.extraLargeDefault,
                  //         fontWeight: FontWeight.bold,
                  //         color: ThemeManager.themeText),
                  //   ),
                  // ),
                  // Container(
                  //   height: 200,
                  //   child: PieChart(
                  //     PieChartData(
                  //       sections: getChartCreateIndividualPiechartData(
                  //         uiData.leftProteins ?? 0,
                  //         apiData.takenProteins ?? 0,
                  //         Color.fromARGB(
                  //             255, 209, 207, 64), // Blue color for Proteins
                  //         Color.fromARGB(255, 228, 227, 156),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: Row(
                  //       children: [
                  //         Text(
                  //           message,
                  //           style: TextStyle(
                  //               fontSize: AppFontSizes.mediumDefault, color: ThemeManager.themeText),
                  //         ),
                  //         GestureDetector(
                  //           onTap: () {
                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     EditDailyTargetnUTRITION(),
                  //               ),
                  //             );
                  //           },
                  //           child: Container(
                  //             width: media.width * 0.20,
                  //             height: media.width * 0.20,
                  //             alignment: Alignment.center,
                  //             decoration: BoxDecoration(
                  //               gradient:
                  //                   LinearGradient(colors: TColor.secondaryG),
                  //               borderRadius:
                  //                   BorderRadius.circular(media.width * 0.75),
                  //             ),
                  //             child: FittedBox(
                  //               child: SizedBox(
                  //                 width: media.width * 0.16,
                  //                 child: Text(
                  //                   Languages.of(context)!.labelChangeGoal,
                  //                   textAlign: TextAlign.center,
                  //                   style: TextStyle(
                  //                       color: ThemeManager.themeColor,
                  //                       fontSize: AppFontSizes.mediumDefault),
                  //                 ),
                  //               ),
                  //             ),
                  //             // ElevatedButton(
                  //             //     onPressed: () {
                  //             //       Navigator.push(
                  //             //         context,
                  //             //         MaterialPageRoute(
                  //             //           builder: (context) =>
                  //             //               EditDailyTargetnUTRITION(),
                  //             //         ),
                  //             //       );
                  //             //     },
                  //             //     child: Text('add'))
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Table(
                  //     defaultVerticalAlignment:
                  //         TableCellVerticalAlignment.middle,
                  //     children: [
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: Colors.black54,
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 Languages.of(context)!.labelIngredientsTaken,
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: Colors.blueGrey,
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 Languages.of(context)!.labelIngredientsLeft,
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelCaloriestaken}: ${apiData.takenCalories?.toStringAsFixed(2)} kcal",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelCaloriestaken}: ${uiData.leftCalories?.toStringAsFixed(2)} kcal",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelFats}: ${apiData.takenFats?.toStringAsFixed(2)} g",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelFats}: ${uiData.leftFats?.toStringAsFixed(2)} g",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelCarbs}: ${apiData.takenCarbs?.toStringAsFixed(2)} g",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelCarbs}: ${uiData.leftCarbs?.toStringAsFixed(2)} g",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelProteins}: ${apiData.takenProteins?.toStringAsFixed(2)} g",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelProteins}: ${uiData.leftProteins?.toStringAsFixed(2)} g",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelFibers}: ${apiData.takenFibers?.toStringAsFixed(2)} g",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelFibers}: ${uiData.leftFibers?.toStringAsFixed(2)} g",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelCalcium}: ${apiData.takenCalcium?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelCalcium}: ${uiData.leftCalcium?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelNiacinB3}: ${apiData.takenNiacinB3?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelNiacinB3}: ${uiData.leftNiacinB3?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelThiamineB1}: ${apiData.takenThiamineB1?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelThiamineB1}: ${uiData.leftThiamineB1?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelIron}: ${apiData.takenIron?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelIron}: ${uiData.leftIron?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelZinc}: ${apiData.takenZinc?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelZinc}: ${uiData.leftZinc?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelFolatesB9}: ${apiData.takenFolatesB9?.toStringAsFixed(2)} mcg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelFolatesB9}: ${uiData.leftFolatesB9?.toStringAsFixed(2)} mcg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelMagnesium}: ${apiData.takenMagnesium?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelMagnesium}: ${uiData.leftMagnesium?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelRiboflavinB2}: ${apiData.takenRiboflavinB2?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelRiboflavinB2}: ${uiData.leftRiboflavinB2?.toStringAsFixed(2)} mg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       TableRow(
                  //         children: [
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color: const Color.fromARGB(137, 49, 49, 49),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelRetinolVitA}: ${apiData.takenRetinolVitA?.toStringAsFixed(2)} mcg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //           TableCell(
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                 color:
                  //                     const Color.fromARGB(255, 118, 139, 150),
                  //                 borderRadius: BorderRadius.circular(16.0),
                  //               ),
                  //               padding: EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${Languages.of(context)!.labelRetinolVitA}: ${uiData.leftRetinolVitA?.toStringAsFixed(2)} mcg",
                  //                 style: TextStyle(color: Colors.white),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // List<PieChartSectionData> getChartData(
  //     Ingredientsleft IngLeft, Ingredientstaken IngTaken) {
  //   double carbsleft = 0,
  //       fiberleft = 0,
  //       proteinleft = 0,
  //       fatsleft = 0,
  //       calleft = 0;
  //   double carbstaken = 0,
  //       fibertaken = 0,
  //       proteintaken = 0,
  //       fatstaken = 0,
  //       caltaken = 0;
  //   double carbsleftdisplay = 0,
  //       fiberleftdisplay = 0,
  //       proteinleftdisplay = 0,
  //       fatsleftdisplay = 0,
  //       calleftdisplay = 0;
  //   double carbstakendisplay = 0,
  //       fibertakendisplay = 0,
  //       proteintakendisplay = 0,
  //       fatstakendisplay = 0,
  //       caltakendisplay = 0;
  //   if (IngTaken.takenCarbs != null) {
  //     double uiDataLeftCarbs = IngLeft.leftCarbs ?? 0.0;
  //     double apiDataTakenCarbs = IngTaken.takenCarbs!; // Non-null assertion
  //     debugPrint('njdkdgkjd $apiDataTakenCarbs');
  //     carbstaken =
  //         (apiDataTakenCarbs * 100) / (apiDataTakenCarbs + uiDataLeftCarbs);
  //     if (carbstaken < 20) {
  //       carbstakendisplay = 20;
  //       carbsleftdisplay = 80;
  //     } else if (carbstaken > 80) {
  //       carbstakendisplay = 80;
  //       carbsleftdisplay = 20;
  //     }
  //     carbsleft = 100 - carbstaken;
  //   }
  //   // if (apiData.takenCarbs != null) {
  //   //   double uiDataLeftCarbs = uiData.leftCarbs ?? 0.0;
  //   //   double apiDataTakenCarbs = apiData.takenCarbs!; // Non-null assertion
  //   //   debugPrint('njdkdgkjd $apiDataTakenCarbs');
  //   //   carbsleft =
  //   //       (apiDataTakenCarbs * 100) / (apiDataTakenCarbs + uiDataLeftCarbs);
  //   //   carbstaken = 100 - carbsleft;
  //   // }
  //   if (IngTaken.takenFats != null) {
  //     double uiDataLeftfats = IngLeft.leftFats ?? 100.0;
  //     double apiDataTakenfats = IngTaken.takenFats!; // Non-null assertion

  //     fatstaken =
  //         (apiDataTakenfats * 100) / (apiDataTakenfats + uiDataLeftfats);
  //     if (fatstaken < 20) {
  //       fatstakendisplay = 20;
  //       fatsleftdisplay = 80;
  //     } else if (fatstaken > 80) {
  //       fatstakendisplay = 80;
  //       fatsleftdisplay = 20;
  //     }
  //     fatsleft = 100 - fatstaken;
  //   }
  //   if (IngTaken.takenFibers != null) {
  //     double uiDataLeftFiber = IngLeft.leftFibers ?? 0.0;
  //     double apiDataTakenFiber = IngTaken.takenFibers!; // Non-null assertion

  //     fibertaken =
  //         (apiDataTakenFiber * 100) / (apiDataTakenFiber + uiDataLeftFiber);
  //     if (fibertaken < 20) {
  //       fibertakendisplay = 20;
  //       fiberleftdisplay = 80;
  //     } else if (fibertaken > 80) {
  //       fibertakendisplay = 80;
  //       fiberleftdisplay = 20;
  //     }
  //     fiberleft = 100 - fibertaken;
  //   }

  //   if (IngTaken.takenProteins != null) {
  //     double uiDataLeftProtein = IngLeft.leftProteins ?? 0.0;
  //     double apiDataTakenProtein =
  //         IngTaken.takenProteins!; // Non-null assertion

  //     proteintaken = (apiDataTakenProtein * 100) /
  //         (apiDataTakenProtein + uiDataLeftProtein);
  //     if (proteintaken < 20) {
  //       proteintakendisplay = 20;
  //       proteinleftdisplay = 80;
  //     } else if (proteintaken > 80) {
  //       proteintakendisplay = 80;
  //       proteinleftdisplay = 20;
  //     }
  //     proteinleft = 100 - proteintaken;
  //   }

  //   if (IngTaken.takenCalories != null) {
  //     double uiDataLeftCal = IngLeft.leftCalories ?? 0.0;
  //     double apiDataTakenCal = IngTaken.takenCalories!; // Non-null assertion

  //     caltaken = (apiDataTakenCal * 100) / (apiDataTakenCal + uiDataLeftCal);
  //     if (caltaken < 20) {
  //       caltakendisplay = 20;
  //       calleftdisplay = 80;
  //     } else if (caltaken > 80) {
  //       caltakendisplay = 80;
  //       calleftdisplay = 20;
  //     }
  //     calleft = 100 - caltaken;
  //   }

  //   debugPrint('njdfdgkdgkjd $fiberleft');
  //   return [
  //     PieChartSectionData(
  //      decoration: BoxDecoration(

  //       value: fibertakendisplay,
  //       title: ' ${double.parse(fibertaken.toStringAsFixed(2))}',
  //       radius: 80,
  //       titleStyle: TextStyle(fontSize: AppFontSizes.smallDefault,, fontWeight: FontWeight.bold),
  //     ),
  //     PieChartSectionData(
  //       color: Color.fromARGB(255, 80, 170, 243),
  //       value: fiberleftdisplay,
  //       title: ' ${double.parse(fiberleft.toStringAsFixed(2))}',
  //       radius: 80,
  //       titleStyle: TextStyle(fontSize: AppFontSizes.smallDefault,, fontWeight: FontWeight.bold),
  //     ),
  //     PieChartSectionData(
  //    decoration: BoxDecoration(

  //       value: fatstakendisplay,
  //       title: ' ${double.parse(fatstaken.toStringAsFixed(2))}',
  //       radius: 80,
  //       titleStyle: TextStyle(fontSize: AppFontSizes.smallDefault,, fontWeight: FontWeight.bold),
  //     ),
  //     PieChartSectionData(
  //       color: const Color.fromARGB(255, 120, 228, 123),
  //       value: fatsleftdisplay,
  //       title: ' ${double.parse(fatsleft.toStringAsFixed(2))}',
  //       radius: 80,
  //       titleStyle: TextStyle(fontSize: AppFontSizes.smallDefault,, fontWeight: FontWeight.bold),
  //     ),
  //     PieChartSectionData(
  //       color: Colors.orange,
  //       value: carbstakendisplay,
  //       title: ' ${double.parse(carbstaken.toStringAsFixed(2))}',
  //       radius: 80,
  //       titleStyle: TextStyle(fontSize: AppFontSizes.smallDefault,, fontWeight: FontWeight.bold),
  //     ),
  //     PieChartSectionData(
  //       color: const Color.fromARGB(255, 245, 165, 46),
  //       value: carbsleftdisplay,
  //       title: ' ${double.parse(carbsleft.toStringAsFixed(2))}',
  //       radius: 80,
  //       titleStyle: TextStyle(fontSize: AppFontSizes.smallDefault,, fontWeight: FontWeight.bold),
  //     ),
  //     PieChartSectionData(
  //       color: Colors.red,
  //       value: proteintakendisplay,
  //       title: ' ${double.parse(proteintaken.toStringAsFixed(2))}',
  //       radius: 80,
  //       titleStyle: TextStyle(fontSize: AppFontSizes.smallDefault,, fontWeight: FontWeight.bold),
  //     ),
  //     PieChartSectionData(
  //       color: Color.fromARGB(255, 243, 93, 82),
  //       value: proteinleftdisplay,
  //       title: ' ${double.parse(proteinleft.toStringAsFixed(2))}',
  //       radius: 80,
  //       titleStyle: TextStyle(fontSize: AppFontSizes.smallDefault,, fontWeight: FontWeight.bold),
  //     ),
  //     PieChartSectionData(
  //       color: const Color.fromARGB(255, 129, 76, 57),
  //       value: caltakendisplay,
  //       title: ' ${double.parse(caltaken.toStringAsFixed(2))}',
  //       radius: 80,
  //       titleStyle: TextStyle(fontSize: AppFontSizes.smallDefault,, fontWeight: FontWeight.bold),
  //     ),
  //     PieChartSectionData(
  //       color: Color.fromARGB(255, 129, 105, 96),
  //       value: calleftdisplay,
  //       title: ' ${double.parse(calleft.toStringAsFixed(2))}',
  //       radius: 80,
  //       titleStyle: TextStyle(fontSize: AppFontSizes.smallDefault,, fontWeight: FontWeight.bold),
  //     ),
  //   ];
  // }

  List<PieChartSectionData> getChartCreateIndividualPiechartData(
      double ingLeft, double ingTaken, Color x, Color y) {
    double takenpercent = (ingTaken / (ingLeft + ingTaken)) * 100;
    double leftpercent = (ingLeft / (ingLeft + ingTaken)) * 100;
    ingLeft = leftpercent;
    ingTaken = takenpercent;
    if (leftpercent < 10 && leftpercent > 0) {
      leftpercent = 15;
    }
    if (takenpercent < 10 && takenpercent > 0) {
      takenpercent = 15;
    }
    debugPrint("data is here kmfdmbgf $takenpercent $leftpercent");
    return [
      PieChartSectionData(
        color: x,
        value: takenpercent,
        title: ' ${ingTaken.toStringAsFixed(1)} % \n taken',
        radius: 80,
        titleStyle: TextStyle(
            fontSize: AppFontSizes.smallDefault,
            fontWeight: FontWeight.bold,
            color: ThemeManager.themeText),
      ),
      PieChartSectionData(
        color: y,
        value: leftpercent,
        title: ' ${ingLeft.toStringAsFixed(1)}% \n left',
        radius: 80,
        titleStyle: TextStyle(
            fontSize: AppFontSizes.smallDefault,
            fontWeight: FontWeight.bold,
            color: ThemeManager.themeText),
      ),
    ];
  }
}

class CommonViewWidget extends StatelessWidget {
  final Map fObj;
  final int index;
  const CommonViewWidget({super.key, required this.index, required this.fObj});

  @override
  Widget build(BuildContext context) {
    debugPrint('dataa is ${fObj["value"]}');
    var media = MediaQuery.of(context).size;
    bool isEvent = index % 2 == 0;
    return Container(
      margin: const EdgeInsets.all(5),
      width: media.width * 0.32,
      height: media.width * 0.48,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: isEvent
                  ? [
                      ThemeManager.themelightColor,
                      const Color.fromARGB(255, 194, 196, 204)
                    ]
                  : [
                      ThemeManager.themelightColor,
                      const Color.fromARGB(255, 194, 196, 204)
                    ]),
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    child: Text(
                      fObj["name"].toString(),
                      style: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.mediumDefault,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: media.width * 0.3,
              // height: media.width * 0.3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: media.width * 0.20,
                    height: media.width * 0.20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: TColor.primaryG),
                      borderRadius: BorderRadius.circular(media.width * 0.75),
                    ),
                    child: FittedBox(
                      child: Text(
                        //     "${double.parse(fObj["value"]).toStringAsFixed(double.parse(fObj["value"]) >= 99 ? 0 : 2)}",
                        fObj["value"], textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ThemeManager.themeText,
                            fontSize: AppFontSizes.mediumDefault),
                      ),
                    ),
                  ),
                  SimpleCircularProgressBar(
                    progressStrokeWidth: 5,
                    backStrokeWidth: 5,
                    progressColors: TColor.primaryG,
                    backColor: Colors.grey.shade100,
                    valueNotifier: ValueNotifier(fObj["percent"] * 100),
                    startAngle: -180,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
