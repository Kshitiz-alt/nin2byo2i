import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

// ignore: must_be_immutable
class ProteinIntakeResultContainer extends StatelessWidget {
  double proteinIntake;

  ProteinIntakeResultContainer({super.key, required this.proteinIntake});

  @override
  Widget build(BuildContext context) {
    proteinIntake = proteinIntake.isNaN ? 0 : proteinIntake;
    String result = _calculateProteinIntake(proteinIntake);
    String message = _getResultMessage(result);
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
            'Your Protein Intake: ${proteinIntake.toStringAsFixed(proteinIntake >= 99 ? 0 : 2)}%',
            style: const TextStyle(
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.justify,
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
          ),
        ],
      ),
    );
  }

  String _calculateProteinIntake(double proteinIntake) {
    if (proteinIntake < 7.5) {
      return 'LOW';
    } else if (proteinIntake >= 7.5 && proteinIntake <= 20) {
      return 'NORMAL';
    } else {
      return 'HIGH';
    }
  }

  String _getResultMessage(String result) {
    //    ${proteinIntake.toStringAsFixed(proteinIntake >= 99 ? 0 : 2)}%
    switch (result) {
      case 'LOW':
        return "the energy consumption from protein should be 15-20%. Your consumption is ${proteinIntake.toStringAsFixed(proteinIntake >= 99 ? 0 : 2)}% which is below the normal AMDR range. You may include more foods rich in good quality protein. Good quality protein can be obtained by consuming cereals and pulses in a ratio of 3:1 with 300 ml of milk/curd on a dialy basis. Non vegetarians can consume flesh foods in moderation (refer to https://www.nin.res.in/dietaryguidelines/index.html). Dietary proteins provide amino acids for the synthesis of body proteins, which are structural and biologically active proteins (i.e. enzymes, hormones), and for other biologically important nitrogenous compounds. In an adult, dietary protein is essential for synthesis of new proteins to replace those that are being broken down. ";
      case 'NORMAL':
        return "the energy consumption from protein should be 15-20%. However, your consumption is ${proteinIntake.toStringAsFixed(proteinIntake >= 99 ? 0 : 2)}% which is within the normal AMDR range.";
      case 'HIGH':
        return "the energy consumption from protein should not be more than 20%. Your consumption is ${proteinIntake.toStringAsFixed(proteinIntake >= 99 ? 0 : 2)}% which is higher than the normal range. It is adviced to reduce your protein intake. With an increase in protein intakes there is a related increase in concentrations of nitrogenous substances, especially urea, both in the blood and urine, which form a part of the body's regulatory process. There can be a number of undesirable effects with very high intakes.";
      default:
        return '';
    }
  }
}
