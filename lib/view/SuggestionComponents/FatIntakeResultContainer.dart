// import 'package:flutter/material.dart';
// import 'package:nin2byo2i/Common/colo_extension.dart';

// class FatIntakeResultContainer extends StatelessWidget {
//   double fatIntake;

//   FatIntakeResultContainer({required this.fatIntake});

//   @override
//   Widget build(BuildContext context) {
//     fatIntake = fatIntake.isNaN ? 0 : fatIntake;
//     String result = _calculateFatIntake(fatIntake);
//     String message = _getResultMessage(result);

//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: TColor.primaryColor1, // You can change the color
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(  textAlign: TextAlign.justify,
//             'Your Fat Intake: ${fatIntake.toStringAsFixed(1)}%',
//             style: TextStyle(fontSize: AppFontSizes.mediumDefault, fontWeight: FontWeight.bold),
//           ),
//           // SizedBox(height: 8),
//           // Text(  textAlign: TextAlign.justify,
//           //   '${fatIntake.toStringAsFixed(1)}%',
//           //   style: TextStyle(fontSize: AppFontSizes.mediumDefault, fontWeight: FontWeight.bold),
//           // ),
//           SizedBox(height: 10),
//           Text(  textAlign: TextAlign.justify,
//             message,
//             textAlign: TextAlign.start,
//             style: TextStyle(fontSize: AppFontSizes .mediumDefault),
//           ),
//         ],
//       ),
//     );
//   }

//   String _calculateFatIntake(double fatIntake) {
//     if (fatIntake < 20) {
//       return 'LOW';
//     } else if (fatIntake >= 20 && fatIntake <= 30) {
//       return 'NORMAL';
//     } else {
//       return 'HIGH';
//     }
//   }

//   String _getResultMessage(String result) {
//     switch (result) {
//       case 'LOW':
//         return "As per the AMDR, the energy consumption from fat is ${fatIntake.toStringAsFixed(1)}% (provide the user's fat%) which is below the normal AMDR range (20-30%). It is advised to include more foods rich in dietary fat. Dietary fat is essential as it provides energy and essential fatty acids, serves as a vehicle for fat-soluble vitamins and facilitates their absorption.";
//       case 'NORMAL':
//         return "As per the AMDR, the energy consumption from fat is ${fatIntake.toStringAsFixed(1)}% (provide the user's fat%) which is within the normal AMDR range (20-30%).";
//       case 'HIGH':
//         return "As per the AMDR, the energy consumption from fat is ${fatIntake.toStringAsFixed(1)}% (provide the user's fat%) which is above 30%. It is advised to reduce the intake of foods rich in fat. High fat intake can increase the risk of diet-related non-communicable diseases including cancers, cardiovascular diseases, and diabetes.";
//       default:
//         return '';
//     }
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

// ignore: must_be_immutable
class FatIntakeResultContainerI extends StatelessWidget {
  double fatIntake;

  FatIntakeResultContainerI({super.key, required this.fatIntake});

  @override
  Widget build(BuildContext context) {
    fatIntake = fatIntake.isNaN ? 0 : fatIntake;
    String result = _calculateFatIntake(fatIntake);
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

    void showModal1(BuildContext context) {
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
                    "Cancer:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    textAlign: TextAlign.justify,
                    "Cancer is a large group of diseases that can start in almost any organ or tissue of the body when abnormal cells grow uncontrollably, go beyond their usual boundaries to invade adjoining parts of the body and/or spread to other organs.",
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

    void showModal2(BuildContext context) {
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
                    "Diabetes:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    textAlign: TextAlign.justify,
                    "Diabetes is a chronic metabolic disease that occurs when the body can't effectively use insulin, or the pancreas doesn't produce enough insulin.",
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
            'Your Fat Intake: ${fatIntake.toStringAsFixed(1)}%',
            style: const TextStyle(
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 8),
          // Text(  textAlign: TextAlign.justify,
          //   '${fatIntake.toStringAsFixed(1)}%',
          //   style: TextStyle(fontSize: AppFontSizes.mediumDefault, fontWeight: FontWeight.bold),
          // ),
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
                // if (fatIntake > 30)
                //   TextSpan(
                //     text: "AMDR, ",
                //     style: TextStyle(
                //       fontSize: AppFontSizes .mediumDefault,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.blue,
                //     ),
                //     recognizer: TapGestureRecognizer()
                //       ..onTap = () {
                //         // Code to show the modal when "AMDR" is clicked
                //         showModal(
                //             context); // You need to implement showModal function to show your modal
                //       },
                //   ),
                if (fatIntake > 30)
                  TextSpan(
                    text: "cancers, ",
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Code to show the modal when "AMDR" is clicked
                        showModal1(
                            context); // You need to implement showModal function to show your modal
                      },
                  ),
                if (fatIntake > 30)
                  TextSpan(
                    text: "cardiovascular diseases ",
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Code to show the modal when "AMDR" is clicked
                        showModal2(
                            context); // You need to implement showModal function to show your modal
                      },
                  ),
                if (fatIntake > 30)
                  const TextSpan(
                    text: "and ",
                    style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      color: Colors.black,
                    ),
                  ),
                if (fatIntake > 30)
                  TextSpan(
                    text: "diabetes.",
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
          // Text(  textAlign: TextAlign.justify,
          //   message,
          //   textAlign: TextAlign.start,
          //   style: TextStyle(fontSize: AppFontSizes .mediumDefault),
          // ),
        ],
      ),
    );
  }

  String _calculateFatIntake(double fatIntake) {
    if (fatIntake < 20) {
      return 'LOW';
    } else if (fatIntake >= 20 && fatIntake <= 30) {
      return 'NORMAL';
    } else {
      return 'HIGH';
    }
  }

  String _getResultMessage(String result) {
    switch (result) {
      case 'LOW':
        return "your energy consumption from fat is ${fatIntake.toStringAsFixed(fatIntake >= 99 ? 0 : 2)}% which is below the normal AMDR range (20-30 %). It is adviced to include foods such as nuts and oilseeds in your diet. Dietary fat is essential as it provides energy and essential fatty acids, serves as a vehicle for fat-soluble vitamins and facilitates their absorption. ";
      case 'NORMAL':
        return "your energy consumption from fat is ${fatIntake.toStringAsFixed(fatIntake >= 99 ? 0 : 2)}% which is within the normal AMDR range (20-30 %).";
      case 'HIGH':
        return "your energy consumption from fat should not be more than 30%. Whereas, your consumption is ${fatIntake.toStringAsFixed(fatIntake >= 99 ? 0 : 2)}% which  is above the normal range. It is adviced to reduce the intake of foods that are deep fried and also foods rich in cooking oils. High fat intake especially added fat can increase the risk of diet related non- communicable diseases including ";
      default:
        return '';
    }
  }
}
