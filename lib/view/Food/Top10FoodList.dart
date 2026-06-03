import 'package:flutter/material.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/constants/server.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/Top10FoodDetailPage.dart';
import '../../Classes/Food Classes/Fat_foodClass.dart';
import '../../Common/colo_extension.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

// top 10 food page
class Top10Foods extends StatefulWidget {
  const Top10Foods({super.key});

  @override
  _Top10FoodsState createState() => _Top10FoodsState();
}

class _Top10FoodsState extends State<Top10Foods> {
  final UserProfileController controller = UserProfileController();
  bool isAscending = false; // To control the sorting order
  String selectedSortOption = "Energy"; // Default sorting option
  String selectedType = "All"; // Default type

  bool isLoadingScreenCheck = true;
  String capitalize(String s) {
    if (s.isEmpty) {
      return s;
    }
    List<String> words = s.split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(' ');
  }

  List<Map<String, dynamic>> _data = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      _data.clear();
      final List<Map<String, dynamic>> data = await controller
          .fetchFstDataFromApi(selectedSortOption, selectedType);
      if (!isAscending) {
        data.sort((a, b) => b['nutritionName'].compareTo(a['nutritionName']));
      } else {
        data.sort((a, b) => a['nutritionName'].compareTo(b['nutritionName']));
      }

      setState(() {
        debugPrint("fghgjghjkmhgkjhkljhljhljhl,k $data");
        _data = data;
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  String checkString(String input) {
    if (input == "Âµg") {
      return "µg";
    } else {
      return input;
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
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
            Languages.of(context)!.labelTop10Food,
            style: TextStyle(
                color: ThemeManager.themeText,
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: ThemeManager.themeColor,
        body: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 16.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [],
              //   ),
              // ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // height: 150,
                      width: media.width * 0.4,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 189, 20, 124),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedType = 'Non Vegetarian';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedType == 'Non Vegetarian'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Non Vegetarian',
                                  style: TextStyle(
                                    color: selectedType == 'Non Vegetarian'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedType = 'Vegetarian';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedType == 'Vegetarian'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Vegetarian',
                                  style: TextStyle(
                                    color: selectedType == 'Vegetarian'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedType = 'All';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedType == 'All'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                    color: selectedType == 'All'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: media.width * 0.4,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 189, 20, 124),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAscending = true;
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: isAscending
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Ascending',
                                  style: TextStyle(
                                    color: isAscending
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAscending = false;
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: !isAscending
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Descending',
                                  style: TextStyle(
                                    color: !isAscending
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      // height: 150,
                      width: media.width * 0.4,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 189, 20, 124),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Energy';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Energy'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Energy',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Energy'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Carbohydrate';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Carbohydrate'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Carbohydrate',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Carbohydrate'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Fat';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Fat'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Fat',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Fat'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Sodium';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Sodium'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Sodium',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Sodium'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            // Add more options similarly for the remaining sorting options
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Dietary fibre';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Dietary fibre'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Dietary fibre',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Dietary fibre'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Calcium';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Calcium'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Calcium',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Calcium'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Iron';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Iron'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Iron',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Iron'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Magnesium';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Magnesium'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Magnesium',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Magnesium'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Zinc';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Zinc'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Zinc',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Zinc'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Protein';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Protein'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Protein',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Protein'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Thiamine';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Thiamine'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Thiamine',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Thiamine'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Riboflavin';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Riboflavin'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Riboflavin',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Riboflavin'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Niacin';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Niacin'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Niacin',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Niacin'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Vitamin B6';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Vitamin B6'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Vitamin B6',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Vitamin B6'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Folate';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Folate'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Folate',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Folate'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Vitamin C';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Vitamin C'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Vitamin C',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Vitamin C'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSortOption = 'Vitamin A';
                                  fetchData();
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                color: selectedSortOption == 'Vitamin A'
                                    ? Colors.white
                                    : Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Vitamin A',
                                  style: TextStyle(
                                    color: selectedSortOption == 'Vitamin A'
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  for (final foodItem in _data)
                    Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Top10FoodDetailsScreen(
                                  foodId: foodItem['id'],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: media.width * 0.52,
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                    color:
                                        TColor.primaryColor1.withOpacity(0.3)),
                                color: ThemeManager.themelightColor),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: media.width * 0.1,
                                  height: media.width * 0.1,
                                  child: Image.network(
                                    "${API.server}/images/${foodItem['foodCode']}.PNG",
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        // Image is fully loaded
                                        return child;
                                      } else {
                                        // Image is still loading
                                        return Center(
                                          child: CircularProgressIndicator(
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
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      // Error occurred while loading image
                                      return SizedBox(
                                        width: 30,
                                        height: 30,
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
                                const SizedBox(
                                  width: 2,
                                ),
                                SizedBox(
                                  width: media.width * 0.2,
                                  child: Text(
                                    foodItem['food'],
                                    style: TextStyle(
                                      color: ThemeManager.themeText,
                                      fontSize: AppFontSizes.mediumDefault,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                // SizedBox(
                                //   width: 10,
                                // ),
                                SizedBox(
                                  width: media.width * 0.18,
                                  child: Text(
                                    //${capitalize(selectedSortOption)}:
                                    "${foodItem['nutritionName'].toStringAsFixed(foodItem['nutritionName'] >= 99 ? 0 : 2)} ${checkString(foodItem['unit'])}",
                                    style: TextStyle(
                                      color: ThemeManager.themeText,
                                      fontSize: AppFontSizes.mediumDefault,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => Top10FoodDetailsScreen(
                  //           foodId: foodItem['id'],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: Container(
                  //       padding: const EdgeInsets.all(8.0),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15.0),
                  //           border: Border.all(
                  //               color: TColor.primaryColor1.withOpacity(0.3)),
                  //           color: ThemeManager.themelightColor),
                  //       margin: EdgeInsets.symmetric(
                  //           vertical: 8.0, horizontal: 12.0),
                  //       child: Row(
                  //         children: [
                  //           Container(
                  //             width: 50,
                  //             height: 50,
                  //             child: Image.network(
                  //               "${API.server}/images/${foodItem['foodCode']}.PNG",
                  //               loadingBuilder: (BuildContext context,
                  //                   Widget child,
                  //                   ImageChunkEvent? loadingProgress) {
                  //                 if (loadingProgress == null) {
                  //                   // Image is fully loaded
                  //                   return child;
                  //                 } else {
                  //                   // Image is still loading
                  //                   return Center(
                  //                     child: CircularProgressIndicator(
                  //                       value: loadingProgress
                  //                                   .expectedTotalBytes !=
                  //                               null
                  //                           ? loadingProgress
                  //                                   .cumulativeBytesLoaded /
                  //                               loadingProgress
                  //                                   .expectedTotalBytes!
                  //                           : null,
                  //                     ),
                  //                   );
                  //                 }
                  //               },
                  //               errorBuilder: (BuildContext context,
                  //                   Object error, StackTrace? stackTrace) {
                  //                 // Error occurred while loading image
                  //                 return Container(
                  //                   width: 50,
                  //                   height: 50,
                  //                   child: Image.asset(
                  //                     'assets/img/raw food.jpeg.png',

                  //                     // height: 50,
                  //                     // width: 100,
                  //                     fit: BoxFit.contain,
                  //                   ),
                  //                 );
                  //               },
                  //             ),
                  //           ),
                  //           const SizedBox(width: 15),
                  //           Expanded(
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   foodItem['food'],
                  //                   style: TextStyle(
                  //                     color: ThemeManager.themeText,
                  //                     fontSize: AppFontSizes.mediumDefault,
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 2,
                  //                 ),
                  //                 // Text(
                  //                 //   (foodItem['category'] == null
                  //                 //       ? '0'
                  //                 //       : foodItem['category']),
                  //                 //   style: TextStyle(
                  //                 //     color: ThemeManager.themeText,
                  //                 //     fontSize: AppFontSizes.smallDefault,
                  //                 //     fontWeight: FontWeight.w500,
                  //                 //   ),
                  //                 // ),
                  //               ],
                  //             ),
                  //           ),
                  //           Text(
                  //             //${capitalize(selectedSortOption)}:
                  //             "${foodItem['nutritionName'].toStringAsFixed(foodItem['nutritionName'] >= 99 ? 0 : 2)} ${foodItem['unit']}",
                  //             style: TextStyle(
                  //               color: ThemeManager.themeText,
                  //               fontSize: AppFontSizes.mediumDefault,
                  //             ),
                  //           )
                  //         ],
                  //       )),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
