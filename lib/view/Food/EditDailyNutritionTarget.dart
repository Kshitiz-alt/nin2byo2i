import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
//set daily nutrition target page in wich user can feed their nutrition target

class EditDailyTargetnUTRITION extends StatefulWidget {
  const EditDailyTargetnUTRITION({super.key});

  @override
  _EditDailyTargetnUTRITIONState createState() =>
      _EditDailyTargetnUTRITIONState();
}

class _EditDailyTargetnUTRITIONState extends State<EditDailyTargetnUTRITION> {
  final UserProfileController _controller = UserProfileController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController proteinsController = TextEditingController();
  TextEditingController carbsController = TextEditingController();
  TextEditingController fatsController = TextEditingController();
  TextEditingController fiberController = TextEditingController();

  // Additional controllers
  TextEditingController magnesiumController = TextEditingController();
  TextEditingController zincController = TextEditingController();
  TextEditingController ironController = TextEditingController();
  TextEditingController calciumController = TextEditingController();
  TextEditingController thiamineB1Controller = TextEditingController();
  TextEditingController retinolVitAController = TextEditingController();
  TextEditingController riboflavinB2Controller = TextEditingController();
  TextEditingController niacinB3Controller = TextEditingController();
  TextEditingController folatesB9Controller = TextEditingController();

  void sendToApi() async {
    Map<String, dynamic> data = {
      "calories": int.parse(caloriesController.text),
      "proteins": int.parse(proteinsController.text),
      "carbs": int.parse(carbsController.text),
      "fats": int.parse(fatsController.text),
      "fiber": int.parse(fiberController.text),
      "magnesium": double.parse(magnesiumController.text),
      "zinc": double.parse(zincController.text),
      "iron": double.parse(ironController.text),
      "calcium": double.parse(calciumController.text),
      "thiamine_B1": double.parse(thiamineB1Controller.text),
      "retinol_Vit_A": double.parse(retinolVitAController.text),
      "riboflavin_B2": double.parse(riboflavinB2Controller.text),
      "niacin_B3": double.parse(niacinB3Controller.text),
      "folates_B9": double.parse(folatesB9Controller.text),
    };
    await _controller.EditDailyNutritionApi(data);
    Navigator.of(context).pop();
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
              "assets/img/black_btn.png",
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Set Nutrition Targets in gram",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {},
        //     child: Container(
        //       margin: const EdgeInsets.all(8),
        //       height: 40,
        //       width: 40,
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //           color: ThemeManager.themelightColor,
        //           borderRadius: BorderRadius.circular(10)),
        //       child: Image.asset(
        //         "assets/img/more_btn.png",
        //         width: 15,
        //         height: 15,
        //         fit: BoxFit.contain,
        //       ),
        //     ),
        //   )
        // ],
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: caloriesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Energy',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: proteinsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: Languages.of(context)!.labelProteins,
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: carbsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: Languages.of(context)!.labelCarbs,
                  filled: true,
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: fatsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: Languages.of(context)!.labelFats,
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: fiberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: Languages.of(context)!.labelFibers,
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              // Additional text fields
              TextField(
                controller: magnesiumController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Magnesium',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: zincController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Zinc',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              // Repeat this pattern for other additional fields...
              // Additional text fields
              TextField(
                controller: magnesiumController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Magnesium',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: zincController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Zinc',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: ironController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Iron',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: calciumController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Calcium',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: thiamineB1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Thiamine B1',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: retinolVitAController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Retinol Vit A',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: riboflavinB2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Riboflavin B2',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: niacinB3Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Niacin B3',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              sizedBox12(),
              TextField(
                controller: folatesB9Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Folates B9',
                  labelStyle: TextStyle(color: ThemeManager.themeText),
                  hintStyle: TextStyle(color: ThemeManager.themeText),
                  filled: true,
                  fillColor: ThemeManager.themelightColor,
                ),
                style: TextStyle(color: ThemeManager.themeText),
              ),
              // Repeat this pattern for other additional fields...
              const SizedBox(height: 20),
              RoundButton(
                title: Languages.of(context)!.labelSubmit,
                type: RoundButtonType.bgGradient,
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.w400,
                onPressed: () {
                  sendToApi();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
