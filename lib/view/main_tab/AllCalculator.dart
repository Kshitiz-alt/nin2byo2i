import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Help%20Supports/BMICalculator.dart';
import 'package:nin2byo2i/Help%20Supports/BMRCalculator.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/OtherActivity/StopWatchSCreen.dart';
import 'package:intl/intl.dart';
import 'package:nin2byo2i/view/main_tab/HipWaistTrackerPage.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//page contain all calulator of app bmi ,bmr, calorie etc
class AllCalculator extends StatefulWidget {
  const AllCalculator({super.key});

  @override
  _AllCalculatorState createState() => _AllCalculatorState();
}

class _AllCalculatorState extends State<AllCalculator> {
  Future<void> _refresh() async {}

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: TColor.secondaryColor1, // Set the color of the refresh indicator
      backgroundColor: TColor.primaryColor1,
      onRefresh: _refresh,
      child: Scaffold(
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
            Languages.of(context)!.mainlabelHealthCalculator,
            style: TextStyle(
                color: ThemeManager.themeText,
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.w700),
          ),
          // actions: [
          //   InkWell(
          //     onTap: () {},
          //     child: Container(
          //       margin: EdgeInsets.all(8),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sizedBox30(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BMICalculator()),
                          );
                        }, // onTap: () => showActivityData(filteredActivities[i + 1]),
                        child: Container(
                          width: media.width * 0.4,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: TColor.primaryColor1.withOpacity(0.3)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Container(
                                    // width: 80,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ThemeManager
                                          .themelightColor, // Set the background color for the circular container
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/bmi.png",
                                      ),
                                    ),
                                  ),
                                ),
                                sizedBox12(),
                                Text(
                                  Languages.of(context)!.mainlabelBMICalculator,
                                  style:
                                      TextStyle(color: ThemeManager.themeText),
                                ),
                                sizedBox12(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Tooltip(
                        message: 'BMI Information',
                        child: IconButton(
                          icon: Icon(
                            Icons.info,
                            color: ThemeManager.themeText,
                          ),
                          onPressed: () {
                            // Show BMI information here
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('BMI Information'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'BMI Information:',
                                        style: TextStyle(
                                          fontSize: AppFontSizes.mediumDefault,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      const Text(
                                        'BMI is defined as a person’s weight in kilograms divided by the square of the person’s height in meters (kg/m2). The BMI ranges are based on the effect excessive body fat has on disease and death and are reasonably well related to adiposity. BMI was developed as a risk indicator of disease; as BMI increases, so does the risk for some diseases. Some common conditions related to overweight and obesity include: premature death, cardiovascular diseases, high blood pressure, osteoarthritis, some cancers, and diabetes.',
                                        style: TextStyle(
                                          fontSize: AppFontSizes.mediumDefault,
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      const Text(
                                        'BMI Nutritional status',
                                        style: TextStyle(
                                          fontSize: AppFontSizes.mediumDefault,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      Table(
                                        border: TableBorder.all(),
                                        children: const [
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text('BMI'),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text(
                                                      'Nutritional status'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text('Below 18.5'),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text('Underweight'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text('18.5–24.9'),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text('Normal weight'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text('25.0–29.9'),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text('Pre-obesity'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text('30.0–34.9'),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child:
                                                      Text('Obesity class I'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text('35.0–39.9'),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child:
                                                      Text('Obesity class II'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child: Text('Above 40'),
                                                ),
                                              ),
                                              TableCell(
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(8.0),
                                                  child:
                                                      Text('Obesity class III'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        // onTap: () => showActivityData(filteredActivities[i + 1]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BMRCalculator()),
                          );
                        },
                        child: Container(
                          width: media.width * 0.4,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: TColor.primaryColor1.withOpacity(0.3)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Container(
                                    // width: 80,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ThemeManager
                                          .themelightColor, // Set the background color for the circular container
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: 120,
                                        child: Image.asset(
                                          "assets/images/calculator.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                sizedBox12(),
                                Text(
                                  Languages.of(context)!.mainlabelBMRCalculator,
                                  style:
                                      TextStyle(color: ThemeManager.themeText),
                                ),
                                sizedBox12(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Tooltip(
                        message: 'BMR Information',
                        child: IconButton(
                          icon: Icon(
                            Icons.info,
                            color: ThemeManager.themeText,
                          ),
                          onPressed: () {
                            // Show BMR information here
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('BMR Information'),
                                content: const Text(
                                  'Basal Metabolic Rate (BMR) is the rate at which a person expends energy while at rest',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          // onTap: () => showActivityData(filteredActivities[i + 1]),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HipWaistTrackerPage()),
                            );
                          },
                          child: Container(
                            width: media.width * 0.4,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: TColor.primaryColor1.withOpacity(0.3)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      // width: 80,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ThemeManager
                                            .themelightColor, // Set the background color for the circular container
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/img/hip.jpeg",
                                        ),
                                      ),
                                    ),
                                  ),
                                  sizedBox12(),
                                  Center(
                                    child: SizedBox(
                                      width: 100,
                                      child: Text(
                                        "Hip and Waist Circumference",
                                        style: TextStyle(
                                            color: ThemeManager.themeText),
                                      ),
                                    ),
                                  ),
                                  sizedBox12(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
