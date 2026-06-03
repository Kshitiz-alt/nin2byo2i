import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/view/SuggestionComponents/BmiSuggestion.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//bmi calculator
class BMIPage extends StatefulWidget {
  final double bmiValue;

  const BMIPage({super.key, required this.bmiValue});
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  final TextEditingController _bmiController = TextEditingController();

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
              "assets/img/black_btn.png",
              color: ThemeManager.themeText,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.labelBMI,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${Languages.of(context)!.TextAppYourBMIIs} ${widget.bmiValue.toStringAsFixed(widget.bmiValue >= 99 ? 0 : 2)} kg/m²',
                style: const TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomBmiIndicatorValue(bmiValue: widget.bmiValue),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              Text(
                '${Languages.of(context)!.TextAppBMICategories}:',
                style: const TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.bold),
              ),
              buildBMICategories(context),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BMIResultContainer(bmiValue: widget.bmiValue),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  RichText buildBMICategories(context) {
    return RichText(
      text: TextSpan(
        children: [
          _buildTextSpan(
              '🟢${Languages.of(context)!.ninTextUnderweight} : ', '< 18.5\n'),
          _buildTextSpan(
              '🟡${Languages.of(context)!.ninTextNormal} : ', '18.5 - 24.9\n'),
          _buildTextSpan('🟠${Languages.of(context)!.ninTextOverweight} : ',
              '25 - 29.9\n'),
          _buildTextSpan(
              '🔴${Languages.of(context)!.ninTextObesity} : ', '=>30 '),
        ],
      ),
    );
  }

  TextSpan _buildTextSpan(String prefix, String text) {
    return TextSpan(
      text: prefix,
      style: TextStyle(color: ThemeManager.themeText),
      children: [
        TextSpan(
          text: text,
          style: TextStyle(color: ThemeManager.themeText),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _bmiController.dispose();
    super.dispose();
  }
}

class CustomBmiIndicatorValue extends StatelessWidget {
  const CustomBmiIndicatorValue({
    Key? key,
    required this.bmiValue,
  }) : super(key: key);

  final double bmiValue;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 50,
          ranges: <GaugeRange>[
            GaugeRange(startValue: 0, endValue: 18.5, color: Colors.green),
            GaugeRange(startValue: 18.5, endValue: 24.9, color: Colors.yellow),
            GaugeRange(startValue: 24.9, endValue: 29.9, color: Colors.orange),
            GaugeRange(startValue: 29.9, endValue: 50, color: Colors.red),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(value: bmiValue, enableAnimation: true)
          ],
        )
      ],
    );
  }
}
