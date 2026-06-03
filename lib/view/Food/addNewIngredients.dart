import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//from this opage user can add new ingredeint
class FoodFormPage extends StatefulWidget {
  const FoodFormPage({super.key});

  @override
  _FoodFormPageState createState() => _FoodFormPageState();
}

class _FoodFormPageState extends State<FoodFormPage> {
  String _selectedOption = 'Enter the brand and product name';

  final UserProfileController _controller = UserProfileController();
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController energyController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController fiberController = TextEditingController();
  final TextEditingController carbohydrateController = TextEditingController();
  final TextEditingController thiamineController = TextEditingController();
  final TextEditingController riboflavinController = TextEditingController();
  final TextEditingController niacinController = TextEditingController();
  final TextEditingController vitaminB6Controller = TextEditingController();
  final TextEditingController totalFolateController = TextEditingController();
  final TextEditingController vitaminCController = TextEditingController();
  final TextEditingController vitaminAController = TextEditingController();
  final TextEditingController ironController = TextEditingController();
  final TextEditingController zincController = TextEditingController();
  final TextEditingController sodiumController = TextEditingController();
  final TextEditingController calciumController = TextEditingController();
  final TextEditingController magnesiumController = TextEditingController();
  final TextEditingController sourceNameController = TextEditingController();
  final TextEditingController sourceYearController = TextEditingController();
  final TextEditingController sourceJournalController = TextEditingController();
  final TextEditingController sourcePageController = TextEditingController();
  final TextEditingController sourceProductNameController =
      TextEditingController();

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
          Languages.of(context)!.ninTextAddNewIngredient,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  controller: foodNameController,
                  labelText: Languages.of(context)!.ninTextFoodName,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: energyController,
                  labelText: Languages.of(context)!.NINTextEnergyKcal,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: proteinController,
                  labelText: Languages.of(context)!.NINTextProteinG,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: fatController,
                  labelText: Languages.of(context)!.NINTextFatG,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: fiberController,
                  labelText: Languages.of(context)!.NINTextFiberG,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: carbohydrateController,
                  labelText: Languages.of(context)!.NINTextCarbohydratesG,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: thiamineController,
                  labelText: Languages.of(context)!.NINTextThiamineB1Mg,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: riboflavinController,
                  labelText: Languages.of(context)!.NINTextRiboflavinB2Mg,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: niacinController,
                  labelText: Languages.of(context)!.NINTextNiacinB3Mg,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: vitaminB6Controller,
                  labelText: Languages.of(context)!.FoodvitaminB6,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: totalFolateController,
                  labelText: Languages.of(context)!.NINTextFolatesB9Mcg,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: vitaminCController,
                  labelText: Languages.of(context)!.ninTextVitaminC,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: vitaminAController,
                  labelText: Languages.of(context)!.ninTextVitaminA,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: ironController,
                  labelText: Languages.of(context)!.NINTextIronMg,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: zincController,
                  labelText: Languages.of(context)!.NINTextZincMg,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: sodiumController,
                  labelText: Languages.of(context)!.ninTextSodium,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: calciumController,
                  labelText: Languages.of(context)!.NINTextCalciumMg,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: magnesiumController,
                  labelText: Languages.of(context)!.NINTextMagnesiumMg,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${Languages.of(context)!.ninTextSource} :",
                    style: TextStyle(
                      color: ThemeManager.themeText, // Change the text color
                      fontSize: AppFontSizes.mediumDefault,
                    ),
                  ),
                ),
                Container(
                  decoration: ShapeDecoration(
                    color: TColor.primaryColor2.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x111D1617),
                        blurRadius: 40,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          // height: 80,
                          decoration: ShapeDecoration(
                            color: TColor.primaryColor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            // shadows: [
                            //   BoxShadow(
                            //     color: Color.fromARGB(255, 189, 20, 124),
                            //     blurRadius: 40,
                            //     offset: Offset(0, 10),
                            //     spreadRadius: 0,
                            //   )
                            // ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<String>(
                              initialValue: _selectedOption,
                              style: const TextStyle(color: Colors.white),
                              dropdownColor: const Color.fromARGB(255, 189, 20, 124),
                              icon:
                                  const Icon(Icons.expand_more, color: Colors.white),
                              menuMaxHeight: 400,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedOption = newValue!;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  // Use a border without the bottom line
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Customize border radius as needed
                                  borderSide:
                                      BorderSide.none, // Remove bottom line
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: 'Enter the brand and product name',
                                  child: Text(
                                    Languages.of(context)!
                                        .ninTextEnterBrandAndProductName,
                                    style: const TextStyle(
                                        color: Colors
                                            .white // Change the text color
                                        ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value:
                                      'Enter author name, year, journal, page',
                                  child: Text(
                                    Languages.of(context)!
                                        .ninTextEnterAuthorDetails,
                                    style: const TextStyle(
                                        color: Colors
                                            .white // Change the text color
                                        ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Enter the name of FCT',
                                  child: Text(
                                    Languages.of(context)!.ninTextEnterFctName,
                                    style: const TextStyle(
                                        color: Colors
                                            .white // Change the text color
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: sourceNameController,
                          labelText: Languages.of(context)!.labelName,
                        ),
                        const SizedBox(height: 10),
                        if (_selectedOption ==
                            "Enter author name, year, journal, page")
                          Column(
                            children: [
                              CustomTextField(
                                controller: sourceYearController,
                                labelText: Languages.of(context)!.labelYear,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: sourceJournalController,
                                labelText:
                                    Languages.of(context)!.ninTextJournal,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: sourcePageController,
                                labelText: Languages.of(context)!.ninTextPage,
                              ),
                            ],
                          ),
                        const SizedBox(height: 10),
                        if (_selectedOption ==
                            "Enter the brand and product name")
                          CustomTextField(
                            controller: sourceProductNameController,
                            labelText:
                                Languages.of(context)!.ninTextProductName,
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _submitForm();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: TColor.primaryColor1,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        Languages.of(context)!.submit,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppFontSizes.mediumDefault,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future<void> _submitForm() async {
    // Check if any field is empty
    if (_areFieldsEmpty()) {
      // Display an alert
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text("Alert"),
            content: Text(
              Languages.of(context)!.NINTextPleaseEnterAllFields,
              style: const TextStyle(color: Colors.red),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  Languages.of(context)!.ok,
                  style: TextStyle(color: ThemeManager.themeText),
                ),
              ),
            ],
          );
        },
      );
    } else {
      // All fields are filled, proceed to submit the form
      debugPrint("fdgbfhfghg $_selectedOption trufggfe");
      final Map<String, dynamic> requestData = {
        "foodName": foodNameController.text,
        "energy": double.parse(energyController.text),
        "protein": double.parse(proteinController.text),
        "fat": double.parse(fatController.text),
        "fiber": double.parse(fiberController.text),
        "carbohydrate": double.parse(carbohydrateController.text),
        "thiamine": double.parse(thiamineController.text),
        "riboflavin": double.parse(riboflavinController.text),
        "niacin": double.parse(niacinController.text),
        "vitaminB6": double.parse(vitaminB6Controller.text),
        "totalFolate": double.parse(totalFolateController.text),
        "vitaminC": double.parse(vitaminCController.text),
        "vitaminA": double.parse(vitaminAController.text),
        "iron": double.parse(ironController.text),
        "zinc": double.parse(zincController.text),
        "sodium": double.parse(sodiumController.text),
        "calcium": double.parse(calciumController.text),
        "magnesium": double.parse(magnesiumController.text),
        "sourceName": sourceNameController.text,
        "sourceYear": sourceYearController.text,
        "sourceJournal": sourceJournalController.text,
        "sourcePage": sourcePageController.text,
        "sourceProductName": sourceProductNameController.text
      };
      debugPrint("fdgbfhfghg $_selectedOption trufgfdgdgfe");
      await _controller.addUserRowIngredient(requestData);
      // Now you can use this requestData to call the API
      // Example: Api.addUserRowIngredient(requestData);

      // Optionally, you can also clear the form fields
      _clearFormFields();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text("Success"),
            content: Text(Languages.of(context)!.successfullyAddedIngredient),
            actions: <Widget>[
              // ElevatedButton(
              //   child: Text("OK"),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  Languages.of(context)!.ok,
                  style: TextStyle(color: ThemeManager.themeText),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  bool _areFieldsEmpty() {
    // Check if any field is empty
    if (foodNameController.text.isEmpty ||
            energyController.text.isEmpty ||
            proteinController.text.isEmpty ||
            fatController.text.isEmpty ||
            fiberController.text.isEmpty ||
            carbohydrateController.text.isEmpty ||
            thiamineController.text.isEmpty ||
            riboflavinController.text.isEmpty ||
            niacinController.text.isEmpty ||
            vitaminB6Controller.text.isEmpty ||
            totalFolateController.text.isEmpty ||
            vitaminCController.text.isEmpty ||
            vitaminAController.text.isEmpty ||
            ironController.text.isEmpty ||
            zincController.text.isEmpty ||
            sodiumController.text.isEmpty ||
            calciumController.text.isEmpty ||
            magnesiumController.text.isEmpty ||
            sourceNameController.text.isEmpty
        //  ||
        // sourceYearController.text.isEmpty ||
        // sourceJournalController.text.isEmpty ||
        // sourcePageController.text.isEmpty ||
        // sourceProductNameController.text.isEmpty
        ) {
      debugPrint("fdgbfhfghg $_selectedOption true");
      return true;
    } else {
      if (_selectedOption == "Enter author name, year, journal, page") {
        if (sourceYearController.text.isEmpty ||
            sourceJournalController.text.isEmpty ||
            sourcePageController.text.isEmpty) {
          sourceProductNameController.clear();
          debugPrint("fdgbfhfghg $_selectedOption 0");

          return true;
        }
      } else if (_selectedOption == "Enter the brand and product name") {
        if (sourceProductNameController.text.isEmpty) {
          sourceYearController.clear();
          sourceJournalController.clear();
          sourcePageController.clear();
          return true;
        } else {
          debugPrint("fdgbfhfghg $_selectedOption 1");
          return false;
        }
      } else {
        return false;
      }
      return false;
    }
  }

  void _clearFormFields() {
    // Clear all form fields
    foodNameController.clear();
    energyController.clear();
    proteinController.clear();
    fatController.clear();
    fiberController.clear();
    carbohydrateController.clear();
    thiamineController.clear();
    riboflavinController.clear();
    niacinController.clear();
    vitaminB6Controller.clear();
    totalFolateController.clear();
    vitaminCController.clear();
    vitaminAController.clear();
    ironController.clear();
    zincController.clear();
    sodiumController.clear();
    calciumController.clear();
    magnesiumController.clear();
    sourceNameController.clear();
    sourceYearController.clear();
    sourceJournalController.clear();
    sourcePageController.clear();
    sourceProductNameController.clear();
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: ShapeDecoration(
        color: ThemeManager.themelightColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: ThemeManager.themelightColor),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none, // Remove border
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          labelStyle: TextStyle(color: ThemeManager.themeText),
          filled: true,
          fillColor: ThemeManager.themelightColor,
        ),
      ),
    );
  }
}
