import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class RefinedSugarIntakeResultContainer extends StatelessWidget {
  final double sugarIntake;

  const RefinedSugarIntakeResultContainer({super.key, required this.sugarIntake});

  @override
  Widget build(BuildContext context) {
    String result = _calculateSugarIntake(sugarIntake);
    String message = _getResultMessage(result);

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
                    "Type 2 diabetes mellitus usually occurs in adults when the body becomes resistant to insulin or doesn't make enough insulin.",
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
            'Your Refined Sugar Intake: ${sugarIntake.toStringAsFixed(sugarIntake >= 99 ? 0 : 2)}%',
            style: const TextStyle(
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 8),
          // Text(  textAlign: TextAlign.justify,
          //   '${sugarIntake.toStringAsFixed(1)}%',
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
                if (sugarIntake > 10)
                  TextSpan(
                    text: "type 2 diabetes",
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
                if (sugarIntake > 10)
                  const TextSpan(
                    text: " mellitus, weight gain and dental caries.",
                    style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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

  String _calculateSugarIntake(double sugarIntake) {
    if (sugarIntake < 5) {
      return 'EXCELLENT';
    } else if (sugarIntake >= 5 && sugarIntake <= 10) {
      return 'GOOD';
    } else {
      return 'HIGH';
    }
  }

  String _getResultMessage(String result) {
    switch (result) {
      case 'EXCELLENT':
        return "Excellent! Recommended to maintain less than 5% and if any health issues please do consult a doctor.";
      case 'GOOD':
        return "Though your intake is within the recommended levels by WHO, it is suggested to maintain or reduce the added sugar intake to < 5 %.";
      case 'HIGH':
        return "Your sugar consumption is higher than the recommended levels/percentage. It is advised to reduce the intake of refined sugars available in  various forms to less than 5%. Apart from this, you may also consult a doctor for proper management. The World Health Organization in 2003 recommended that not more than 10% of total energy should be from free sugars/added sugars. Higher intakes of sugar sweetened beverages/added sugars is associated with higher incidence of type 2 diabetes mellitus, weight gain and dental caries.  ";
      default:
        return '';
    }
  }
}
