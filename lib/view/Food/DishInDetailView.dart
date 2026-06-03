import 'package:flutter/material.dart';
import 'package:nin2byo2i/Classes/Food%20Classes/foodtableingredient.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';

//dish detail page for taken dish
class FoodDetailsPage extends StatefulWidget {
  final Dish dish; // Assuming you have a Food class for food data

  const FoodDetailsPage({super.key, required this.dish});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  final UserProfileController _controller = UserProfileController();
  @override
  void initState() {
    super.initState();
    // Call the function to get daywise sleep data when the page is created
  }

  Future<void> unfavoriteDish(int index, bool status) async {
    try {
      await _controller.UpdateToFavourite(index, status);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    // bool isFavorite = widget.dish.favourite;
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
          Languages.of(context)!.mainlabelFoodInDetail,
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
        child: Column(
          children: [
            // ElevatedButton(
            //     onPressed: () {
            //       debugPrint("dish tv ${widget.dish}");
            //     },
            //     child: Text("data")),
            Container(
              child: ClipRect(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Transform.scale(
                      scale: 1.25,
                      child: Container(
                        width: media.width * 0.55,
                        height: media.width * 0.55,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius:
                              BorderRadius.circular(media.width * 0.275),
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.25,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'assets/img/f_1.png',
                          width: media.width * 0.60,
                          height: media.width * 0.60,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Text("Food Name: ${dish.dishName}"),
            // Text("Calories: ${dish.totalCalories.toStringAsFixed(2)}"),
            Container(
              // margin: const EdgeInsets.symmetric(
              //     vertical: 8, horizontal: 4),
              // padding: const EdgeInsets.symmetric(horizontal: 8),
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [
              //       Color.fromARGB(255, 51, 49, 49)
              //           .withOpacity(0.4),
              //       Color.fromARGB(255, 2, 39, 51).withOpacity(0.4),
              //       // TColor.secondaryColor1.withOpacity(0.4),
              //       // TColor.primaryColor1.withOpacity(0.4),
              //     ],
              //   ),
              //   // borderRadius: BorderRadius.circular(10),
              // ),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10),
              // ),
              color: Colors.black.withOpacity(0.6),
              child: Container(
                decoration: BoxDecoration(
                    color: ThemeManager.themeColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      ' ${widget.dish.dishName}',
                                      style: TextStyle(
                                          color: ThemeManager.themeText,
                                          fontSize: AppFontSizes.mediumDefault,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const Spacer(),

                                    IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: widget.dish.favourite
                                            ? Colors.red
                                            : Colors
                                                .grey, // Set the color based on the state
                                      ),
                                      onPressed: () {
                                        // Handle tap on the favorite icon
                                        int dishId = widget.dish.dishId;
                                        unfavoriteDish(
                                            dishId, !widget.dish.favourite);

                                        // Update the state to toggle the color
                                        setState(() {
                                          widget.dish.favourite =
                                              !widget.dish.favourite;
                                        });
                                      },
                                    )
                                    // TextButton(
                                    //   onPressed: () {},
                                    //   child: Image.asset(
                                    //     "assets/img/fav.png",
                                    //     width: 15,
                                    //     height: 15,
                                    //     fit: BoxFit.contain,
                                    //   ),
                                    // )
                                  ],
                                ),
                                Visibility(
                                  visible: widget.dish.dishQuantity != 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color.fromARGB(255, 228, 228, 211)
                                              .withOpacity(0.4),
                                          const Color.fromARGB(255, 149, 204, 221)
                                              .withOpacity(0.4),
                                          // TColor.secondaryColor1.withOpacity(0.4),
                                          // TColor.primaryColor1.withOpacity(0.4),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              // Row(
                                              //   children: [
                                              //     Text(
                                              //       Languages.of(context)!
                                              //           .NINTextCookedQuantity, // Name the first quantity as dishQuantity in grams
                                              //       style: TextStyle(
                                              //         color: ThemeManager
                                              //             .themeText,
                                              //         fontSize: AppFontSizes
                                              //             .mediumDefault,
                                              //       ),
                                              //     ),
                                              //     Text(
                                              //       ' : ${widget.dish.dishQuantity} g', // Name the first quantity as dishQuantity in grams
                                              //       style: TextStyle(
                                              //         color: TColor
                                              //             .secondaryColor1,
                                              //         fontSize: AppFontSizes
                                              //             .mediumDefault,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // Spacer(),
                                              Row(
                                                children: [
                                                  Text(
                                                    Languages.of(context)!
                                                        .NINTextServingQuantity, // Name the second quantity as servingSize in grams
                                                    style: TextStyle(
                                                      color: ThemeManager
                                                          .themeText,
                                                      fontSize: AppFontSizes
                                                          .mediumDefault,
                                                    ),
                                                  ),
                                                  Text(
                                                    ' : ${widget.dish.servingSize.toStringAsFixed(widget.dish.servingSize >= 99 ? 0 : 2)} g', // Name the first quantity as dishQuantity in grams
                                                    style: TextStyle(
                                                      color: TColor
                                                          .secondaryColor1,
                                                      fontSize: AppFontSizes
                                                          .mediumDefault,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "One ${widget.dish.unit} = ${(widget.dish.valueforOneUnit).toStringAsFixed((widget.dish.valueforOneUnit) >= 99 ? 0 : 2)} g", // Name the first quantity as dishQuantity in grams
                                                    style: TextStyle(
                                                      color: ThemeManager
                                                          .themeText,
                                                      fontSize: AppFontSizes
                                                          .mediumDefault,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Total ${widget.dish.unit} taken : ${(widget.dish.servingSize / widget.dish.valueforOneUnit).toStringAsFixed((widget.dish.servingSize / widget.dish.valueforOneUnit) >= 99 ? 0 : 2)}", // Name the second quantity as servingSize in grams
                                                    style: TextStyle(
                                                      color: ThemeManager
                                                          .themeText,
                                                      fontSize: AppFontSizes
                                                          .mediumDefault,
                                                    ),
                                                  ),
                                                ],
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
                                //       CustomGradientWidgetDishTotal(
                                //         imageAsset: 'assets/img/burn.png',
                                //         value:
                                //             '${widget.dish.totalCalories.toStringAsFixed(widget.dish.totalCalories >= 99 ? 0 : 2)} cal',
                                //       ),
                                //       CustomGradientWidgetDishTotal(
                                //         imageAsset: 'assets/img/proteins.png',
                                //         value:
                                //             ' ${widget.dish.totalProteins.toStringAsFixed(widget.dish.totalProteins >= 99 ? 0 : 2)} protien',
                                //       ),
                                //       CustomGradientWidgetDishTotal(
                                //         imageAsset: 'assets/img/egg.png',
                                //         value:
                                //             ' ${widget.dish.totalFats.toStringAsFixed(widget.dish.totalFats >= 99 ? 0 : 2)} fats',
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
                                //       CustomGradientWidgetDishTotal(
                                //         imageAsset: 'assets/img/carbo.png',
                                //         value:
                                //             ' ${widget.dish.totalCarbs.toStringAsFixed(widget.dish.totalFats >= 99 ? 0 : 2)} carbs',
                                //       ),
                                //       CustomGradientWidgetDishTotal(
                                //         imageAsset: 'assets/img/egg.png',
                                //         value:
                                //             ' ${widget.dish.totalFibers.toStringAsFixed(widget.dish.totalFats >= 99 ? 0 : 2)} fibers',
                                //       ),
                                //       CustomGradientWidgetDishTotal(
                                //         imageAsset: 'assets/img/egg.png',
                                //         value:
                                //             'Ingred ${widget.dish.ingredients.length}',
                                //       )
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   child: Text(
                    //     Languages.of(context)!.NINTextNutrientInformation,
                    //     style: TextStyle(
                    //         color: ThemeManager.themeText,
                    //         fontSize: AppFontSizes.mediumDefault,
                    //         fontWeight: FontWeight.w700),
                    //   ),
                    // ),
                    // ListTile(
                    //   title: Text("Dish Name: ${dish.dishName}"),
                    //   subtitle: Text(
                    //       "Total Calories: ${dish.totalCalories.toStringAsFixed(2)}"),
                    // ),
                    //Text("Dish Ingredient Details:"),
                    // Column(
                    //   children: widget.dish.ingredients.map((ingredient) {
                    //     return Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Container(
                    //         margin: EdgeInsets.only(top: 14),
                    //         decoration: BoxDecoration(
                    //           gradient: LinearGradient(
                    //             colors: [
                    //               Color.fromARGB(255, 228, 228, 211)
                    //                   .withOpacity(0.4),
                    //               Color.fromARGB(255, 149, 204, 221)
                    //                   .withOpacity(0.4),
                    //               // TColor.secondaryColor1.withOpacity(0.4),
                    //               // TColor.primaryColor1.withOpacity(0.4),
                    //             ],
                    //           ),
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             ListTile(
                    //               title: Text(
                    //                   "${Languages.of(context)!.ninTextIngredient} : ${ingredient.ingredientName}"),
                    //               subtitle: Text(
                    //                   "Quantity: ${ingredient.ingredientQuantity.toStringAsFixed(ingredient.ingredientQuantity >= 99 ? 0 : 2)}"),
                    //             ),
                    //             SingleChildScrollView(
                    //               scrollDirection: Axis
                    //                   .horizontal, // Enable horizontal scrolling
                    //               child: Row(
                    //                 children: [
                    //                   CustomGradientWidget(
                    //                     imageAsset: 'assets/img/burn.png',
                    //                     value:
                    //                         '${ingredient.calories.toStringAsFixed(ingredient.calories >= 99 ? 0 : 2)} cal',
                    //                   ),
                    //                   CustomGradientWidget(
                    //                     imageAsset: 'assets/img/proteins.png',
                    //                     value:
                    //                         ' ${ingredient.proteins.toStringAsFixed(ingredient.proteins >= 99 ? 0 : 2)} protien',
                    //                   ),
                    //                   CustomGradientWidget(
                    //                     imageAsset: 'assets/img/egg.png',
                    //                     value:
                    //                         ' ${ingredient.fats.toStringAsFixed(ingredient.fats >= 99 ? 0 : 2)} fats',
                    //                   ),
                    //                   CustomGradientWidget(
                    //                     imageAsset: 'assets/img/carbo.png',
                    //                     value:
                    //                         ' ${ingredient.carbs.toStringAsFixed(ingredient.carbs >= 99 ? 0 : 2)} carbs',
                    //                   ),
                    //                   CustomGradientWidget(
                    //                     imageAsset: 'assets/img/egg.png',
                    //                     value:
                    //                         ' ${ingredient.fibers.toStringAsFixed(ingredient.fibers >= 99 ? 0 : 2)} fibers',
                    //                   ),
                    //                   // Add more CustomGradientWidget instances as needed
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF007BC1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${Languages.of(context)!.NINTextNutrientInformation} for ${widget.dish.servingSize.toStringAsFixed(widget.dish.servingSize >= 99 ? 0 : 2)} g",
                                style: const TextStyle(
                                    fontSize: AppFontSizes.mediumDefault,
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
                              color: TColor.primaryColor2.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  sizedBox12(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        // bottom: 8.0,
                                        left: 8.0,
                                        right: 8.0),
                                    child: Container(
                                      height: 40,
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 5.0),
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 34, 104,
                                            161), // Use the provided color
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width:
                                                  147, // Adjust the width according to your needs
                                              child: Text(
                                                  Languages.of(context)!
                                                      .NINTextNutrient,
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            SizedBox(
                                              width:
                                                  147, // Adjust the width according to your needs
                                              child: Text(
                                                  textAlign: TextAlign.center,
                                                  Languages.of(context)!.NINTextValue,
                                                  style: const TextStyle(
                                                      color: Colors.white)),
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
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, left: 8.0, right: 8.0),
                                    child: Column(
                                      children: [
                                        customtablerow(
                                          color: Colors.white,
                                          ingredientName: Languages.of(context)!
                                              .NINTextEnergyKcal,
                                          ingredientValue:
                                              widget.dish.totalCalories.toStringAsFixed(widget.dish.totalCalories >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: TColor.primaryColor1
                                              .withOpacity(0.2),
                                          ingredientName: Languages.of(context)!
                                              .NINTextProteinG,
                                          ingredientValue:
                                              widget.dish.totalProteins.toStringAsFixed(widget.dish.totalProteins >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: Colors.white,
                                          ingredientName: Languages.of(context)!
                                              .NINTextFatG,
                                          ingredientValue:
                                              widget.dish.totalFats.toStringAsFixed(widget.dish.totalFats >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: TColor.primaryColor1
                                              .withOpacity(0.2),
                                          ingredientName: Languages.of(context)!
                                              .NINTextCarbohydratesG,
                                          ingredientValue:
                                              widget.dish.totalCarbs.toStringAsFixed(widget.dish.totalCarbs >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: Colors.white,
                                          ingredientName: Languages.of(context)!
                                              .NINTextCalciumMg,
                                          ingredientValue:
                                              widget.dish.totalCalcium.toStringAsFixed(widget.dish.totalCalcium >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: TColor.primaryColor1
                                              .withOpacity(0.2),
                                          ingredientName: Languages.of(context)!
                                              .NINTextFiberG,
                                          ingredientValue:
                                              widget.dish.totalFibers.toStringAsFixed(widget.dish.totalFibers >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: Colors.white,
                                          ingredientName: Languages.of(context)!
                                              .NINTextIronMg,
                                          ingredientValue:
                                              widget.dish.totalIron.toStringAsFixed(widget.dish.totalIron >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: TColor.primaryColor1
                                              .withOpacity(0.2),
                                          ingredientName: Languages.of(context)!
                                              .NINTextZincMg,
                                          ingredientValue:
                                              widget.dish.totalZinc.toStringAsFixed(widget.dish.totalZinc >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: Colors.white,
                                          ingredientName: Languages.of(context)!
                                              .NINTextMagnesiumMg,
                                          ingredientValue:
                                              widget.dish.totalMagnesium.toStringAsFixed(widget.dish.totalMagnesium >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: TColor.primaryColor1
                                              .withOpacity(0.2),
                                          ingredientName: Languages.of(context)!
                                              .NINTextThiamineB1Mg,
                                          ingredientValue:
                                              widget.dish.totalThiamineB1.toStringAsFixed(widget.dish.totalThiamineB1 >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: Colors.white,
                                          ingredientName: Languages.of(context)!
                                              .NINTextRiboflavinB2Mg,
                                          ingredientValue:
                                              widget.dish.totalRiboflavinB2.toStringAsFixed(widget.dish.totalRiboflavinB2 >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: TColor.primaryColor1
                                              .withOpacity(0.2),
                                          ingredientName: Languages.of(context)!
                                              .NINTextNiacinB3Mg,
                                          ingredientValue:
                                              widget.dish.totalNiacinB3.toStringAsFixed(widget.dish.totalNiacinB3 >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: Colors.white,
                                          ingredientName: Languages.of(context)!
                                              .NINTextFolatesB9Mcg,
                                          ingredientValue:
                                              widget.dish.totalFolatesB9.toStringAsFixed(widget.dish.totalFolatesB9 >= 99 ? 0 : 2),
                                        ),
                                        customtablerow(
                                          color: TColor.primaryColor1
                                              .withOpacity(0.2),
                                          ingredientName: Languages.of(context)!
                                              .NINTextRetinolVitAMcg,
                                          ingredientValue:
                                              widget.dish.totalFolatesB9.toStringAsFixed(widget.dish.totalRetinolVitA >= 99 ? 0 : 2),
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
                  ],
                ),
              ),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}

class CustomGradientWidgetDishTotal extends StatelessWidget {
  final String imageAsset;
  final String value;

  const CustomGradientWidgetDishTotal(
      {super.key, required this.imageAsset, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              TColor.primaryColor2.withOpacity(0.4),
              TColor.primaryColor1.withOpacity(0.4),
            ],
          ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomGradientWidget extends StatelessWidget {
  final String imageAsset;
  final String value;

  const CustomGradientWidget({super.key, required this.imageAsset, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              TColor.primaryColor2.withOpacity(0.4),
              TColor.primaryColor1.withOpacity(0.4),
            ],
          ),
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
                ),
              ),
            ),
          ],
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
    required this.color, // Added color field
  }) : super(key: key);

  final String ingredientName;
  final String ingredientValue;

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
