// import 'package:flutter/material.dart';
// import 'package:nin2byo2i/Common/ThemeColor.dart';
// import 'package:nin2byo2i/Common/colo_extension.dart';
// import 'package:nin2byo2i/Help%20Supports/BMICalculator.dart';
// import 'package:nin2byo2i/Help%20Supports/BMRCalculator.dart';
// import 'package:nin2byo2i/Help%20Supports/ContactUs.dart';
// import 'package:nin2byo2i/Help%20Supports/FeedBack.dart';
// import 'package:nin2byo2i/Help%20Supports/HelthRecommandation.dart';
// import 'package:nin2byo2i/Help%20Supports/SuggestHealthyFood.dart';
// import 'package:nin2byo2i/Language/localization/Language/languages.dart';
// import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
// import 'package:nin2byo2i/temp3.dart';
// import 'package:nin2byo2i/view/MensurationData/MensurationCycle.dart';
// import 'package:nin2byo2i/view/ScreensAPP/setnotification.dart';
// import 'package:nin2byo2i/view/workout_tracker/SleepTrackerSCreen.dart';
// import 'package:nin2byo2i/view/workout_tracker/activitydata.dart';
// import 'package:nin2byo2i/common_widget/round_button.dart';
// import 'package:nin2byo2i/view/Food/Top!0FoodList.dart';
// import 'package:nin2byo2i/view/Food/showListOfUserFoodTable.dart';
// import 'package:nin2byo2i/view/HealthTrends/HealthTrendBottomNav.dart';
// import 'package:nin2byo2i/view/workout_tracker/activity_tracker_view.dart';
// import 'package:nin2byo2i/view/profile/ShowUserProileData.dart';

// class SearchComponents extends StatefulWidget {
//   // final List<Map<String, dynamic>> item;
//   // SearchComponents({required this.item});
//   @override
//   _SearchComponentsState createState() => _SearchComponentsState();
// }

// class _SearchComponentsState extends State<SearchComponents> {
//   List<Map<String, dynamic>> allItems = [
//     {
//       'index': 3,
//       'heading': 'Blood | Oxygen | Heart',
//       'description': 'Measure vital signs and track overall health.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 4,
//       'heading': 'Top 10 Food',
//       'description':
//           'Discover recommended foods to maintain a healthy lifestyle.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 5,
//       'heading': 'Water Track',
//       'description': 'Set and achieve daily fitness hydration goals.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 7,
//       'heading': 'Personal Details',
//       'description': 'Manage and update personal information securely.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 8,
//       'heading': 'Feedback',
//       'description': 'Share your thoughts and suggestions with us.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 9,
//       'heading': 'Contact Us',
//       'description': 'Reach customer support and get in touch with us.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 10,
//       'heading': 'BMI Calculator',
//       'description': 'Calculate your Body Mass Index for health insights.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 11,
//       'heading': 'BMR Calculator',
//       'description':
//           'Calculate your Basal Metabolic Rate for fitness planning.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 12,
//       'heading': 'Running Jogging Steps',
//       'description':
//           'Track your running and jogging steps for a healthy lifestyle.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 13,
//       'heading': 'Healthy Diet Chart',
//       'description':
//           'Access a comprehensive chart for a healthy diet overview.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 14,
//       'heading': 'Healthy Recommendation',
//       'description': 'Receive personalized health recommendations.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 15,
//       'heading': 'Sleep Tracker',
//       'description': 'Track your sleep patterns and improve sleep quality.',
//       'image': "assets/img/heart.png"
//     },
//     {
//       'index': 16,
//       'heading': 'Set Reminder',
//       'description': 'Set reminders for health and fitness activities.',
//       'image': "assets/img/heart.png"
//     },
//     // {
//     //   'index': 17,
//     //   'heading': 'Menstruation Cycle',
//     //   'description':
//     //       'Track and manage your menstrual cycle for better insights.',
//     //   'image': "assets/img/heart.png"
//     // },
//     {
//       'index': 18,
//       'heading': 'CSV Download',
//       'description': 'Download your data in CSV format for easy analysis.',
//       'image': "assets/img/heart.png"
//     },
//   ];

//   List<Map<String, dynamic>> displayedItems = [];

//   @override
//   void initState() {
//     super.initState();

//     displayedItems = List.from(allItems);
//   }

//   // void fetchinitData() async {
//   //   setState(() {
//   //     allItems = [
//   //       {
//   //         'index': 3,
//   //         'heading': Languages.of(context)!.headingBloodOxygenHeart,
//   //         'description': Languages.of(context)!.labelBloodOxygenHeart,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 4,
//   //         'heading': Languages.of(context)!.headingTop10Food,
//   //         'description': Languages.of(context)!.labelTop10FoodS,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 5,
//   //         'heading': Languages.of(context)!.headingWaterTrack,
//   //         'description': Languages.of(context)!.labelWaterTrack,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 7,
//   //         'heading': Languages.of(context)!.headingPersonalDetails,
//   //         'description': Languages.of(context)!.labelPersonalDetails,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 8,
//   //         'heading': Languages.of(context)!.headingFeedback,
//   //         'description': Languages.of(context)!.labelFeedbackS,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 9,
//   //         'heading': Languages.of(context)!.headingContactUs,
//   //         'description': Languages.of(context)!.labelContactUsS,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 10,
//   //         'heading': Languages.of(context)!.headingBMICalculator,
//   //         'description': Languages.of(context)!.labelBMICalculator,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 11,
//   //         'heading': Languages.of(context)!.headingBMRCalculator,
//   //         'description': Languages.of(context)!.labelBMRCalculator,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 12,
//   //         'heading': Languages.of(context)!.headingRunningJoggingSteps,
//   //         'description': Languages.of(context)!.labelRunningJoggingSteps,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 13,
//   //         'heading': Languages.of(context)!.headingHealthyDietChart,
//   //         'description': Languages.of(context)!.labelHealthyDietChart,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 14,
//   //         'heading': Languages.of(context)!.headingHealthyRecommendation,
//   //         'description': Languages.of(context)!.labelHealthyRecommendation,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 15,
//   //         'heading': Languages.of(context)!.headingSleepTracker,
//   //         'description': Languages.of(context)!.labelSleepTracker,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       {
//   //         'index': 16,
//   //         'heading': Languages.of(context)!.headingSetReminder,
//   //         'description': Languages.of(context)!.labelSetReminder,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //       // {
//   //       //   'index': 17,
//   //       //   'heading': 'Menstruation Cycle',
//   //       //   'description':
//   //       //       'Track and manage your menstrual cycle for better insights.',
//   //       //   'image': "assets/img/heart.png"
//   //       // },
//   //       {
//   //         'index': 18,
//   //         'heading': Languages.of(context)!.headingCSVDownload,
//   //         'description': Languages.of(context)!.labelCSVDownload,
//   //         'image': "assets/img/heart.png"
//   //       },
//   //     ];

//   //     displayedItems = List.from(allItems);
//   //   });
//   // }

//   Future<void> _refresh() async {
//     setState(() {});
//   }

//   void search(String query) {
//     debugPrint('Search Query: $query');
//     setState(() {
//       if (query.isEmpty) {
//         displayedItems = List.from(allItems);
//       } else {
//         displayedItems = allItems
//             .where((item) =>
//                 item['heading'].toLowerCase().contains(query.toLowerCase()) ||
//                 item['description'].toLowerCase().contains(query.toLowerCase()))
//             .toList();
//       }
//     });
//   }

//   // void navigateToScreen(int index) {
//   //   // Implement navigation based on the index
//   //   // ...
//   // }
//   void navigateToScreen(int index, BuildContext context) {
//     // Implement navigation based on the index
//     switch (index) {
//       // case 1:
//       //   Navigator.push(
//       //     context,
//       //     MaterialPageRoute(builder: (context) => ActivityTrackerScreen()),
//       //   );
//       // break;
//       // case 2:
//       //   Navigator.push(
//       //     context,
//       //     MaterialPageRoute(builder: (context) => FoodDataList()),
//       //   );
//       //   break;
//       case 3:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HealthScreen()),
//         );
//         break;
//       case 4:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => Top10Foods()),
//         );
//         break;
//       case 5:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => WaterTrackerView()),
//         );
//         break;
//       // case 6:
//       //   Navigator.push(
//       //     context,
//       //     MaterialPageRoute(builder: (context) => showfoodtableListOfUser()),
//       //   );
//       //   break;
//       case 7:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ShowProfileDataScreen()),
//         );
//         break;
//       case 8:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => FeedbackPage()),
//         );
//         break;
//       case 9:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ContactUsPage()),
//         );
//         break;
//       // BMICalculator  BMRCalculator ActivityTrackerScreen SuggestHealthyFood HealthRecommendationsPage SleepTrackerSCreen SetReminder
//       //MensurationCycleScreen ApiExamplePage

//       case 10:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => BMICalculator()),
//         );
//         break;
//       case 11:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => BMRCalculator()),
//         );
//         break;
//       case 12:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ActivityTrackerScreen()),
//         );
//         break;
//       case 13:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => SuggestHealthyFood()),
//         );
//         break;
//       case 14:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HealthRecommendationsPage()),
//         );
//         break;
//       case 15:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => SleepTrackerSCreen()),
//         );
//         break;
//       case 16:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => SetReminder()),
//         );
//         break;
//       case 17:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MensurationCycleScreen()),
//         );
//         break;
//       case 18:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => ApiExamplePage()),
//         );
//         break;
//       // Add cases for other screens
//       default:
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // fetchinitData();
//     var media = MediaQuery.of(context).size;
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushNamed(context, '/root');
//         return false; // Prevent the back operation
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: ThemeManager.themeColor,
//           centerTitle: true,
//           elevation: 0,
//           leading: InkWell(
//             onTap: () {
//               Navigator.pushNamed(context, '/root');
//             },
//             child: Container(
//               margin: const EdgeInsets.all(8),
//               height: 40,
//               width: 40,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: ThemeManager.themelightColor,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Image.asset(
//                 "assets/img/black_btn.png",
//                 width: 15,
//                 height: 15,
//                 color: ThemeManager.themeText,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           title: Text(
//             Languages.of(context)!.labelSearchComponents,
//             style: TextStyle(
//               color: ThemeManager.themeText,
//               fontSize: AppFontSizes.mediumDefault,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//         backgroundColor: ThemeManager.themeColor,
//         body: RefreshIndicator(
//           color: Colors.purple,
//           backgroundColor: Colors.white,
//           onRefresh: _refresh,
//           child: Expanded(
//             child:
//                 //  ListView.builder(
//                 //   itemCount: displayedItems.length,
//                 //   itemBuilder: (context, index) {
//                 //     return
//                 SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Center(
//                     child: Container(
//                       width: 314,
//                       height: 35.97,
//                       decoration: ShapeDecoration(
//                         color: ThemeManager.themelightColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       child: TextField(
//                         onChanged: search,
//                         decoration: InputDecoration(
//                           hintText:
//                               Languages.of(context)!.labelSearchComponentsHere,
//                           hintStyle: TextStyle(
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                           prefixIcon: Icon(
//                             Icons.search,
//                             color: ThemeManager.themeText,
//                           ),
//                           border: InputBorder.none,
//                         ),
//                         style: TextStyle(color: ThemeManager.themeText),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   for (int i = 0; i < displayedItems.length; i++)
//                     GestureDetector(
//                       onTap: () {
//                         navigateToScreen(displayedItems[i]['index'], context);
//                       },
//                       child: individualComponentsOfScreen(
//                         fObj: {
//                           "name": displayedItems[i]['heading'],
//                           "image": displayedItems[i]['image'],
//                           "discription": displayedItems[i]['description'],
//                         },
//                       ),
//                       //   );
//                       // },
//                     ),
//                   sizedBox30(),
//                   sizedBox30()
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class individualComponentsOfScreen extends StatelessWidget {
//   final Map fObj;
//   const individualComponentsOfScreen({super.key, required this.fObj});

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, right: 20, top: 12),
//       child: Container(
//         // width: 315,
//         // height: 80,
//         decoration: ShapeDecoration(
//           color: ThemeManager.themelightColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           shadows: [
//             BoxShadow(
//               color: Color(0x111D1617),
//               blurRadius: 40,
//               offset: Offset(0, 10),
//               spreadRadius: 0,
//             )
//           ],
//         ),
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(width: 10),
//               SizedBox(
//                 width: 40,
//                 height: 40,
//                 child: Image.asset(
//                   fObj["image"].toString(),
//                   width: 40,
//                   height: 40,
//                   color: TColor.secondaryColor2,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               SizedBox(width: 15),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment:
//                       CrossAxisAlignment.start, // Align text to the left
//                   children: [
//                     SizedBox(
//                       width: screenWidth * 0.65,
//                       child: Text(
//                         fObj["name"],
//                         style: TextStyle(
//                           color: ThemeManager.themeText,
//                           fontSize: AppFontSizes .mediumDefault,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w500,
//                           height: 1.2, // Increase the line height
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 4), // Add some vertical spacing
//                     SizedBox(
//                       width: screenWidth * 0.65,
//                       child: Text(
//                         "${fObj["discription"]}",
//                         style: TextStyle(
//                           color: TColor.primaryColor1,
//                           fontSize: AppFontSizes .mediumDefault,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w400,
//                           height: 1.5, // Increase the line height
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // final List<Map<String, dynamic>> allItems = [
// //     // {
// //     //   'index': 1,
// //     //   'heading': 'Activity tracker',
// //     //   'description': 'Track daily activities, monitor progress.',
// //     //   'image': "assets/img/heart.png"
// //     // },
// //     // {
// //     //   'index': 2,
// //     //   'heading': 'Menstruation tracker',
// //     //   'description': 'Record menstrual cycle, receive insights.'
// //     // },
// //     {
// //       'index': 3,
// //       'heading': 'Blood | Oxygen | Heart',
// //       'description': 'Measure vital signs, track health.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 4,
// //       'heading': 'Top 10 Food',
// //       'description': 'Discover recommended foods, stay healthy.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 5,
// //       'heading': 'Water Track',
// //       'description': 'Set, achieve fitness goals daily.',
// //       'image': "assets/img/heart.png"
// //     },
// //     // {
// //     //   'index': 6,
// //     //   'heading': 'Food Table',
// //     // 'description': 'View nutritional info in comprehensive table.'
// //     // },
// //     {
// //       'index': 7,
// //       'heading': 'Personal Details',
// //       'description': 'Manage, update personal information.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 8,
// //       'heading': 'Feedback',
// //       'description': 'Share thoughts, suggestions with us.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 9,
// //       'heading': 'Contact Us',
// //       'description': 'Reach customer support, contact us.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 10,
// //       'heading': 'BMI Calculator',
// //       'description': 'Reach customer support, contact us.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 11,
// //       'heading': 'BMR Calculator',
// //       'description': 'Reach customer support, contact us.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 12,
// //       'heading': 'Runing Jogging Steps',
// //       'description': 'Reach customer support, contact us.',
// //       'image': "assets/img/heart.png"

// //     },
// //     {
// //       'index': 13,
// //       'heading': 'Healthy Diet Chart',
// //       'description': 'Reach customer support, contact us.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 14,
// //       'heading': 'Healthy Recommandation',
// //       'description': 'Reach customer support, contact us.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 15,
// //       'heading': 'Sleep Tracker',
// //       'description': 'Reach customer support, contact us.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 16,
// //       'heading': 'Set Reminder',
// //       'description': 'Reach customer support, contact us.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 17,
// //       'heading': 'Mensuration Cycle ',
// //       'description': 'Reach customer support, contact us.',
// //       'image': "assets/img/heart.png"
// //     },
// //     {
// //       'index': 18,
// //       'heading': 'Csv Download ',
// //       'description': 'Reach customer support, contact us.',
// //       'image': "assets/img/heart.png"
// //     },
// //   ];




