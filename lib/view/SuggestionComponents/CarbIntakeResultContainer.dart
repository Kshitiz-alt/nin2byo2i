import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//custom ui for carbohydrate
// ignore: must_be_immutable
class CarbIntakeResultContainer extends StatelessWidget {
  double carbIntake;

  CarbIntakeResultContainer({super.key, required this.carbIntake});
  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              textAlign: TextAlign.justify,
              "Acceptable Macronutrient Distribution Ranges (AMDR) "),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    textAlign: TextAlign.justify,
                    "AMDR is the recommendations for macronutrient intake (Carbohydrates, fat and protein) provided in the context of a complete diet (RDA, 2020). The AMDR expresses intake recommendations as a percentage of total caloric intake."),
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
    carbIntake = carbIntake.isNaN ? 0 : carbIntake;
    String result = _calculateCarbIntake(carbIntake);
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
            'Your Carbohydrate Intake: ${carbIntake.toStringAsFixed(carbIntake >= 99 ? 0 : 2)}%',
            style: const TextStyle(
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 8),
          // Text(  textAlign: TextAlign.justify,
          //   '${carbIntake.toStringAsFixed(1)}%',
          //   style: TextStyle(fontSize: AppFontSizes.mediumDefault, fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              // text: "As per the ",
              style: const TextStyle(fontSize: AppFontSizes.mediumDefault),
              children: [
                const TextSpan(
                  text: "As per the ",
                  style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: "AMDR, ",
                  style: const TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Code to show the modal when "AMDR" is clicked
                      showModal(
                          context); // You need to implement showModal function to show your modal
                    },
                ),
                TextSpan(
                  text: message,
                  style: const TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.justify,
          ),

          // Text.rich(
          //   TextSpan(
          //     text: "As per the ",
          //     style: TextStyle(fontSize: AppFontSizes .mediumDefault),
          //     children: [
          //       TextSpan(
          //         text: "AMDR, ",
          //         style: TextStyle(
          //           fontSize: AppFontSizes .mediumDefault,
          //           fontWeight:
          //               FontWeight.bold, // Example: Making the AMDR text bold
          //           color: Colors.blue, // Example: Setting color to blue
          //         ),
          //       ),
          //       TextSpan(
          //         text: "${message}",
          //         style: TextStyle(
          //           fontSize: AppFontSizes .mediumDefault,
          //           // You can specify additional styles for the message variable if needed
          //         ),
          //       ),
          //     ],
          //   ),
          //   textAlign: TextAlign.start,
          // ),
        ],
      ),
    );
  }

  String _calculateCarbIntake(double carbIntake) {
    if (carbIntake < 50) {
      return 'LOW';
    } else if (carbIntake >= 50 && carbIntake <= 60) {
      return 'NORMAL';
    } else {
      return 'HIGH';
    }
  }

  String _getResultMessage(String result) {
    switch (result) {
      //  ${carbIntake.toStringAsFixed(carbIntake >= 99 ? 0 : 2)}%
      case 'LOW':
        return "the energy consumption from carbohydrates should be 50-55%. Whereas, your consumption is ${carbIntake.toStringAsFixed(carbIntake >= 99 ? 0 : 2)}% which is below the normal AMDR range. You may include more foods rich in complex carbohydrates like whole grains, pulses, legumes and vegetables. Carbohydrate rich foods provide the required  fibre and phytochemicals. They  are important to maintain glycemic homeostasis and gastrointestinal integrity and function.";
      case 'NORMAL':
        return "your energy consumption from CHO is ${carbIntake.toStringAsFixed(carbIntake >= 99 ? 0 : 2)}% which is within the normal AMDR range (50-55%) ";
      case 'HIGH':
        return "your energy consumption from CHO is ${carbIntake.toStringAsFixed(carbIntake >= 99 ? 0 : 2)}% which is higher than the normal AMDR range (50-55%). You need to reduce the intake of foods rich in refined carbohydrates such as refined cereals and sugars. It is suggested to consume carbohydrates within the suggested ranges of AMDR to maintain a healthy diet pattern and therby avoid undersirable health effects.";
      default:
        return '';
    }
  }
}
