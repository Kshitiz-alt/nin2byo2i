import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/tab_button.dart';
import 'package:nin2byo2i/view/Food/showListOfUserFoodTable.dart';
import 'package:nin2byo2i/view/ScreensAPP/ListOfAllBooks.dart';
import 'package:nin2byo2i/view/main_tab/SearchComponents.dart';

import 'package:nin2byo2i/view/main_tab/select_view.dart';

import '../../Common/colo_extension.dart';

import 'package:flutter/material.dart';

import '../home/home_view.dart';

import '../profile/profile_view.dart';

//common bottom navigator
class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();
  Widget currentTab = const Home();
  List<Color> fabColor = TColor.primaryG;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeManager.themeColor,
      body: PageStorage(bucket: pageBucket, child: currentTab),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            // Change currentTab to SearchComponents() on FloatingActionButton click
            selectTab =
                -1; // Set an invalid tab to prevent BottomAppBar from activating any tab
            currentTab = SearchComponents(item: [
              {
                'index': 3,
                'heading': Languages.of(context)!.headingBloodOxygenHeart,
                'description': Languages.of(context)!.labelBloodOxygenHeart,
                'image': "assets/img/heart.png"
              },
              {
                'index': 4,
                'heading': Languages.of(context)!.headingTop10Food,
                'description': Languages.of(context)!.labelTop10FoodS,
                'image': "assets/img/heart.png"
              },
              {
                'index': 5,
                'heading': Languages.of(context)!.headingWaterTrack,
                'description': Languages.of(context)!.labelWaterTrack,
                'image': "assets/img/heart.png"
              },
              {
                'index': 7,
                'heading': Languages.of(context)!.headingPersonalDetails,
                'description': Languages.of(context)!.labelPersonalDetails,
                'image': "assets/img/heart.png"
              },
              {
                'index': 8,
                'heading': Languages.of(context)!.headingFeedback,
                'description': Languages.of(context)!.labelFeedbackS,
                'image': "assets/img/heart.png"
              },
              {
                'index': 9,
                'heading': Languages.of(context)!.headingContactUs,
                'description': Languages.of(context)!.labelContactUsS,
                'image': "assets/img/heart.png"
              },
              {
                'index': 10,
                'heading': Languages.of(context)!.headingBMICalculator,
                'description': Languages.of(context)!.labelBMICalculator,
                'image': "assets/img/heart.png"
              },
              {
                'index': 11,
                'heading': Languages.of(context)!.headingBMRCalculator,
                'description': Languages.of(context)!.labelBMRCalculator,
                'image': "assets/img/heart.png"
              },
              // {
              //   'index': 12,
              //   'heading': Languages.of(context)!.headingRunningJoggingSteps,
              //   'description': Languages.of(context)!.labelRunningJoggingSteps,
              //   'image': "assets/img/heart.png"
              // },
              // {
              //   'index': 13,
              //   'heading': Languages.of(context)!.headingHealthyDietChart,
              //   'description': Languages.of(context)!.labelHealthyDietChart,
              //   'image': "assets/img/heart.png"
              // },
              // {
              //   'index': 14,
              //   'heading': Languages.of(context)!.headingHealthyRecommendation,
              //   'description':
              //       Languages.of(context)!.labelHealthyRecommendation,
              //   'image': "assets/img/heart.png"
              // },
              // {
              //   'index': 15,
              //   'heading': Languages.of(context)!.headingSleepTracker,
              //   'description': Languages.of(context)!.labelSleepTracker,
              //   'image': "assets/img/heart.png"
              // },
              {
                'index': 16,
                'heading': Languages.of(context)!.headingSetReminder,
                'description': Languages.of(context)!.labelSetReminder,
                'image': "assets/img/heart.png"
              },
              // {
              //   'index': 17,
              //   'heading': 'Menstruation Cycle',
              //   'description':
              //       'Track and manage your menstrual cycle for better insights.',
              //   'image': "assets/img/heart.png"
              // // },
              // {
              //   'index': 18,
              //   'heading': Languages.of(context)!.headingCSVDownload,
              //   'description': Languages.of(context)!.labelCSVDownload,
              //   'image': "assets/img/heart.png"
              // },
              {
                'index': 19,
                'heading':
                    Languages.of(context)!.ninTextNutritionEducationContent,
                'description':
                    Languages.of(context)!.ninTextNutritionEducationContent,
                'image': "assets/img/heart.png"
              },
              {
                'index': 20,
                'heading': Languages.of(context)!.DietaryGuidelinesForIndians,
                'description':
                    Languages.of(context)!.RecommendationsBalancedDiets,
                'image': "assets/img/heart.png"
              },
              {
                'index': 21,
                'heading': Languages.of(context)!.NutrientRequirementsRDA2020,
                'description':
                    Languages.of(context)!.EssentialNutritionalGuidelines,
                'image': "assets/img/heart.png"
              },
              {
                'index': 22,
                'heading': Languages.of(context)!.TextAppMyDietDiary,
                'description':
                    Languages.of(context)!.personalizedDietDiaryDescription,
                'image': "assets/img/heart.png"
              },

              {
                'index': 23,
                'heading': Languages.of(context)!.indianFoodCompositionTitle,
                'description':
                    Languages.of(context)!.indianFoodCompositionDescription,
                'image': "assets/img/heart.png"
              },
            ]);
            if (mounted) {
              setState(() {
                fabColor = TColor.secondaryG;
              });
            }
          },
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: fabColor,
              ),
              borderRadius: BorderRadius.circular(35),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                )
              ],
            ),
            child: Icon(
              Icons.search,
              color: ThemeManager.themeColor,
              size: 35,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            color: ThemeManager.themeColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, -2),
              ),
            ],
          ),
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabButton(
                icon: "assets/img/home_tab.png",
                selectIcon: "assets/img/home_tab_select.png",
                isActive: selectTab == 0,
                onTap: () {
                  selectTab = 0;
                  currentTab = const Home();
                  if (mounted) {
                    setState(() {
                      fabColor = TColor.primaryG;
                    });
                  }
                },
              ),
              TabButton(
                icon: "assets/img/shopping-cart.png",
                selectIcon: "assets/img/shopping-cart.png",
                isActive: selectTab == 1,
                onTap: () {
                  selectTab = 1;
                  currentTab = BookListPage();
                  if (mounted) {
                    setState(() {
                      fabColor = TColor.primaryG;
                    });
                  }
                },
              ),
              const SizedBox(
                width: 40,
              ),
              TabButton(
                icon: "assets/img/foodtableicon.png",
                selectIcon: "assets/img/foodtableicon_selected.png",
                isActive: selectTab == 2,
                onTap: () {
                  selectTab = 2;
                  currentTab = showfoodtableListOfUser();
                  if (mounted) {
                    setState(() {
                      fabColor = TColor.primaryG;
                    });
                  }
                },
              ),
              TabButton(
                icon: "assets/img/profile_tab.png",
                selectIcon: "assets/img/profile_tab_select.png",
                isActive: selectTab == 3,
                onTap: () {
                  selectTab = 3;
                  currentTab = const ProfileView();
                  if (mounted) {
                    setState(() {
                      fabColor = TColor.primaryG;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
