// Import necessary Flutter packages
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/NutrientsGoalAccordingRda.dart';
import 'package:nin2byo2i/view/Food/SearchCookedFood.dart';
import 'package:nin2byo2i/view/Food/SearchRawFood.dart';
import 'package:nin2byo2i/view/Food/Top10FoodList.dart';
import 'package:nin2byo2i/view/Food/dietaryDiary.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//food analyse page  this having three option top 10 food,search food ,and  nutrition goal on th basis of rda
// Define the FoodAnalyse class, representing the home page of the application
class NutrientInMyFood extends StatelessWidget {
  const NutrientInMyFood({super.key});

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
              "assets/img/black_btn.png",
              color: ThemeManager.themeText,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.TextAppNutrientsInMyFood,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            sizedBox30(),
            // sizedBox30(),
            // Create a reusable ContainerCard for the first action
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Top10Foods()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: TColor.primaryColor1.withOpacity(0.2)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/img/top 10 food.png',
                            height: 100,
                            // width: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 150,
                          child: Text(
                            Languages.of(context)!.mainlabelExploreTop10Foods,
                            style: TextStyle(
                                color: ThemeManager.themeText,
                                fontSize: AppFontSizes.extraLargeDefault),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchCookedFood()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: TColor.primaryColor1.withOpacity(0.2)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/img/cooked recipy.png',
                            height: 100,
                            // width: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 150,
                          child: Text(
                            Languages.of(context)!.mainlabelSearchCookedFood,
                            style: TextStyle(
                                color: ThemeManager.themeText,
                                fontSize: AppFontSizes.extraLargeDefault),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchRawFood()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: TColor.primaryColor1.withOpacity(0.2)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/img/raw food.jpeg.png',
                            height: 100,
                            // width: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 150,
                          child: Text(
                            Languages.of(context)!
                                .TextAppSearchNutrientsInRawFoods,
                            style: TextStyle(
                                color: ThemeManager.themeText,
                                fontSize: AppFontSizes.extraLargeDefault),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ContainerCard(
            //   imagePath: 'assets/img/top10food.png',
            //   text: 'Explore Top 10 Foods',
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Top10Foods()),
            //     );
            //   },
            // ),
            // // Create another ContainerCard for the second action
            // ContainerCard(
            //   imagePath: 'assets/img/foodsafe (2).png',
            //   text: 'Search Cooked Food',
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => SearchCookedFood()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

// Define a reusable ContainerCard widget for displaying action items
class ContainerCard extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const ContainerCard({super.key, 
    required this.imagePath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color.fromARGB(255, 152, 219, 219)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imagePath,
                  height: 100,
                  // width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 120,
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: AppFontSizes.extraLargeDefault),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
