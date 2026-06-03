import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/AddDishAlreadyExistRecipyProvidedByNIN.dart';
import 'package:nin2byo2i/view/Food/AddDishScreen.dart';
import 'package:nin2byo2i/view/Food/AddCustomDish1.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:intl/intl.dart';
import 'package:nin2byo2i/view/Food/AddOrEditDishRecipy.dart';
import 'package:nin2byo2i/view/Food/MyPerSonalFood.dart';
import 'package:nin2byo2i/view/Food/ReportMissingIngredients.dart';

//here is in the three options are add dish from personal,custom,and recipy provided by nin
class AddDishPage extends StatefulWidget {
  final String dishType;
  final String dishTypeSendForBackened;

  const AddDishPage(
      {super.key,
      required this.dishType,
      required this.dishTypeSendForBackened});

  @override
  _AddDishPageState createState() => _AddDishPageState();
}

class _AddDishPageState extends State<AddDishPage> {
  final UserProfileController _controller = UserProfileController();
  TextEditingController dishNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  String selectedDish = ""; // Variable to store the selected dish

  List<String> dishes = [
    // Add your dish names here
    "Cooked Rice",
    "Kichidi",
    // ... add all other dish names
  ]; //strings for success and error
  late String Title, content;
  bool Success = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializedata();
  }

  Future<void> initializedata() async {
    dishes = await _controller.CookedDishList();
  }

  String getImagePath() {
    // Add your logic to determine the image path based on dishType
    switch (widget.dishType.toLowerCase()) {
      case 'lunch':
        return "assets/img/lunch.jpg"; // Replace with your actual lunch image path
      case 'dinner':
        return "assets/img/dinner.jpg"; // Replace with your actual dinner image path
      case 'breakfast':
        return "assets/img/breakfast.jpg"; // Replace with your actual breakfast image path
      case 'bedtime':
        return "assets/img/bed time.jpg";
      case 'mid morning':
        return "assets/img/mid_morning.jpg"; // Replace with your actual snacks image path
      case 'evening':
        return "assets/img/evening.jpg";
      case 'early morning':
        return "assets/img/early_morning_lemon_tea.jpg";
      default:
        return "assets/img/bed time.jpg"; // Replace with a default image path
    }
  }

  void showCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
    bool isSuccess = false,
    Color contentColor = Colors.black,
  }) {
    if (Success == false) {
      setState(() {
        contentColor = Colors.red;
      });
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themelightColor,
          title: Text(
            title,
            style: TextStyle(
              color: ThemeManager.themeText,
            ),
          ),
          content: Text(
            content,
            style: TextStyle(color: contentColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop();
                // Navigator.of(context).pop();
              },
              child: Text(
                Languages.of(context)!.ok,
                style: TextStyle(color: contentColor),
              ),
            ),
          ],
        );
      },
    );
  }

  // void saveDish() async {
  //   final String dishName = selectedDish;
  //   final String quantity = quantityController.text;
  //   final status = await _controller.AddCookedFoodDishIngredients(
  //       dishName, quantity, widget.dishTypeSendForBackened);
  //   if (status) {
  //     Success = true;
  //     Title = Languages.of(context)!.dishAdded;
  //     content = Languages.of(context)!.dishAndIngredientsAddedSuccessfully;
  //     DateTime now = DateTime.now();
  //     String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  //     final data1 = await _controller.GetCaloriesEarned(formattedDate);
  //     showCustomDialog(
  //       context: context,
  //       title: Title,
  //       content: content,
  //       isSuccess: Success, // Set to true for a success message
  //       contentColor: Colors.green,
  //     );
  //   }
  //   // Implement your saveDish logic here
  // }

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
          widget.dishType,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Foodlisttype(
                fObj: {
                  "name": widget.dishType,
                  "image": getImagePath(),
                  "number": "120+ Foods"
                },
                index: 1,
              ),
              // Searchable dish selection
              // Searchable dish selection
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
                  child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: TypeAheadField<String>(
                        controller: dishNameController,
                        suggestionsCallback: (pattern) async {
                          return dishes
                              .where((dish) => dish
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                              .toList();
                        },
                        builder: (context, controller, focusNode) {
                          return TextField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              labelText:
                                  Languages.of(context)!.mainlabelSearchFood,
                              labelStyle: TextStyle(
                                color: ThemeManager.themeText,
                              ),
                              hintStyle: TextStyle(
                                color: ThemeManager.themeText,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: ThemeManager.themeText,
                            ),
                          );
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(
                              suggestion,
                              style: TextStyle(color: ThemeManager.themeText),
                            ),
                          );
                        },
                        onSelected: (suggestion) {
                          setState(() {
                            selectedDish = suggestion;
                            dishNameController.text = suggestion;
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddAlreadyExistingRecipy(
                                dishType: widget.dishType,
                                dishTypeSendForBackened:
                                    widget.dishTypeSendForBackened,
                                RecipeName: suggestion,
                              ),
                            ),
                          );
                        },
                      )),
                ),
              ),

              // Display an image dynamically based on the selected dish

              // Other form elements
              // SizedBox(height: 16.0),
              // Text('Dish Type: ${widget.dishType}'),
              const SizedBox(height: 16.0),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Container(
              //     width: double.infinity,
              //     height: 64,
              //     decoration: ShapeDecoration(
              //       color: ThemeManager.themelightColor,
              //       shape: RoundedRectangleBorder(
              //         side: BorderSide(
              //             width: 1, color: ThemeManager.themelightColor),
              //         borderRadius: BorderRadius.circular(14),
              //       ),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              //       child: TextField(
              //         controller: quantityController,
              //         keyboardType: TextInputType.number,
              //         decoration: InputDecoration(
              //           labelText: Languages.of(context)!.quantityingram,
              //           labelStyle: TextStyle(
              //             color: ThemeManager.themeText,
              //           ),
              //           hintStyle: TextStyle(
              //             color: ThemeManager.themeText,
              //           ),
              //           border: InputBorder.none, // Remove the underline
              //         ),
              //         style: TextStyle(
              //           color: ThemeManager.themeText,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 32.0),
              // SizedBox(
              //   width: 200,
              //   height: 55,
              //   child: RoundButton(
              //       title: Languages.of(context)!.labelSave,
              //       type: RoundButtonType.bgGradient,
              //       fontSize: AppFontSizes

              //       fontWeight: FontWeight.w400,
              //       onPressed: saveDish),
              // ),
              sizedBox12(),
              SizedBox(
                width: 200,
                height: 55,
                child: RoundButton(
                    title:
                        Languages.of(context)!.mainlabelSelectFromPersonalFood,
                    type: RoundButtonType.bgGradient,
                    fontSize: AppFontSizes.smallDefault,
                    fontWeight: FontWeight.w400,
                    onPressed: () {
                      debugPrint("dsfgfdhgfhgfhjgjg");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonalInfoPage(
                                    dishTypeSendForBackened:
                                        widget.dishTypeSendForBackened,
                                    dishType: widget.dishType,
                                  )
                              // OptionPage(
                              //       dishTypeSendForBackened:
                              //           widget.dishTypeSendForBackened,
                              //       optionName: widget.dishType,
                              //       image: getImagePath(),
                              //     )
                              ));
                    }),
              ),
              sizedBox12(),
              SizedBox(
                width: 200,
                height: 55,
                child: RoundButton(
                    title: Languages.of(context)!.createcustomdish,
                    type: RoundButtonType.bgGradient,
                    fontSize: AppFontSizes.smallDefault,
                    fontWeight: FontWeight.w400,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OptionPage(
                                    dishTypeSendForBackened:
                                        widget.dishTypeSendForBackened,
                                    optionName: widget.dishType,
                                    image: getImagePath(),
                                  )));
                    }),
              ),
              sizedBox12(),
              // SizedBox(
              //   width: 200,
              //   height: 55,
              //   child: RoundButton(
              //       title: "Report missing Ingredients",
              //       type: RoundButtonType.bgGradient,
              //       fontSize: AppFontSizes

              //       fontWeight: FontWeight.w400,
              //       onPressed: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => ReportMissingIngredients()
              //                 // OptionPage(
              //                 //       dishTypeSendForBackened:
              //                 //           widget.dishTypeSendForBackened,
              //                 //       optionName: widget.dishType,
              //                 //       image: getImagePath(),
              //                 //     )
              //                 ));
              //       }),
              // ),
              // ElevatedButton(
              //   onPressed: saveDish,
              //   child: Text('Save Dish'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayDishNamePage extends StatelessWidget {
  final String selectedDishName;

  const DisplayDishNamePage({super.key, required this.selectedDishName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Dish Name'),
      ),
      body: Center(
        child: Text(
          selectedDishName,
          style: const TextStyle(fontSize: AppFontSizes.mediumDefault),
        ),
      ),
    );
  }
}
