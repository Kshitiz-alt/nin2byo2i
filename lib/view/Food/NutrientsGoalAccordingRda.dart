import 'package:flutter/material.dart';
import 'package:nin2byo2i/Classes/Food%20Classes/EarFoodValue.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//nutrirnt goal according to rda guidlines
class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  List<NutritionalRequirement> nutritionalRequirements = [];
  final UserProfileController _controller = UserProfileController();
  NutritionalRequirement? selectedRequirement;

  @override
  void initState() {
    super.initState();
    fetchRequirements(); // Call the function when the page is initialized
  }

  void fetchRequirements() async {
    try {
      List<NutritionalRequirement> requirements =
          await _controller.fetchNutritionalRequirements();
      setState(() {
        nutritionalRequirements = requirements;
        // Initially select the first requirement
        if (requirements.isNotEmpty) {
          selectedRequirement = requirements.first;
          debugPrint(
              "SDfgvdfhfgjmghyk,hjlhj $selectedRequirement $nutritionalRequirements");
        }
      });
    } catch (e) {
      debugPrint('Error fetching nutritional requirements: $e');
      // Handle error
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
              "assets/img/black_btn.png",
              color: ThemeManager.themeText,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.mainlabelNutritionBasedOnEAR,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Dropdown button to select particular

            sizedBox12(),

            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                // gradient: LinearGradient(colors: [
                //   ThemeManager.themeText.withOpacity(0.1),
                //   ThemeManager.themeText.withOpacity(0.3),
                // ]),
                color: const Color.fromARGB(255, 189, 20, 124),
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButton<NutritionalRequirement>(
                style: const TextStyle(color: Colors.white),
                dropdownColor: const Color.fromARGB(255, 189, 20, 124),
                icon: const Icon(Icons.expand_more, color: Colors.white),
                underline: Container(),
                menuMaxHeight: 400,
                value: selectedRequirement,
                items: nutritionalRequirements
                    .map((NutritionalRequirement requirement) {
                  return DropdownMenuItem<NutritionalRequirement>(
                    value: requirement,
                    child: Text(
                      requirement.particulars,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (NutritionalRequirement? value) {
                  setState(() {
                    debugPrint(
                        "SDfgvdfhfgjmghyk,hjlhj $selectedRequirement $nutritionalRequirements");
                    selectedRequirement = value;
                  });
                },
              ),
            ),
            sizedBox12(),
            // Display selected requirement details using customcontainer
            if (selectedRequirement != null)
              Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     padding:
                  //         EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  //     // margin: EdgeInsets.only(bottom: 8.0),
                  //     decoration: BoxDecoration(
                  //       color: Color(0xFF007BC1),
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         CustomContainer(
                  //           keyText: 'Gender',
                  //           valueText: selectedRequirement!.gender,
                  //           backgroundcolor:
                  //               Colors.white, // Set color for gender
                  //           icon: Icons.person, // Custom icon
                  //         ),
                  //         CustomContainer(
                  //           keyText: 'Age',
                  //           valueText: selectedRequirement!.age,
                  //           backgroundcolor: Colors.white, // Set color for age
                  //           icon: Icons.calendar_today, // Custom icon
                  //         ),
                  //         CustomContainer(
                  //           keyText: 'Group',
                  //           valueText: selectedRequirement!.group,
                  //           backgroundcolor:
                  //               Colors.white, // Set color for group
                  //           icon: Icons.group, // Custom icon
                  //         ),
                  //         CustomContainer(
                  //           keyText: 'Work Level',
                  //           valueText: selectedRequirement!.workLevel,
                  //           backgroundcolor:
                  //               Colors.white, // Set color for work level
                  //           icon: Icons.work, // Custom icon
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  CustomContainer(
                    keyText: 'Energy',
                    valueText:
                        '${selectedRequirement!.energy.toStringAsFixed(selectedRequirement!.energy >= 99 ? 0 : 2)} Kcal', // Adding 'kcal' unit
                    backgroundcolor: TColor.primaryColor1.withOpacity(0.5),
                    icon: Icons.fiber_manual_record,
                  ),
                  CustomContainer(
                    keyText: 'Protein',
                    valueText:
                        '${selectedRequirement!.protein.toStringAsFixed(selectedRequirement!.protein >= 99 ? 0 : 2)} g', // Adding 'g' unit for grams
                    backgroundcolor: Colors.white,
                    icon: Icons.fiber_manual_record,
                  ),
                  // CustomContainer(
                  //   keyText: 'Fats/Oils',
                  //   valueText:
                  //       '${selectedRequirement!.fatsOilsVisible.toStringAsFixed(selectedRequirement!.fatsOilsVisible >= 99 ? 0 : 2)} g', // Adding 'g' unit for grams
                  //   backgroundcolor: TColor.primaryColor1.withOpacity(0.5),
                  //   icon: Icons.fiber_manual_record,
                  // ),
                  // CustomContainer(
                  //   keyText: 'Fiber',
                  //   valueText:
                  //       '${selectedRequirement!.fiber.toString()} g', // Adding 'g' unit for grams
                  //   backgroundcolor: Colors.white,
                  //   icon: Icons.fiber_manual_record,
                  // ),
                  // CustomContainer(
                  //   keyText: 'Calcium',
                  //   valueText:
                  //       '${selectedRequirement!.calcium.toStringAsFixed(selectedRequirement!.calcium >= 99 ? 0 : 2)} mg', // Adding 'mg' unit for milligrams
                  //   backgroundcolor: Colors.white,
                  //   icon: Icons.fiber_manual_record,
                  // ),
                  CustomContainer(
                    keyText: 'Magnesium',
                    valueText:
                        '${selectedRequirement!.magnesium.toStringAsFixed(selectedRequirement!.magnesium >= 99 ? 0 : 2)} mg', // Adding 'mg' unit for milligrams
                    backgroundcolor: TColor.primaryColor1.withOpacity(0.5),
                    icon: Icons.fiber_manual_record,
                  ),
                  CustomContainer(
                    keyText: 'Iron',
                    valueText:
                        '${selectedRequirement!.iron.toStringAsFixed(selectedRequirement!.iron >= 99 ? 0 : 2)} mg', // Adding 'mg' unit for milligrams
                    backgroundcolor: Colors.white,
                    icon: Icons.fiber_manual_record,
                  ),
                  CustomContainer(
                    keyText: 'Zinc',
                    valueText:
                        '${selectedRequirement!.zinc.toStringAsFixed(selectedRequirement!.zinc >= 99 ? 0 : 2)} mg', // Adding 'mg' unit for milligrams
                    backgroundcolor: TColor.primaryColor1.withOpacity(0.5),
                    icon: Icons.fiber_manual_record,
                  ),
                  CustomContainer(
                    keyText: 'Thiamine',
                    valueText:
                        '${selectedRequirement!.thiamine.toStringAsFixed(selectedRequirement!.thiamine >= 99 ? 0 : 2)} mg', // Adding 'mg' unit for milligrams
                    backgroundcolor: Colors.white,
                    icon: Icons.fiber_manual_record,
                  ),
                  CustomContainer(
                    keyText: 'Riboflavin',
                    valueText:
                        '${selectedRequirement!.riboflavin.toStringAsFixed(selectedRequirement!.riboflavin >= 99 ? 0 : 2)} mg', // Adding 'mg' unit for milligrams
                    backgroundcolor: TColor.primaryColor1.withOpacity(0.5),
                    icon: Icons.fiber_manual_record,
                  ),
                  CustomContainer(
                    keyText: 'Niacin',
                    valueText:
                        '${selectedRequirement!.niacin.toStringAsFixed(selectedRequirement!.niacin >= 99 ? 0 : 2)} mg', // Adding 'mg' unit for milligrams
                    backgroundcolor: Colors.white,
                    icon: Icons.fiber_manual_record,
                  ),
                  CustomContainer(
                    keyText: 'Folate',
                    valueText:
                        '${selectedRequirement!.folate.toStringAsFixed(selectedRequirement!.folate >= 99 ? 0 : 2)} µg', // Adding 'µg' unit for micrograms
                    backgroundcolor: TColor.primaryColor1.withOpacity(0.5),
                    icon: Icons.fiber_manual_record,
                  ),
                  CustomContainer(
                    keyText: 'Vitamin A',
                    valueText:
                        '${selectedRequirement!.vitA.toStringAsFixed(selectedRequirement!.vitA >= 99 ? 0 : 2)} IU', // Adding 'IU' unit for International Units
                    backgroundcolor: Colors.white,
                    icon: Icons.fiber_manual_record,
                  ),
                  // CustomContainer(
                  //   keyText: 'Carbohydrate',
                  //   valueText:
                  //       '${selectedRequirement!.carbohyderate.toString()} g', // Adding 'g' unit for grams
                  //   backgroundcolor: Colors.white,
                  //   icon: Icons.fiber_manual_record,
                  // ),

                  // CustomContainer(
                  //   keyText: 'Particulars',
                  //   valueText: selectedRequirement!.particulars,
                  //   backgroundcolor:
                  //       Colors.grey, // Set color for other properties
                  //   icon: Icons.fiber_manual_record, // Custom icon
                  // ),
                  CustomContainer(
                    keyText: 'Calcium',
                    valueText:
                        '${selectedRequirement!.calcium.toStringAsFixed(selectedRequirement!.calcium >= 99 ? 0 : 2)} mg', // Adding 'mg' unit for milligrams
                    backgroundcolor: TColor.primaryColor1.withOpacity(0.5),
                    icon: Icons.fiber_manual_record,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.keyText,
    required this.valueText,
    required this.backgroundcolor,
    required this.icon, // Added icon parameter
  }) : super(key: key);

  final String keyText;
  final String valueText;
  final Color backgroundcolor;
  final IconData icon; // Added icon parameter

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: TColor.primaryColor1.withOpacity(0.5)),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          color: backgroundcolor.withOpacity(0.5),
        ),
        child: Row(
          children: [
            Icon(
              icon, // Using provided icon
              color: Colors.black, // Set text color
              size: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: screenWidth * 0.35,
              child: Text(
                keyText,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black, // Set text color
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: screenWidth * 0.2,
              child: Text(
                valueText,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black, // Set text color
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
