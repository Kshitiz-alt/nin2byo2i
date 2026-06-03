import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//thius page will calculate dds and return ui
class DDSResultContainer extends StatefulWidget {
  const DDSResultContainer({super.key});

  @override
  State<DDSResultContainer> createState() => _DDSResultContainerState();
}

class _DDSResultContainerState extends State<DDSResultContainer> {
  final UserProfileController _controller = UserProfileController();

  int ddScore = 0;
  Map<String, dynamic> intakeCategoryNames = {};
  Map<String, dynamic> leftCategoryNames = {};

  @override
  void initState() {
    super.initState();
    fetchDDScore();
  }

  Future<void> fetchDDScore() async {
    var response = await UserProfileController.calculateDDScore();
    if (response != null) {
      setState(() {
        ddScore = response['DDScore'];
        intakeCategoryNames = response['intakeCategoryNames'];
        leftCategoryNames = response['leftCategoryNames'];
      });
    }
  }

  void showDDSRecommendations(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dietary Diversity Score (DDS) is defined as the number of food groups consumed during a given period (1 day). According to the Food and Agriculture Organization (FAO) protocol, DDS is calculated based on 10 food groups. The 10 food groups include cereals & grains, pulses & legumes, green leafy vegetables, other vegetables, roots & tubers, fruits, milk & milk products, meat, poultry and fishes, eggs, nuts and oil seeds (slightly modified from FAO, 2021 guidelines). Each ingredient consumed by the user will be categorized into one of these groups. The number of distinct food groups an individual has consumed within a day will be counted. For example, if someone ate rice, lentils, spinach, and chicken in a day, their count would be 4 (cereals, legumes, green leafy vegetables, and meat). DDS is the sum of the consumed food groups. The DDS score is categorised as poor (≤ 4), good ( 5-6) and Excellent (≥ 7) based on the user's daily food consumption.",
                  style: TextStyle(),
                ),
                // Text(
                //   "Dietary Diversity Score (DDS):",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // Text(
                //   "DDS is defined as the number of food groups consumed during a given period (1 day).",
                //   textAlign: TextAlign.justify,
                // ),
                // SizedBox(height: 10),
                // Text(
                //   "Food Groups (FAO Protocol):",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // Text(
                //   "1. Cereals & Grains\n"
                //   "2. Pulses & Legumes\n"
                //   "3. Green Leafy Vegetables\n"
                //   "4. Other Vegetables\n"
                //   "5. Roots & Tubers\n"
                //   "6. Fruits\n"
                //   "7. Milk & Milk Products\n"
                //   "8. Meat, Poultry, and Fishes\n"
                //   "9. Eggs\n"
                //   "10. Nuts and Oil Seeds",
                //   textAlign: TextAlign.justify,
                // ),
                // SizedBox(height: 10),
                // Text(
                //   "Calculation:",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // Text(
                //   "Each ingredient consumed is categorized into one of these groups. The DDS is the count of distinct food groups an individual has consumed within a day.",
                //   textAlign: TextAlign.justify,
                // ),
                // SizedBox(height: 10),
                // Text(
                //   "Categorization:",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // Text(
                //   "DDS score is categorized as follows:\n"
                //   "- Poor (≤ 4)\n"
                //   "- Good (5-6)\n"
                //   "- Excellent (≥ 7)",
                //   textAlign: TextAlign.justify,
                // ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String result = _calculateDDS(ddScore);
    String message = _getResultMessage(result);

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Your Dietary Diversity Score (DDS)',
            style: TextStyle(
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.bold,
              color: ThemeManager.themeText,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: AppFontSizes.mediumDefault),
              children: [
                TextSpan(
                  text: "Your ",
                  style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    color: ThemeManager.themeText,
                  ),
                ),
                TextSpan(
                  text: "DDS ",
                  style: const TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showDDSRecommendations(context);
                    },
                ),
                TextSpan(
                  text: " $message",
                  style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    color: ThemeManager.themeText,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10),
          // Text(
          //   'Intake Categories:',
          //   style: TextStyle(
          //     fontSize: AppFontSizes.mediumDefault,
          //     fontWeight: FontWeight.bold,
          //     color: ThemeManager.themeText,
          //   ),
          //   textAlign: TextAlign.justify,
          // ),
          // for (var entry in intakeCategoryNames.entries)
          //   Text(
          //     '${entry.key}: ${entry.value}',
          //     style: TextStyle(fontSize: AppFontSizes.mediumDefault),
          //     textAlign: TextAlign.justify,
          //   ),
          const SizedBox(height: 10),
          Text(
            'It is recommended to consume foods from these categories as well:',
            style: TextStyle(
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.bold,
              color: ThemeManager.themeText,
            ),
            textAlign: TextAlign.justify,
          ),
          for (var entry in leftCategoryNames.entries)
            Text(
              //   '${entry.key}: ${entry.value}',
              '* ${entry.value}',
              style: const TextStyle(fontSize: AppFontSizes.mediumDefault),
              textAlign: TextAlign.justify,
            ),
        ],
      ),
    );
  }

  String _calculateDDS(int dds) {
    if (dds <= 4) {
      return 'POOR';
    } else if (dds >= 5 && dds <= 6) {
      return 'GOOD';
    } else {
      return 'EXCELLENT';
    }
  }

  String _getResultMessage(String result) {
    switch (result) {
      case 'POOR':
        return 'is poor. Recommended to consume from other food groups';
      case 'GOOD':
        return 'is good. You may include other food groups in your diet to improve your DDS.';
      case 'EXCELLENT':
        return 'is excellent. You may maintain the same DDS and also try to consume from other food groups ';
      default:
        return '';
    }
  }
}
