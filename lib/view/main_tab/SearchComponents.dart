import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Help%20Supports/BMICalculator.dart';
import 'package:nin2byo2i/Help%20Supports/BMRCalculator.dart';
import 'package:nin2byo2i/Help%20Supports/ContactUs.dart';
import 'package:nin2byo2i/Help%20Supports/FeedBack.dart';
import 'package:nin2byo2i/Help%20Supports/HelthRecommandation.dart';
import 'package:nin2byo2i/Help%20Supports/SuggestHealthyFood.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';

import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/ExportToCsv.dart';
import 'package:nin2byo2i/view/Food/NutritionEducationPage%20.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/view/Food/Top10FoodList.dart';
import 'package:nin2byo2i/view/Food/dietaryDiary.dart';
import 'package:nin2byo2i/view/Food/showListOfUserFoodTable.dart';
import 'package:nin2byo2i/view/HealthTrends/HealthTrendBottomNav.dart';
import 'package:nin2byo2i/view/MensurationData/MensurationCycle.dart';
import 'package:nin2byo2i/view/ScreensAPP/setnotification.dart';

import 'package:nin2byo2i/view/profile/ShowUserProileData.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/view/profile/ShowUserProileData.dart';
import 'package:nin2byo2i/view/workout_tracker/SleepTrackerSCreen.dart';
import 'package:nin2byo2i/view/workout_tracker/activity_tracker_view.dart';
import 'package:nin2byo2i/view/workout_tracker/activitydata.dart';
import 'package:url_launcher/url_launcher.dart';

//search page in wich user can search all the components of page all features
class SearchComponents extends StatefulWidget {
  final List<Map<String, dynamic>> item;
  const SearchComponents({super.key, required this.item});
  @override
  _SearchComponentsState createState() => _SearchComponentsState();
}

class _SearchComponentsState extends State<SearchComponents> {
  // List<Map<String, dynamic>> allItems = [
  //   {
  //     'index': 3,
  //     'heading': 'Blood | Oxygen | Heart',
  //     'description': 'Measure vital signs and track overall health.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 4,
  //     'heading': 'Top 10 Food',
  //     'description':
  //         'Discover recommended foods to maintain a healthy lifestyle.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 5,
  //     'heading': 'Water Track',
  //     'description': 'Set and achieve daily fitness hydration goals.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 7,
  //     'heading': 'Personal Details',
  //     'description': 'Manage and update personal information securely.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 8,
  //     'heading': 'Feedback',
  //     'description': 'Share your thoughts and suggestions with us.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 9,
  //     'heading': 'Contact Us',
  //     'description': 'Reach customer support and get in touch with us.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 10,
  //     'heading': 'BMI Calculator',
  //     'description': 'Calculate your Body Mass Index for health insights.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 11,
  //     'heading': 'BMR Calculator',
  //     'description':
  //         'Calculate your Basal Metabolic Rate for fitness planning.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 12,
  //     'heading': 'Running Jogging Steps',
  //     'description':
  //         'Track your running and jogging steps for a healthy lifestyle.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 13,
  //     'heading': 'Healthy Diet Chart',
  //     'description':
  //         'Access a comprehensive chart for a healthy diet overview.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 14,
  //     'heading': 'Healthy Recommendation',
  //     'description': 'Receive personalized health recommendations.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 15,
  //     'heading': 'Sleep Tracker',
  //     'description': 'Track your sleep patterns and improve sleep quality.',
  //     'image': "assets/img/heart.png"
  //   },
  //   {
  //     'index': 16,
  //     'heading': 'Set Reminder',
  //     'description': 'Set reminders for health and fitness activities.',
  //     'image': "assets/img/heart.png"
  //   },
  //   // {
  //   //   'index': 17,
  //   //   'heading': 'Menstruation Cycle',
  //   //   'description':
  //   //       'Track and manage your menstrual cycle for better insights.',
  //   //   'image': "assets/img/heart.png"
  //   // },
  //   {
  //     'index': 18,
  //     'heading': 'CSV Download',
  //     'description': 'Download your data in CSV format for easy analysis.',
  //     'image': "assets/img/heart.png"
  //   },
  // ];
  List<Map<String, dynamic>> displayedItems = [];

  @override
  void initState() {
    super.initState();
    displayedItems = List.from(widget.item);
  }

  Future<void> _refresh() async {
    setState(() {});
  }

  void search(String query) {
    setState(() {
      if (query.isEmpty) {
        displayedItems = List.from(widget.item);
      } else {
        displayedItems = widget.item
            .where((item) =>
                item['heading'].toLowerCase().contains(query.toLowerCase()) ||
                item['description'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // void navigateToScreen(int index) {
  //   // Implement navigation based on the index
  //   // ...
  // }
  void navigateToScreen(int index, BuildContext context) {
    // Implement navigation based on the index
    switch (index) {
      // case 1:
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => ActivityTrackerScreen()),
      //   );
      // break;
      // case 2:
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => FoodDataList()),
      //   );
      //   break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HealthScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Top10Foods()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WaterTrackerView()),
        );
        break;
      // case 6:
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => showfoodtableListOfUser()),
      //   );
      //   break;
      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ShowProfileDataScreen()),
        );
        break;
      case 8:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeedbackPage()),
        );
        break;
      case 9:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContactUsPage()),
        );
        break;
      // BMICalculator  BMRCalculator ActivityTrackerScreen SuggestHealthyFood HealthRecommendationsPage SleepTrackerSCreen SetReminder
      //MensurationCycleScreen ApiExamplePage

      case 10:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BMICalculator()),
        );
        break;
      case 11:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BMRCalculator()),
        );
        break;
      case 12:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActivityTrackerScreen()),
        );
        break;
      case 13:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SuggestHealthyFood()),
        );
        break;
      case 14:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HealthRecommendationsPage()),
        );
        break;
      case 15:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SleepTrackerSCreen()),
        );
        break;
      case 16:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SetReminder()),
        );
        break;
      case 17:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MensurationCycleScreen()),
        );
        break;
      case 18:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExportToCsv()),
        );
        break;
      case 19:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NutritionEducationPage()),
        );
        break;
      case 20:
        _launchURL('https://www.nin.res.in/dietaryguidelines2024.html');
        break;
      case 21:
        _launchURL('https://www.nin.res.in/RDA_short_Report_2024.html');
        break;
      case 23:
        _launchURL('https://www.nin.res.in/index.html');
        break;
      case 22:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DietryDiary()),
        );
        break;
      // Add cases for other screens
      default:
        break;
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/root');
        return false; // Prevent the back operation
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeManager.themeColor,
          centerTitle: true,
          elevation: 0,
          title: Text(
            Languages.of(context)!.TextAppSearchComponents,
            style: TextStyle(
                color: ThemeManager.themeText,
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: ThemeManager.themeColor,
        body: RefreshIndicator(
          color:
              TColor.secondaryColor1, // Set the color of the refresh indicator
          backgroundColor: TColor.primaryColor1,
          onRefresh: _refresh,
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //           color: ThemeManager
              //               .themeText), // Set the border color to white
              //       borderRadius:
              //           BorderRadius.circular(10.0), // Add rounded corners
              //     ),
              //     child: TextField(
              //       onChanged: search,
              //       style: TextStyle(
              //           color: ThemeManager
              //               .themeText), // Set the text color to white
              //       decoration: InputDecoration(
              //         hintText: 'Search...',
              //         hintStyle: TextStyle(
              //             color: ThemeManager
              //                 .themeText), // Set the hint text color to white
              //         contentPadding: EdgeInsets.all(
              //             10.0), // Add padding inside the TextField
              //         border: InputBorder.none, // Remove the default border
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     onChanged: search,
              //     style: TextStyle(
              //       color: Theme.of(context).textTheme.bodyText1!.color,
              //     ),
              //     decoration: InputDecoration(
              //       hintText: 'Search...',
              //       hintStyle: TextStyle(
              //         color: Theme.of(context).textTheme.caption!.color,
              //       ),
              //       contentPadding: EdgeInsets.all(10.0),
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              // ),
              Center(
                child: Container(
                  width: 314,
                  height: 35.97,
                  decoration: ShapeDecoration(
                    color: ThemeManager.themelightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: TextField(
                    onChanged: search,
                    decoration: InputDecoration(
                      hintText:
                          Languages.of(context)!.labelSearchComponentsHere,
                      hintStyle: TextStyle(
                        color: ThemeManager.themeText.withOpacity(0.8),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: ThemeManager.themeText,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: ThemeManager.themeText),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: displayedItems.length,
                  itemBuilder: (context, index) {
                    //debugPrint('nav historuy ${Navigator.of(context).widget}');

                    bool isEvent = index % 2 == 0;
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigateToScreen(
                                displayedItems[index]['index'], context);
                          },
                          child: individualComponentsOfScreen(
                            fObj: {
                              "name": displayedItems[index]['heading'],
                              "image": displayedItems[index]['image'],
                              "discription": displayedItems[index]
                                  ['description'],
                            },
                          ),
                          //   );
                          // },
                        ),
                        if (index == displayedItems.length - 1)
                          const SizedBox(
                            height: 50,
                          )
                      ],
                    );
                    // GestureDetector(
                    //     onTap: () {
                    //       // Navigate to the respective screen based on the index
                    //       navigateToScreen(
                    //           displayedItems[index]['index'], context);
                    //     },
                    //     child: Container(
                    //       margin: const EdgeInsets.all(5),
                    //       width: media.width * 0.5,
                    //       decoration: BoxDecoration(
                    //           gradient: LinearGradient(
                    //             colors: isEvent
                    //                 ? [
                    //                     TColor.primaryColor2.withOpacity(0.5),
                    //                     TColor.primaryColor1.withOpacity(0.5)
                    //                   ]
                    //                 : [
                    //                     TColor.secondaryColor2.withOpacity(0.5),
                    //                     TColor.secondaryColor1.withOpacity(0.5)
                    //                   ],
                    //           ),
                    //           borderRadius: BorderRadius.circular(25)),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           // Image.asset(
                    //           //   fObj["image"].toString(),
                    //           //   width: media.width * 0.3,
                    //           //   height: media.width * 0.25,
                    //           //   fit: BoxFit.contain,
                    //           // ),
                    //           Padding(
                    //             padding:
                    //                 const EdgeInsets.symmetric(horizontal: 15),
                    //             child: Text(
                    //               displayedItems[index]['heading'],
                    //               style: TextStyle(
                    //                   color: ThemeManager.themeText,
                    //                   fontSize: AppFontSizes .mediumDefault,
                    //                   fontWeight: FontWeight.w500),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding:
                    //                 const EdgeInsets.symmetric(horizontal: 15),
                    //             child: Text(
                    //               displayedItems[index]['description'],
                    //               style: TextStyle(
                    //                   color: ThemeManager.themeText,
                    //                   fontSize: AppFontSizes
                    //                                          .smallDefault),
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             height: 15,
                    //           ),
                    //           Padding(
                    //             padding:
                    //                 const EdgeInsets.symmetric(horizontal: 15),
                    //             child: SizedBox(
                    //               width: 90,
                    //               height: 35,
                    //               child: RoundButton(
                    //                   fontSize: AppFontSizes
                    //                                       .smallDefault,
                    //                   type: isEvent
                    //                       ? RoundButtonType.bgGradient
                    //                       : RoundButtonType.bgSGradient,
                    //                   title: "View",
                    //                   onPressed: () {}),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     )
                    //     // Card(
                    //     //   elevation: 2.0,
                    //     //   child: Column(
                    //     //     mainAxisAlignment: MainAxisAlignment.center,
                    //     //     children: [
                    //     //       Text(displayedItems[index]['heading']),
                    //     //       SizedBox(height: 8.0),
                    //     //       Text(displayedItems[index]['description']),
                    //     //     ],
                    //     //   ),
                    //     // ),
                    //     );
                  },
                ),
              ),
              // sizedBox12(),
            ],
          ),
        ),
      ),
    );
  }
}

class individualComponentsOfScreen extends StatelessWidget {
  final Map fObj;
  const individualComponentsOfScreen({super.key, required this.fObj});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 12),
      child: Container(
        // width: 315,
        // height: 80,
        decoration: ShapeDecoration(
          color: ThemeManager.themelightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
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
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  fObj["image"].toString(),
                  width: 40,
                  height: 40,
                  color: TColor.secondaryColor2,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    SizedBox(
                      width: screenWidth * 0.65,
                      child: Text(
                        fObj["name"],
                        style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.mediumDefault,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.2, // Increase the line height
                        ),
                      ),
                    ),
                    const SizedBox(height: 4), // Add some vertical spacing
                    SizedBox(
                      width: screenWidth * 0.65,
                      child: Text(
                        "${fObj["discription"]}",
                        style: const TextStyle(
                          color: Color(0xFF007BC1),
                          fontSize: AppFontSizes.mediumDefault,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.5, // Increase the line height
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
