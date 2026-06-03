import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/AddCustomDish2.dart';
import 'package:nin2byo2i/view/Food/AddDishScreen.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';

//custome dish 1st page where user need to add dish name
class OptionPage extends StatefulWidget {
  final String dishTypeSendForBackened;
  final String optionName;
  final String image;

  const OptionPage(
      {super.key, required this.optionName,
      required this.image,
      required this.dishTypeSendForBackened});

  @override
  _OptionPageState createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  final TextEditingController dishNameController = TextEditingController();
  final TextEditingController dishQuantityController = TextEditingController();

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
          widget.optionName,
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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Foodlisttype(
                fObj: {
                  "name": widget.optionName,
                  "image": widget.image,
                  "number": "120+ Foods"
                },
                index: 1,
              ),
              sizedBox12(),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    height: 64,
                    decoration: ShapeDecoration(
                      color: ThemeManager.themelightColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1, color: ThemeManager.themelightColor),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: TextFormField(
                      controller: dishNameController,
                      decoration: InputDecoration(
                        // labelText: 'Dish Name',
                        hintText: Languages.of(context)!.lablelDishName,
                        labelStyle: TextStyle(
                          color: ThemeManager.themeText,
                        ),
                        hintStyle: TextStyle(
                          color: ThemeManager.themeText,
                        ),
                        border: InputBorder.none, // This removes the underline
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 16.0), // Adjust padding as needed
                      ),
                      style: TextStyle(
                        color: ThemeManager.themeText,
                      ),
                    ),
                  )),
              sizedBox12(),

              SizedBox(
                width: 300,
                // height: 55,
                child: RoundButton(
                  title: Languages.of(context)!.labelSubmit,
                  type: RoundButtonType.bgGradient,
                  fontSize: AppFontSizes.smallDefault,
                  fontWeight: FontWeight.w400,
                  onPressed: () async {
                    // Extract data from text controllers and create a Map
                    if ((dishNameController.text != '')
                        //  &
                        //     (dishQuantityController.text != '')
                        ) {
                      // final dishData = {
                      //   'dishName': dishNameController.text,
                      //   'dishQuantity': 1,
                      //   // 'dishQuantity':
                      //   //     int.tryParse(dishQuantityController.text) ?? 0,
                      //   'mealName': widget.dishTypeSendForBackened,
                      // };

                      // final data = await _controller.AddFoodDish(dishData);
                      // if (data == true) {
                      // Navigate to another page and pass the dishName and optionName
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddIngredientsOfFoodPage(
                              dishTypeSendForBackened:
                                  widget.dishTypeSendForBackened,
                              dishName: dishNameController.text,
                              optionName: widget.optionName,
                              dishQuantity: dishQuantityController.text,
                              image: widget.image),
                        ),
                      );
                    }
                  },
                ),
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     // Extract data from text controllers and create a Map
              //     if ((dishNameController.text != '') &
              //         (dishQuantityController.text != '')) {
              //       final dishData = {
              //         'dishName': dishNameController.text,
              //         'dishQuantity':
              //             int.tryParse(dishQuantityController.text) ?? 0,
              //         'mealName': widget.optionName,
              //       };

              //       // final data = await _controller.AddFoodDish(dishData);
              //       // if (data == true) {
              //       // Navigate to another page and pass the dishName and optionName
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => AddIngredientsOfFoodPage(
              //               dishName: dishNameController.text,
              //               optionName: widget.optionName,
              //               dishQuantity: dishQuantityController.text),
              //         ),
              //       );
              //     }
              //   },
              //   child: Text("Submit"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
