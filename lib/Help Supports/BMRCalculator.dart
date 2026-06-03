import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/CustomTextEditing.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:url_launcher/url_launcher.dart';

//bmr calculator page
class BMRCalculator extends StatefulWidget {
  const BMRCalculator({super.key});

  @override
  _BMRCalculatorState createState() => _BMRCalculatorState();
}

class _BMRCalculatorState extends State<BMRCalculator> {
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  // TextEditingController heightController = TextEditingController();
  bool isMale = true;
  double bmrResult = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "assets/img/black_btn.png", // Replace with your health app logo asset path
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.headingBMRCalculator,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      // appBar: AppBar(
      //   title: Text('BMR Calculator'),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: true,
                    groupValue: isMale,
                    onChanged: (value) {
                      setState(() {
                        bmrResult = 0;
                        isMale = value as bool;
                      });
                    },
                  ),
                  Text(
                    Languages.of(context)!.ninTextMale,
                    style: TextStyle(
                      color: ThemeManager.themeText,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Radio(
                    value: false,
                    groupValue: isMale,
                    onChanged: (value) {
                      setState(() {
                        bmrResult = 0;
                        isMale = value as bool;
                      });
                    },
                  ),
                  Text(
                    Languages.of(context)!.ninTextFemale,
                    style: TextStyle(
                      color: ThemeManager.themeText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\.')),
                ],
                style: TextStyle(
                  fontSize: AppFontSizes.mediumDefault,
                  color: ThemeManager.themeText,
                ),
                decoration: InputDecoration(
                  labelText: Languages.of(context)!.ninTextAgeInYears,
                  prefixIcon: Icon(
                    Icons.cake,
                    color: ThemeManager.themeText,
                  ),
                  border: InputBorder.none, // Remove the outline
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                  labelStyle: TextStyle(
                    color: ThemeManager.themeText,
                    fontSize: AppFontSizes.smallDefault,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              // CustomTextField(
              //   icon: Icons.cake,
              //   labelText: Languages.of(context)!.labelAge,
              //   controller: ageController,
              // ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.fitness_center,
                labelText: Languages.of(context)!.labelEnterWeight,
                controller: weightController,
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
              ),
              const SizedBox(height: 20),
              // CustomTextField(
              //   icon: Icons.height,
              //   labelText: Languages.of(context)!.labelEnterHeight,
              //   controller: heightController,
              //   keyboardType: TextInputType.numberWithOptions(decimal: true),
              // ),
              // SizedBox(height: 16.0),
              // DecoratedTextField(
              //   controller: ageController,
              //   labelText: 'Enter Age',
              //   icon: Icons.cake,
              // ),
              // SizedBox(height: 16.0),
              // DecoratedTextField(
              //   controller: weightController,
              //   labelText: 'Enter Weight (kg)',
              //   icon: Icons.fitness_center,
              // ),
              // SizedBox(height: 16.0),
              // DecoratedTextField(
              //   controller: heightController,
              //   labelText: 'Enter Height (cm)',
              //   icon: Icons.height,
              // ),
              const SizedBox(height: 24.0),
              // ElevatedButton(
              //   onPressed: () {
              //     calculateBMR();
              //   },
              //   child: Text('Calculate BMR'),
              // ),
              SizedBox(
                width: 150,
                // height: 55,
                child: RoundButton(
                  title: Languages.of(context)!.labelCalculateBMR,
                  type: RoundButtonType.bgGradient,
                  // fontSize: AppFontSizes

                  fontWeight: FontWeight.w400,
                  onPressed: () async {
                    calculateBMR();
                  },
                ),
              ),
              const SizedBox(height: 24.0),

              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: ThemeManager.themelightColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  '${Languages.of(context)!.labelBMR}: ${bmrResult.toStringAsFixed(bmrResult >= 99 ? 0 : 2)} ${Languages.of(context)!.ninTextKcalPerDay}',
                  style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.bold,
                    color: ThemeManager.themeText,
                  ),
                ),
              ),
              Container(
                color: ThemeManager.themelightColor,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Languages.of(context)!.ninTextBMRfull,
                      style: const TextStyle(
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      textAlign: TextAlign.justify,
                      '${Languages.of(context)!.ninTextBMRDiscription}.',
                      style: const TextStyle(
                        fontSize: AppFontSizes.mediumDefault,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(
                            color: Color(
                                0xFF007BC1), // Change the color to whatever you desire
                          ),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'BMR (Kcal)',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    Languages.of(context)!.referenceMen65kg),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(Languages.of(context)!.valueForMen),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    Languages.of(context)!.referenceWomen55kg),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(Languages.of(context)!.valueForWomen),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text:
                            Languages.of(context)!.referenceMenWomenDescription,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' RDA, 2020.',
                            style: const TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _launchURL(
                                    'https://www.nin.res.in/RDA-2020.html');
                              },
                          ),
                          // TextSpan(
                          //   text: '.',
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  void calculateBMR() {
    int age = int.tryParse(ageController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0.0;
    // double height = double.tryParse(heightController.text) ?? 0.0;

    if (age > 0 && weight > 0) {
      double bmr;
      if (isMale) {
        if (age >= 18 && age <= 30) {
          bmr = ((15.1 * weight) + 692.2) * 0.9;
        } else if (age > 30 && age <= 60) {
          bmr = ((11.5 * weight) + 873) * 0.9;
        } else {
          bmr = ((11.7 * weight) + 587.7) * 0.9;
        }
      } else {
        if (age >= 18 && age <= 30) {
          bmr = ((14.8 * weight) + 486.6) * 0.91;
        } else if (age > 30 && age <= 60) {
          bmr = ((8.1 * weight) + 845.6) * 0.91;
        } else {
          bmr = ((9.1 * weight) + 658.5) * 0.91;
        }
      }
      setState(() {
        bmrResult = bmr;
      });
    } else {
      // Handle invalid input
      setState(() {
        bmrResult = 0.0;
      });
    }
  }
}
