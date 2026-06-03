import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/CustomTextEditing.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

// BMI calculator page
class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmiResult = 0.0;

  String getBMICategory(double bmi) {
    if (bmi == 0) {
      return '';
    } else if (bmi > 0 && bmi < 18.5) {
      return '${Languages.of(context)!.your} ${Languages.of(context)!.ninTextUnderweight}';
    } else if (bmi >= 18.5 && bmi < 25) {
      return '${Languages.of(context)!.your} ${Languages.of(context)!.ninTextNormal}';
    } else if (bmi >= 25 && bmi < 30) {
      return '${Languages.of(context)!.your} ${Languages.of(context)!.TextAppOverweight}';
    } else {
      return '${Languages.of(context)!.your} ${Languages.of(context)!.ninTextObesity}';
    }
  }

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
              color: ThemeManager.themeText,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.headingBMICalculator,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.height,
                labelText: Languages.of(context)!.labelEnterHeight,
                controller: heightController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.fitness_center,
                labelText: Languages.of(context)!.labelEnterWeight,
                controller: weightController,
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 150,
                // height: 55,
                child: RoundButton(
                  title: Languages.of(context)!.labelCalculateBMI,
                  type: RoundButtonType.bgGradient,
                  // fontSize: AppFontSizes

                  fontWeight: FontWeight.w400,
                  onPressed: () async {
                    calculateBMI();
                  },
                ),
              ),
              const SizedBox(height: 24.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: ThemeManager.themelightColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${Languages.of(context)!.labelBMI}: ${bmiResult.toStringAsFixed(bmiResult >= 99 ? 0 : 2)} kg/m²',
                      style: TextStyle(
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.bold,
                        color: ThemeManager.themeText,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      getBMICategory(bmiResult),
                      style: TextStyle(
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.bold,
                        color: ThemeManager.themeText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              // Adding the meter here
              SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 50,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0, endValue: 18.5, color: Colors.green),
                      GaugeRange(
                          startValue: 18.5,
                          endValue: 24.9,
                          color: Colors.yellow),
                      GaugeRange(
                          startValue: 24.9,
                          endValue: 29.9,
                          color: Colors.orange),
                      GaugeRange(
                          startValue: 29.9, endValue: 50, color: Colors.red),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: bmiResult, enableAnimation: true)
                    ],
                  )
                ],
              ),
              Container(
                color: ThemeManager.themelightColor,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${Languages.of(context)!.ninTextBmiHwading} ',
                      style: const TextStyle(
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      textAlign: TextAlign.justify,
                      Languages.of(context)!.ninTextBmiDiscription,
                      style: const TextStyle(
                        fontSize: AppFontSizes.mediumDefault,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      Languages.of(context)!.ninTextbminutritionsta,
                      style: const TextStyle(
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(
                            color: Color(
                                0xFF007BC1), // Change the color to whatever you desire
                          ),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${Languages.of(context)!.labelBMI} kg/m²',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  Languages.of(context)!.ninTextNutritionstat,
                                  style: const TextStyle(color: Colors.white),
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
                                    '${Languages.of(context)!.ninTextBelow} 18.5'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    Languages.of(context)!.ninTextUnderweight),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('18.5–24.9'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    '${Languages.of(context)!.ninTextNormal} ${Languages.of(context)!.labelWeight}'),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('25.0–29.9'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    Languages.of(context)!.ninTextPreobesity),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('30.0–34.9'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    Languages.of(context)!.ninTextbesity),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('35.0–39.9'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(Languages.of(context)!.ninTextbesity2),
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
                                    '${Languages.of(context)!.ninTextabove} 40'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(Languages.of(context)!.ninTextbesity3),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      double heightInMeters = height / 100.0;
      double bmi = weight / (heightInMeters * heightInMeters);
      setState(() {
        bmiResult = bmi;
      });
    } else {
      // Handle invalid input
      setState(() {
        bmiResult = 0.0;
      });
    }
  }
}
