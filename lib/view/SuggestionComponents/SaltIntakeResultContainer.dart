import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class SaltIntakeResultContainer extends StatelessWidget {
  final double saltIntake;

  const SaltIntakeResultContainer({super.key, required this.saltIntake});
  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(textAlign: TextAlign.justify, "AMDR Recommendations"),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.justify,
                  "Recommendations for Macronutrient Intake (Carbohydrates, Fat, and Protein) provided in the context of a complete diet (RDA, 2020):",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.justify,
                  "The AMDR expresses intake recommendations as a percentage of total caloric intake.",
                ),
                SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.justify,
                  "Cancer:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  textAlign: TextAlign.justify,
                  "Cancer is a large group of diseases that can start in almost any organ or tissue of the body when abnormal cells grow uncontrollably, go beyond their usual boundaries to invade adjoining parts of the body and/or spread to other organs.",
                ),
                SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.justify,
                  "Diabetes:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  textAlign: TextAlign.justify,
                  "Diabetes is a chronic metabolic disease that occurs when the body can't effectively use insulin, or the pancreas doesn't produce enough insulin.",
                ),
                SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.justify,
                  "Cardiovascular Diseases:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  textAlign: TextAlign.justify,
                  "Cardiovascular diseases are a group of disorders of the heart and blood vessels and include coronary heart disease, cerebrovascular disease, rheumatic heart disease, and other conditions.",
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(textAlign: TextAlign.justify, "Close"),
            ),
          ],
        );
      },
    );
  }

  void showModal3(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(  textAlign: TextAlign.justify,"AMDR Recommendations"),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.justify,
                  "Hypertension, also known as high or raised blood pressure, is a condition in which the blood vessels have persistently raised pressure.",
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(textAlign: TextAlign.justify, "Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String result = _calculateSaltIntake(saltIntake);
    String message = _getResultMessage(result);

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white, // You can change the color
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.justify,
            'Your Salt Intake: ${saltIntake.toStringAsFixed(saltIntake >= 99 ? 0 : 2)} g',
            style: const TextStyle(
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 8),
          // Text(  textAlign: TextAlign.justify,
          //   '${saltIntake.toStringAsFixed(1)}g',
          //   style: TextStyle(fontSize: AppFontSizes.mediumDefault, fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              // text: "As per the ",
              style: const TextStyle(fontSize: AppFontSizes.mediumDefault),
              children: [
                TextSpan(
                  text: message,
                  style: const TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    color: Colors.black,
                  ),
                ),
                if (saltIntake > 5)
                  TextSpan(
                    text: "hypertension. ",
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Code to show the modal when "AMDR" is clicked
                        showModal3(
                            context); // You need to implement showModal function to show your modal
                      },
                  ),
              ],
            ),
          ),

          // Text(
          //   textAlign: TextAlign.justify,
          //   message,
          //   style: TextStyle(fontSize: AppFontSizes.mediumDefault),
          // ),
        ],
      ),
    );
  }

  String _calculateSaltIntake(double saltIntake) {
    if (saltIntake < 5) {
      return 'EXCELLENT';
    } else {
      return 'HIGH';
    }
  }

  String _getResultMessage(String result) {
    switch (result) {
      case 'EXCELLENT':
        return "Excellent! Recommended to maintain less than 5 g.";
      case 'HIGH':
        return "Your salt consumption is higher than the recommended level. It is advised to reduce the intake of salt and other highly processed foods with high salt content including commercially available ready to eat foods. High salt intake can significantly increase the risk for ";
      default:
        return '';
    }
  }
}
