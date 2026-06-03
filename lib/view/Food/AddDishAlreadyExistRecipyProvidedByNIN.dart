import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';import 'package:nin2byo2i/constants/server.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/AddOrEditDishRecipy.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:intl/intl.dart';

//add dish page from given list of recipy
class AddAlreadyExistingRecipy extends StatefulWidget {
  final String dishType;
  final String dishTypeSendForBackened;
  final String RecipeName;

  const AddAlreadyExistingRecipy({super.key, 
    required this.dishType,
    required this.dishTypeSendForBackened,
    required this.RecipeName,
  });
  @override
  _AddAlreadyExistingRecipyState createState() =>
      _AddAlreadyExistingRecipyState();
}

class _AddAlreadyExistingRecipyState extends State<AddAlreadyExistingRecipy> {
  double ServingSizeFinal = 0;
  TextEditingController dishQuantityController = TextEditingController();
  // TextEditingController mealTypeController = TextEditingController();
  TextEditingController servingSizeController = TextEditingController();
  bool isLoadingScreenCheck = true;
  bool isLoadingForRawFood = true;
  // bool isLoadingForCooked = true;
  List<String> ingredientSuggestions = [
    'Corn oil',
    // 'Buttermilk',
    // 'Whipping cream',
    // Add other ingredient suggestions here
  ];
  final UserProfileController _controller = UserProfileController();
  late Map<String, dynamic> Recipe = {
    // "recipeId": 3,
    // "recipeName": "Pulao",
    // "ingredients": [
    //   {"ingredientName": "ARISITHIPPILI", "weight": 1.0},
    //   {"ingredientName": "PEAS green", "weight": 200.0},
    //   {
    //     "ingredientName": "COOKING OIL (Gnut,ging,palm,must,coconut",
    //     "weight": 20.0
    //   },
    //   {"ingredientName": "RICE, raw, milled", "weight": 200.0},
    //   {"ingredientName": "ONION, small", "weight": 50.0},
    //   {"ingredientName": "CARDAMOM", "weight": 1.0},
    //   {"ingredientName": "CUMIN SEEDS", "weight": 1.0},
    //   {"ingredientName": "PEPPER, dry", "weight": 1.0},
    // ],
  };
  String unitName = '';
  bool isExpanded = false;
  double unitValue = 0.0;
  // double totalCookedQuantity = 0;
  List<DataRow> tableRows = [];
  List<DataRow> tableRowsper100gram = [];
  bool isExpanded2 = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializedata();
    // generateDateList();
    selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  String selectedDate = ""; // Initialize with an empty string
  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime lastWeek = currentDate.subtract(const Duration(days: 6)); // Last 7 days

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: lastWeek,
      lastDate: currentDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor:
                ThemeManager.themelightColor, // Background color of the header

            colorScheme: ColorScheme.dark(
              primary: TColor.primaryColor1, // Background color of the calendar
              onPrimary: Colors.white, // Text color of the calendar
              surface: TColor.primaryColor1, // Background color of the modal
              onSurface: Colors.white, // Text color of the modal
            ), // Background color of the modal
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: TColor.primaryColor1, // Color of the "OK" button
              ),
            ), dialogTheme: DialogThemeData(backgroundColor: Color.fromARGB(
                255, 91, 92, 92)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != currentDate) {
      setState(() {
        selectedDate = DateFormat("yyyy-MM-dd").format(picked);
      });
    }
  }
  // List<String> dateList = [];
  // String selectedDate = "";
  // void generateDateList() {
  //   // Get the current date
  //   DateTime currentDate = DateTime.now();

  //   // Generate the past 7 days
  //   for (int i = 0; i < 7; i++) {
  //     DateTime pastDate = currentDate.subtract(Duration(days: i));
  //     String formattedDate = pastDate.toLocal().toString().split(' ')[0];
  //     dateList.add(formattedDate);
  //   }

  //   // Set the selected date to the current date initially
  //   selectedDate = dateList[0];
  //   debugPrint("selctbhjkjnlm $selectedDate");
  // }

  String totalCookedQuantity = '';
  Future<void> initializedata() async {
    // ingredientSuggestions = await _controller.IngredientsList();
    final data = await _controller.getRecipes(widget.RecipeName);
    if (mounted) {
      setState(() {
        isLoadingScreenCheck = false;
        Recipe = data ?? {};
        unitName = Recipe["unit"];
        unitValue = Recipe["valueForOneUnit"];
        // dishQuantityController.text = "0.0";
        totalCookedQuantity = Recipe["totalCookedQuantity"]
            .toStringAsFixed(Recipe["totalCookedQuantity"] >= 99 ? 0 : 2);

        _calculateIngredients();
        debugPrint("fdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfdfd $Recipe");
      });
    }
  }

  // double resultTotalQuantity = 0.0;
  TextEditingController ControllerresultTotalQuantity = TextEditingController();
  void calculateResult() {
    setState(() {
      // Get the entered number
      double enteredNumber = double.tryParse(servingSizeController.text) ?? 0.0;
      dishQuantityController.text = ((Recipe["totalCookedQuantity"])!)
          .toStringAsFixed((Recipe["totalCookedQuantity"])! >= 99 ? 0 : 2);
      // totalCookedQuantity = ((double.tryParse(servingSizeController.text)! *
      //     Recipe["totalCookedQuantity"])!);
      // Perform the calculation
      // resultTotalQuantity = enteredNumber * unitValue;
      ServingSizeFinal = enteredNumber * unitValue;
      ControllerresultTotalQuantity.text = (enteredNumber * unitValue)
          .toStringAsFixed((enteredNumber * unitValue) >= 99 ? 0 : 2);
      _calculateIngredientsfor100gram(context);
    });
  }

  void calculateResultusingControllerresultTotalQuantity() {
    setState(() {
      // Get the entered number
      double enteredNumber = double.tryParse(servingSizeController.text) ?? 0.0;

      // Perform the calculation
      // resultTotalQuantity = enteredNumber * unitValue;

      try {
        double totalQuantity = double.parse(ControllerresultTotalQuantity.text);
        double servingSize = totalQuantity / unitValue;
        servingSizeController.text =
            servingSize.toStringAsFixed(servingSize >= 99 ? 0 : 2);
      } catch (e) {
        debugPrint("Error parsing input: $e");
        // Handle the error gracefully, e.g., display an error message to the user
      }

      dishQuantityController.text = ((Recipe["totalCookedQuantity"])!)
          .toStringAsFixed(((Recipe["totalCookedQuantity"])!) >= 99 ? 0 : 2);
      // totalCookedQuantity = ((double.tryParse(servingSizeController.text)! *
      //     Recipe["totalCookedQuantity"])!);
      _calculateIngredientsfor100gram(context);
    });
  }

  Future<void> _showEditRecipeNameDialog() async {
    if (dishQuantityController.text.isNotEmpty &&
        ControllerresultTotalQuantity.text.isNotEmpty) {
      Recipe["dishQuantity"] =
          double.tryParse(dishQuantityController.text) ?? 0.0;
      Recipe["mealType"] = widget.dishTypeSendForBackened;
      Recipe["servingSize"] = ControllerresultTotalQuantity.text;

      debugPrint("kjdgdjgndfhhhmfgmgf $Recipe");
      await _controller.addDishByRecipe(selectedDate, Recipe);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
              style: TextStyle(color: ThemeManager.themeText), 'Submitted'),
        ),
      );
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      final data1 = await _controller.GetCaloriesEarned(formattedDate);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      // Display a Snackbar if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
              style: TextStyle(color: ThemeManager.themeText),
              'Please enter all fields.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double commonwidth = MediaQuery.of(context).size.width;
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
              color: ThemeManager.themeText,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.mainlabelFixedRecipy,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: isLoadingScreenCheck
          ? const CommonDataLoadingScreen()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // DropdownButton<String>(
                    //   value: selectedDate,
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       if (dateList.contains(newValue)) {
                    //         // User selected a date from the dropdown
                    //         selectedDate = newValue!;
                    //         debugPrint("selctbhjkjnlm $selectedDate");
                    //       } else {
                    //         // User selected another option, assign the current date
                    //         selectedDate = dateList[0];
                    //       }
                    //     });
                    //   },
                    //   items: dateList.map((String date) {
                    //     return DropdownMenuItem<String>(
                    //       value: date,
                    //       child: Text(date),
                    //     );
                    //   }).toList(),
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddDishEdit(
                              dishType: widget.dishType,
                              dishTypeSendForBackened:
                                  widget.dishTypeSendForBackened,
                              RecipeName: widget.RecipeName,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: ShapeDecoration(
                          color: TColor.primaryColor1.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1, color: ThemeManager.themelightColor),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: commonwidth * 0.8,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: Languages.of(context)!
                                          .mainlabelWantToEditThisRecipyFollowThe,
                                      style: TextStyle(
                                          color: ThemeManager.themeText,
                                          fontSize: AppFontSizes.mediumDefault,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    TextSpan(
                                      text:
                                          " ${Languages.of(context)!.mainlabelLink}.",
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: AppFontSizes.mediumDefault,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: media.width * 0.4,
                          child: Text(
                            '${Languages.of(context)!.mainlabelSelectDate}:',
                            style: TextStyle(
                                fontSize: AppFontSizes.mediumDefault,
                                color: ThemeManager.themeText),
                          ),
                        ),
                        SizedBox(
                          width: media.width * 0.3,
                          child: Text(
                            DateFormatter.convertDate(selectedDate),
                            style: TextStyle(
                                fontSize: AppFontSizes.mediumDefault,
                                fontWeight: FontWeight.bold,
                                color: ThemeManager.themeText),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today,
                              color: ThemeManager.themeText),
                          onPressed: () => _selectDate(context),
                          tooltip: Languages.of(context)!.TextAppSelectDate,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: commonwidth * 0.6,
                            child: Text(
                                '${Languages.of(context)!.mainlabelRecipeName}: ${Recipe["recipeName"]}',
                                style: TextStyle(
                                    color: ThemeManager.themeText,
                                    fontSize: AppFontSizes.largeDefault,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: commonwidth * 0.25,
                            child: ElevatedButton(
                              onPressed: _showEditRecipeNameDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 189, 20,
                                    124), // Set your desired background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      25.0), // Set your desired border radius
                                ),
                              ),
                              child: Text(
                                  style: const TextStyle(color: Colors.white),
                                  Languages.of(context)!.submit),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
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
                    //     child: TextField(
                    //       controller: dishQuantityController,
                    //       decoration: InputDecoration(labelText: 'Dish Weight(g)'),
                    //       keyboardType: TextInputType.number,
                    //     ),
                    //   ),
                    // ),
                    // TextField(
                    //   controller: mealTypeController,
                    //   decoration: InputDecoration(labelText: 'Meal Type'),
                    // ),

                    // Text(style: TextStyle(color: ThemeManager.themeText),
                    //   'Serving size/weight-1(${unitValue.toStringAsFixed(2)} g)',
                    //   style: TextStyle(fontSize: AppFontSizes.mediumDefault.0, fontWeight: FontWeight.bold),
                    //   textAlign: TextAlign.center,
                    // ),
                    sizedBox30(),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12.0),
                        color: ThemeManager.themelightColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(style: TextStyle(color: ThemeManager.themeText),'Recipe ID: ${Recipe["recipeId"]}',
                          //     style: TextStyle(fontSize: AppFontSizes.mediumDefault)),
                          // SizedBox(height: 12.0),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(style: TextStyle(color: ThemeManager.themeText),'Recipe Name: ${Recipe["recipeName"]}',
                          //         style: TextStyle(
                          //             fontSize: AppFontSizes.mediumDefault, fontWeight: FontWeight.bold)),
                          //     // IconButton(
                          //     //   icon: Icon(Icons.edit),
                          //     //   onPressed: _showEditRecipeNameDialog,
                          //     // ),
                          //   ],
                          // ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              Text(
                                  '${Languages.of(context)!.mainlabelIngredient}:',
                                  style: TextStyle(
                                      color: ThemeManager.themeText,
                                      fontSize: AppFontSizes.mediumDefault,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 16.0),
                              const Spacer(),

                              // ElevatedButton(
                              //   onPressed: _showAddIngredientDialog,
                              //   child: Text('Add Ingredient'),
                              // ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (Recipe.isNotEmpty)
                                for (int i = 0;
                                    i < Recipe["ingredients"].length;
                                    i++)
                                  Column(
                                    children: [
                                      const Divider(), // Add Divider between each ingredient
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    // Show image in modal dialog
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                        backgroundColor:
                                                            ThemeManager
                                                                .themeColor,
                                                        content: Container(
                                                          color: ThemeManager
                                                              .themeColor,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  IconButton(
                                                                    icon: const Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(); // Close the dialog
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 16),
                                                              SizedBox(
                                                                width: 500,
                                                                child: Image
                                                                    .network(
                                                                  "${API.server}/images/${Recipe["ingredients"][i]['foodCode']}.PNG",
                                                                  loadingBuilder: (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null) {
                                                                      // Image is fully loaded
                                                                      return child;
                                                                    } else {
                                                                      // Image is still loading
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          value: loadingProgress.expectedTotalBytes != null
                                                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                              : null,
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                  errorBuilder: (BuildContext
                                                                          context,
                                                                      Object
                                                                          error,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                    // Error occurred while loading image
                                                                    return SizedBox(
                                                                      width:
                                                                          500,
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/img/raw food.jpeg.png',

                                                                        // height: 50,
                                                                        // width: 100,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: Image.network(
                                                      "${API.server}/images/${Recipe["ingredients"][i]['foodCode']}.PNG",
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          // Image is fully loaded
                                                          return child;
                                                        } else {
                                                          // Image is still loading
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object error,
                                                              StackTrace?
                                                                  stackTrace) {
                                                        // Error occurred while loading image
                                                        return SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child: Image.asset(
                                                            'assets/img/raw food.jpeg.png',

                                                            // height: 50,
                                                            // width: 100,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: commonwidth * 0.6,
                                                child: Text(
                                                  '${Recipe["ingredients"][i]["ingredientName"]}: ${Recipe["ingredients"][i]["ingredientQuantity"].toStringAsFixed(Recipe["ingredients"][i]["ingredientQuantity"] >= 99 ? 0 : 2)} g',
                                                  style: TextStyle(
                                                      color: ThemeManager
                                                          .themeText,
                                                      fontSize: AppFontSizes
                                                          .mediumDefault),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    sizedBox30(),
                    Text(
                      '${Languages.of(context)!.NINTextOne} $unitName = ${unitValue.toStringAsFixed(0)} g',
                      style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.mediumDefault,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 4,
                            ),
                            SizedBox(
                              width: 150, // Set the width to your desired value
                              child: TextField(
                                controller: servingSizeController,
                                decoration: InputDecoration(
                                  labelText: Languages.of(context)!
                                      .mainlabelNumberOfServing,
                                  hintText: '',
                                  labelStyle: TextStyle(
                                      color: ThemeManager
                                          .themeText), // Color for label
                                  hintStyle: TextStyle(
                                      color: ThemeManager
                                          .themeText), // Color for hint
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ThemeManager
                                          .themeText, // Color for the bottom border
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ThemeManager
                                          .themeText, // Color for the bottom border when focused
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: ThemeManager.themeText),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  calculateResult();
                                },
                              ),
                            ),
                            Text(
                              ' = ',
                              style: TextStyle(
                                  color: ThemeManager.themeText,
                                  fontSize: AppFontSizes.mediumDefault),
                            ),
                            SizedBox(
                              width: 150, // Set the width to your desired value
                              child: TextField(
                                controller: ControllerresultTotalQuantity,
                                decoration: InputDecoration(
                                  labelText:
                                      Languages.of(context)!.mainlabelWeightInG,
                                  hintText: '',
                                  labelStyle: TextStyle(
                                      color: ThemeManager
                                          .themeText), // Color for label
                                  hintStyle: TextStyle(
                                      color: ThemeManager
                                          .themeText), // Color for hint
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ThemeManager
                                          .themeText, // Color for the bottom border
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ThemeManager
                                          .themeText, // Color for the bottom border when focused
                                    ),
                                  ),
                                ),
                                style: TextStyle(color: ThemeManager.themeText),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  calculateResultusingControllerresultTotalQuantity();
                                },
                              ),
                            ),
                            // SizedBox(
                            //   width: 4,
                            // ),
                            // Text(
                            //   ' = $resultTotalQuantity g',
                            //   style: TextStyle(
                            //       fontSize: AppFontSizes.mediumDefault.0, fontWeight: FontWeight.bold),
                            //   textAlign: TextAlign.center,
                            // ),
                          ],
                        ),
                      ),
                    ),

                    // Text(
                    //   'Total Cooked Weight ${totalCookedQuantity} g',
                    //   style: TextStyle(fontSize: AppFontSizes.mediumDefault.0, fontWeight: FontWeight.bold),
                    //   textAlign: TextAlign.center,
                    // ),
                    sizedBox12(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: ThemeManager.themelightColor,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                SizedBox(
                                  width: commonwidth * 0.55,
                                  child: Text(
                                      style: TextStyle(
                                          color: ThemeManager.themeText),
                                      Languages.of(context)!
                                          .mainlabelNutrientOfAllIngredientsRaw),
                                ),
                                const Spacer(),
                                Icon(
                                  isExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: ThemeManager.themeText,
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                          ),
                          if (isExpanded)
                            isLoadingForRawFood
                                ? const CommonDataLoadingScreen()
                                : Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: tableRows.isNotEmpty
                                        ? DataTable(
                                            headingRowColor:
                                                WidgetStateColor.resolveWith(
                                                    (states) =>
                                                        const Color(0xFF007BC1)),
                                            columns: [
                                              DataColumn(
                                                label: SizedBox(
                                                  width: 70,
                                                  child: Text(
                                                    Languages.of(context)!
                                                        .NINTextNutrient,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    Languages.of(context)!
                                                        .mainlabelValue),
                                                numeric: true,
                                                tooltip: 'Weight of Ingredient',
                                              ),
                                            ],
                                            rows: tableRows,
                                          )
                                        : Text(
                                            style: TextStyle(
                                                color: ThemeManager.themeText),
                                            ""),
                                  ),
                        ],
                      ),
                    ),
                    sizedBox12(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: ThemeManager.themelightColor,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: commonwidth * 0.55,
                                      child: Text(
                                          style: TextStyle(
                                              color: ThemeManager.themeText),
                                          '${Languages.of(context)!.mainlabelNutrientsCompostionOfCookedWeight}($totalCookedQuantity g)'),
                                    ),
                                    sizedBox12(),
                                    SizedBox(
                                      width: commonwidth * 0.55,
                                      child: Text(
                                          style: TextStyle(
                                              fontSize:
                                                  AppFontSizes.smallDefault,
                                              fontWeight: FontWeight.w600,
                                              color: ThemeManager.themeText),
                                          '*Nutrient retention factor not applied'),
                                    ),
                                    // SizedBox(
                                    //   width: commonwidth * 0.6,
                                    //   child: Text(style: TextStyle(color: ThemeManager.themeText),
                                    //       ""),
                                    // ),
                                  ],
                                ),

                                // ignore: prefer_const_constructors
                                Spacer(),
                                Icon(
                                  isExpanded2
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: ThemeManager.themeText,
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                _calculateIngredientsfor100gram(context);
                                isExpanded2 = !isExpanded2;
                              });
                            },
                          ),
                          if (isExpanded2)
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: tableRowsper100gram.isNotEmpty
                                  ? DataTable(
                                      columnSpacing: 3.0,
                                      headingRowColor:
                                          WidgetStateColor.resolveWith(
                                              (states) => const Color(0xFF007BC1)),
                                      columns: [
                                        DataColumn(
                                          label: SizedBox(
                                            width: 90,
                                            child: Text(
                                              Languages.of(context)!
                                                  .NINTextNutrient,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 70,
                                            child: Text(
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              '1 ${Languages.of(context)!.serving} (${unitValue.toStringAsFixed(0)} g)',
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 70,
                                            child: Text(
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              '${servingSizeController.text == '' ? '0' : (double.parse(servingSizeController.text).toStringAsFixed(double.parse(servingSizeController.text) >= 99 ? 0 : 2))} ${Languages.of(context)!.serving} (${(double.parse(ControllerresultTotalQuantity.text).toStringAsFixed(double.parse(ControllerresultTotalQuantity.text) >= 99 ? 0 : 2))} g)',
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                            ),
                                          ),
                                        ),
                                        const DataColumn(
                                          label: SizedBox(
                                            width: 70,
                                            child: Text(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              '100 g ',
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                            ),
                                          ),
                                        ),
                                        // DataColumn(
                                        //   label: Text(style: TextStyle(color: ThemeManager.themeText),'Nutrition'),
                                        //   numeric: false,
                                        //   tooltip: 'Nutrition Name',
                                        // ),
                                        // DataColumn(
                                        //   label: Text(style: TextStyle(color: ThemeManager.themeText),'Weight'),
                                        //   numeric: true,
                                        //   tooltip: 'Weight of Ingredient',
                                        // ),
                                      ],
                                      rows: tableRowsper100gram,
                                    )
                                  : Text(
                                      style: TextStyle(
                                          color: ThemeManager.themeText),
                                      ""),
                            ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 16.0),
                    // ElevatedButton(
                    //   onPressed: _showAddIngredientDialog,
                    //   child: Text(style: TextStyle(color: ThemeManager.themeText),'Add Ingredient'),
                    // ),
                    // ElevatedButton(
                    //   onPressed: _showEditRecipeNameDialog,
                    //   child: Text(style: TextStyle(color: ThemeManager.themeText),'Submit'),
                    // ),
                    sizedBox30(),
                  ],
                ),
              ),
            ),
    );
  }

  Map<String, dynamic> responseDataNutrition = {};
  Future<void> _calculateIngredients() async {
    setState(() {
      isLoadingForRawFood = true;
    });
    debugPrint("vfdgfdgfhgfgfhjgghj ${Recipe["ingredients"]}");
    final List<Map<String, dynamic>> addedIngredients =
        (Recipe["ingredients"] as List<dynamic>).cast<Map<String, dynamic>>();

    try {
      responseDataNutrition =
          await _controller.calculateIngredients(addedIngredients);
      _displayNutritionalInfo(responseDataNutrition);
    } catch (error) {
      // Handle error
    }
    setState(() {
      isLoadingForRawFood = false;
    });
  }

  void _displayNutritionalInfo(Map<String, dynamic> responseData) {
    List<dynamic> nutritionalInfoList = responseData['nutritionalInfoList'];
    double totalEnergy = responseData['totalEnergy'];
    double totalProteins = responseData['totalProteins'];
    double totalCarbs = responseData['totalCarbs'];
    double totalFats = responseData['totalFats'];
    double totalFibers = responseData['totalFibers'];

    setState(() {
      tableRows.clear();
      tableRows.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextEnergyKcal}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          '${totalEnergy.toStringAsFixed(totalEnergy >= 99 ? 0 : 2)} ',
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRows.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextProteinG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          totalProteins.toStringAsFixed(totalProteins >= 99 ? 0 : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRows.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextCarbohydratesG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          totalCarbs.toStringAsFixed(totalCarbs >= 99 ? 0 : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRows.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextFatG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          totalFats.toStringAsFixed(totalFats >= 99 ? 0 : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
      tableRows.add(DataRow(cells: [
        DataCell(Text(
          '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextFiberG}',
          style: TextStyle(color: ThemeManager.themeText),
        )),
        DataCell(Text(
          totalFibers.toStringAsFixed(totalFibers >= 99 ? 0 : 2),
          style: TextStyle(color: ThemeManager.themeText),
        )),
      ]));
    });
  }

  Future<void> _calculateIngredientsfor100gram(context) async {
    // Check if addCookedDishVolume.text is empty or null
    if (dishQuantityController.text.isEmpty) if (servingSizeController.text.isEmpty) {
      // Show dialog box
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ThemeManager.themeColor,
            title: Text(
              Languages.of(context)!.alert,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            content: Text(
              Languages.of(context)!
                  .mainlabelToSeeNutritionCompositionPleaseEnterNoOfServing,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            actions: [
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

      // Return from the function
      return;
    }

    debugPrint(
        "vfdgfdgfhgfgfhjgghj $tableRowsper100gram   ${double.parse(dishQuantityController.text)}");

    try {
      // responseDataNutrition =
      // await _controller.calculateIngredients(addedIngredients);
      _displayNutritionalInfoper100gram(responseDataNutrition);
    } catch (error) {
      // Handle error
    }
  }

  void _displayNutritionalInfoper100gram(Map<String, dynamic> responseData) {
    List<dynamic> nutritionalInfoList = responseData['nutritionalInfoList'];
    double totalEnergy = responseData['totalEnergy'];
    double totalProteins = responseData['totalProteins'];
    double totalCarbs = responseData['totalCarbs'];
    double totalFats = responseData['totalFats'];
    double totalFibers = responseData['totalFibers'];

    setState(() {
      tableRowsper100gram.clear();
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(SizedBox(
          width: 90,
          child: Text(
              '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextEnergyKcal}',
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalEnergy / double.parse(dishQuantityController.text)) * unitValue).toStringAsFixed(((totalEnergy / double.parse(dishQuantityController.text)) * unitValue) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalEnergy / double.parse(dishQuantityController.text)) * (double.parse(ControllerresultTotalQuantity.text))).toStringAsFixed(((totalEnergy / double.parse(dishQuantityController.text)) * (double.parse(ControllerresultTotalQuantity.text))) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalEnergy / double.parse(dishQuantityController.text)) * 100).toStringAsFixed(((totalEnergy / double.parse(dishQuantityController.text)) * 100) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(SizedBox(
          width: 70,
          child: Text(
              '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextProteinG}',
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalProteins / double.parse(dishQuantityController.text)) * unitValue).toStringAsFixed(((totalProteins / double.parse(dishQuantityController.text)) * unitValue) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalProteins / double.parse(dishQuantityController.text)) * (double.parse(ControllerresultTotalQuantity.text))).toStringAsFixed(((totalProteins / double.parse(dishQuantityController.text)) * (double.parse(ControllerresultTotalQuantity.text))) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalProteins / double.parse(dishQuantityController.text)) * 100).toStringAsFixed(((totalProteins / double.parse(dishQuantityController.text)) * 100) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(SizedBox(
          width: 70,
          child: Text(
              '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextCarbohydratesG}',
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalCarbs / double.parse(dishQuantityController.text)) * unitValue).toStringAsFixed(((totalCarbs / double.parse(dishQuantityController.text)) * unitValue) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalCarbs / double.parse(dishQuantityController.text)) * (double.parse(ControllerresultTotalQuantity.text))).toStringAsFixed(((totalCarbs / double.parse(dishQuantityController.text)) * (double.parse(ControllerresultTotalQuantity.text))) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalCarbs / double.parse(dishQuantityController.text)) * 100).toStringAsFixed(((totalCarbs / double.parse(dishQuantityController.text)) * 100) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(SizedBox(
          width: 70,
          child: Text(
              '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextFatG}',
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFats / double.parse(dishQuantityController.text)) * unitValue).toStringAsFixed(((totalFats / double.parse(dishQuantityController.text)) * unitValue) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFats / double.parse(dishQuantityController.text)) * (double.parse(ControllerresultTotalQuantity.text))).toStringAsFixed(((totalFats / double.parse(dishQuantityController.text)) * (double.parse(ControllerresultTotalQuantity.text))) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFats / double.parse(dishQuantityController.text)) * 100).toStringAsFixed(((totalFats / double.parse(dishQuantityController.text)) * 100) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
      ]));
      tableRowsper100gram.add(DataRow(cells: [
        DataCell(SizedBox(
          width: 70,
          child: Text(
              '${Languages.of(context)!.labelTotal} ${Languages.of(context)!.NINTextFiberG}',
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFibers / double.parse(dishQuantityController.text)) * unitValue).toStringAsFixed(((totalFibers / double.parse(dishQuantityController.text)) * unitValue) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFibers / double.parse(dishQuantityController.text)) * (double.parse(ControllerresultTotalQuantity.text))).toStringAsFixed(((totalFibers / double.parse(dishQuantityController.text)) * (double.parse(ControllerresultTotalQuantity.text))) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
        DataCell(SizedBox(
          width: 70,
          child: Text(
              textAlign: TextAlign.center,
              ((totalFibers / double.parse(dishQuantityController.text)) * 100).toStringAsFixed(((totalFibers / double.parse(dishQuantityController.text)) * 100) >= 99 ? 0 : 2),
              style: TextStyle(
                color: ThemeManager.themeText,
              )),
        )),
      ]));
    });
  }
}
