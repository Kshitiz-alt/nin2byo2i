import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//this page will show user detailed bmi
class BMIResultContainer extends StatelessWidget {
  final double bmiValue;

  const BMIResultContainer({super.key, required this.bmiValue});
  void showBMIRecommendations(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //  title: Text(  textAlign: TextAlign.justify,"BMI and Related Health Recommendations"),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.justify,
                  "Body Mass Index (BMI):",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  textAlign: TextAlign.justify,
                  "Body Mass Index (BMI) is defined as a person’s weight in kilograms divided by the square of the person’s height in metres (kg/m²). The BMI ranges are based on the effect excessive body fat has on disease and death and are reasonably well related to adiposity. BMI was developed as a risk indicator of disease; as BMI increases, so does the risk for some diseases. Some common conditions related to overweight and obesity include: premature death, cardiovascular diseases, high blood pressure, osteoarthritis, some cancers and diabetes (WHO).",
                ),
                // SizedBox(height: 10),
                // Text(  textAlign: TextAlign.justify,
                //   "Waist Circumference:",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // Text(  textAlign: TextAlign.justify,
                //   "Waist circumference is the circumference of the subject at the waist or abdomen when standing in a relaxed position with feet apart.",
                // ),
                // SizedBox(height: 10),
                // Text(  textAlign: TextAlign.justify,
                //   "Body Fat and Obesity:",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // Text(  textAlign: TextAlign.justify,
                //   "Body fat is the main source of energy and is mainly stored in adipocytes. Obesity is defined as a BMI of 30 or higher in adults.",
                // ),
                // SizedBox(height: 10),
                // Text(  textAlign: TextAlign.justify,
                //   "Related Health Conditions:",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // Text(  textAlign: TextAlign.justify,
                //   "Some common conditions related to overweight and obesity include premature death, cardiovascular diseases, high blood pressure, osteoarthritis, some cancers, and diabetes (WHO).",
                // ),
                // Text(  textAlign: TextAlign.justify,
                //   "Diabetes:",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // Text(  textAlign: TextAlign.justify,
                //   "Diabetes is a chronic metabolic disease that occurs when the body can't effectively use insulin, or the pancreas doesn't produce enough insulin.",
                // ),
                // Text(  textAlign: TextAlign.justify,
                //   "Hypertension:",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // Text(  textAlign: TextAlign.justify,
                //   "Hypertension, also known as high or raised blood pressure, is a condition in which the blood vessels have persistently raised pressure.",
                // ),
                // Text(  textAlign: TextAlign.justify,
                //   "Cardiovascular Diseases:",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // Text(  textAlign: TextAlign.justify,
                //   "Cardiovascular diseases are a group of disorders of the heart and blood vessels and include coronary heart disease, cerebrovascular disease, rheumatic heart disease, and other conditions.",
                // ),
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

  void shomadal1(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(  textAlign: TextAlign.justify,"BMI and Related Health Recommendations"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(  textAlign: TextAlign.justify,
                //   "Body Mass Index (BMI):",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                Text(
                  textAlign: TextAlign.justify,
                  description, // Use the provided description here
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

// Example of using the function:
// showBMIRecommendations(context, "BMI is a measure of body fat based on height and weight.");

  @override
  Widget build(BuildContext context) {
    String result = _calculateBMI(bmiValue);
    String message = _getResultMessage(result);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: TColor.primaryColor1.withOpacity(0.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.justify,
            'Your BMI: ${bmiValue.toStringAsFixed(bmiValue >= 99 ? 0 : 2)} kg/m²',
            style: const TextStyle(
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: 20),
          // Text(  textAlign: TextAlign.justify,
          //   'Result: $result',
          //   style: TextStyle(fontSize: AppFontSizes.largeDefault),
          // ),
          const SizedBox(height: 10),

          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              // text: "As per the ",
              style: const TextStyle(fontSize: AppFontSizes.mediumDefault),
              children: [
                const TextSpan(
                  text: "Your ",
                  style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: "BMI ",
                  style: const TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Code to show the modal when "AMDR" is clicked
                      showBMIRecommendations(
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
                // if (bmiValue >= 18.5 && bmiValue < 25)
                //   TextSpan(
                //     text: " waist circumference, ",
                //     style: TextStyle(
                //       fontSize: AppFontSizes .mediumDefault,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.blue,
                //     ),
                //     recognizer: TapGestureRecognizer()
                //       ..onTap = () {
                //         // Code to show the modal when "AMDR" is clicked
                //         // showModal1(
                //         //     context); // You need to implement showModal function to show your modal
                //       },
                //   ),
                if (bmiValue >= 18.5 && bmiValue < 25)
                  TextSpan(
                    text: " waist circumference, ",
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Code to show the modal when "AMDR" is clicked
                        // showModal1(
                        //     context); // You need to implement showModal function to show your modal
                        shomadal1(context,
                            "Waist circumference is the circumference of the subject at the waist or abdomen of the subject when the subject is standing in relaxed position with feet apart.  ");
                      },
                  ),
                if (bmiValue >= 18.5 && bmiValue < 25)
                  const TextSpan(
                    text: "and ",
                    style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      color: Colors.black,
                    ),
                  ),
                if (bmiValue >= 18.5 && bmiValue < 25)
                  TextSpan(
                    text: "body fat % ",
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Code to show the modal when "AMDR" is clicked
                        // showModal1(
                        //     context); // You need to implement showModal function to show your modal
                        shomadal1(context,
                            "Body fat is the main source of energy and is mainly stored in adipocytes. ");
                      },
                  ),
                if (bmiValue >= 18.5 && bmiValue < 25)
                  const TextSpan(
                    text: "on a regular basis.",
                    style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      color: Colors.black,
                    ),
                  ),
                if (bmiValue >= 25 && bmiValue < 30)
                  TextSpan(
                    text: " obesity",
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Code to show the modal when "AMDR" is clicked
                        // showModal1(
                        //     context); // You need to implement showModal function to show your modal
                        shomadal1(context,
                            "Obesity is defined as a body mass index (BMI) of 30 or higher in adults.");
                      },
                  ),
                if (bmiValue >= 25 && bmiValue < 30)
                  const TextSpan(
                    text:
                        " which may further lead to Non-communicable diseases like ",
                    style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      color: Colors.black,
                    ),
                  ),
                if (bmiValue >= 25 && bmiValue < 30)
                  TextSpan(
                    text: "diabetes, ",
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Code to show the modal when "AMDR" is clicked
                        // showModal1(
                        //     context); // You need to implement showModal function to show your modal
                        shomadal1(context,
                            "Diabetes is a chronic metabolic disease that occurs when the body can't effectively use insulin, or the pancreas doesn't produce enough insulin.");
                      },
                  ),
                if (bmiValue >= 25 && bmiValue < 30)
                  TextSpan(
                    text: "hypertension, ",
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Code to show the modal when "AMDR" is clicked
                        // showModal1(
                        //     context); // You need to implement showModal function to show your modal
                        shomadal1(context,
                            " Hypertension, also known as high or raised blood pressure, is a condition in which the blood vessels have persistently raised pressure.      ");
                      },
                  ),
                if (bmiValue >= 25 && bmiValue < 30)
                  TextSpan(
                    text: "cardiovascular diseases, ",
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Code to show the modal when "AMDR" is clicked
                        // showModal1(
                        //     context); // You need to implement showModal function to show your modal
                        shomadal1(context,
                            " Cardiovascular diseases are a group of disorders of the heart and blood vessels and include coronary heart disease, cerebrovascular disease, rheumatic heart disease and other conditions.     ");
                      },
                  ),
                if (bmiValue >= 25 && bmiValue < 30)
                  const TextSpan(
                    text:
                        " etc.You are advised to follow appropiate dietary guidelines  (https://www.nin.res.in/NICE.html).",
                    style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      color: Colors.black,
                    ),
                  ),
                // if (bmiValue >= 25 && bmiValue < 30)
                //   TextSpan(
                //     text: "on  a regular basis.",
                //     style: TextStyle(
                //       fontSize: AppFontSizes .mediumDefault,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.blue,
                //     ),
                //     recognizer: TapGestureRecognizer()
                //       ..onTap = () {
                //         // Code to show the modal when "AMDR" is clicked
                //         // showModal1(
                //         //     context); // You need to implement showModal function to show your modal
                //       },
                //   ),
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

  String _calculateBMI(double bmi) {
    if (bmi < 18.5) {
      return 'UNDERWEIGHT';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'NORMAL';
    } else if (bmi >= 25 && bmi < 30) {
      return 'OVERWEIGHT';
    } else {
      return 'OBESE';
    }
  }

  String _getResultMessage(String result) {
    switch (result) {
      case 'UNDERWEIGHT':
        return ' is low. Follow the dietary guidelines (https://www.nin.res.in/NICE.html) to fall within  ideal BMI range and additionally, it is advised to consult family physician or nutritionist or dietician.';
      case 'NORMAL':
        return 'falls within the normal range. However, it is advised to check your';
      case 'OVERWEIGHT':
        return 'is above the normal range . You are at risk of';
      case 'OBESE':
        return 'is very high. You may refer to the dietary guidelines or consult a physician/family physician for appropriate management.';
      default:
        return '';
    }
  }
}
