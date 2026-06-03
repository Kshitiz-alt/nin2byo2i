import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
//favourite dish list page  for user

class FavouriteNutrition extends StatefulWidget {
  const FavouriteNutrition({super.key});

  @override
  _FavouriteNutritionState createState() => _FavouriteNutritionState();
}

class _FavouriteNutritionState extends State<FavouriteNutrition> {
  final UserProfileController _controller = UserProfileController();
  List<Map<String, dynamic>> dishes = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Call the function to fetch data when the widget is created
  }

  Future<void> fetchData() async {
    try {
      final data = await _controller.GetFavouriteFoodList();
      setState(() {
        dishes = List<Map<String, dynamic>>.from(data);
      });
    } catch (e) {}
    // final response = await http
    //     .get(Uri.parse('YOUR_API_ENDPOINT')); // Replace with your API endpoint

    // if (response.statusCode == 200) {
    //   // If the server returns a 200 OK response, parse the data
    //   final List<dynamic> apiData = json.decode(response.body);
    //   setState(() {
    //     dishes = List<Map<String, dynamic>>.from(apiData);
    //   });
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // throw an exception or handle the error as needed.
    //   throw Exception('Failed to load data');
    // }
  }

  Future<void> unfavoriteDish(int index, bool status) async {
    try {
      await _controller.UpdateToFavourite(index, status);
      setState(() {
        fetchData();
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Favorites Dishes'),
        // ),
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
            Languages.of(context)!.labelFavouriteDishes,
            style: TextStyle(
                color: ThemeManager.themeText,
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: ThemeManager.themeColor,
        body: (dishes.isEmpty)
            ? Center(
                child: Text(
                  Languages.of(context)!.NINTextNoFavouriteFoodFound,
                  style: const TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    color: Colors.grey,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: dishes.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 8, top: 8),
                      child: Container(
                          // margin:
                          //     const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: ThemeManager.themelightColor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x111D1617),
                                  blurRadius: 40,
                                  offset: Offset(0, 10),
                                  spreadRadius: 0,
                                )
                              ]),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/img/noodles.png',
                                width: 50,
                                height: 50,
                                color: ThemeManager.themeText,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dishes[index]['dishName'],
                                      style: TextStyle(
                                          color: ThemeManager.themeText,
                                          fontSize: AppFontSizes.mediumDefault,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  // Handle tap on the favorite icon
                                  int dishId = dishes[index]['dishId'];
                                  unfavoriteDish(dishId, false);
                                },
                              ),
                            ],
                          )));

                  //    Container(
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.grey),
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 dishes[index]['dishName'],
                  //                 style: TextStyle(
                  //                     color: Colors.black, fontSize: AppFontSizes.mediumDefault),
                  //               ),
                  //             ),
                  //             Spacer(),
                  //             IconButton(
                  //               icon: Icon(
                  //                 Icons.favorite,
                  //                 color: Colors.red,
                  //               ),
                  //               onPressed: () {
                  //                 // Handle tap on the favorite icon
                  //                 int dishId = dishes[index]['dishId'];
                  //                 unfavoriteDish(dishId, false);
                  //               },
                  //             ),
                  //           ],
                  //         ),
                  //         // Padding(
                  //         //   padding: const EdgeInsets.all(8.0),
                  //         //   child: Text(
                  //         //     'Quantity: ${dishes[index]['dishQuantity']}',
                  //         //     style: TextStyle(color: Colors.black),
                  //         //   ),
                  //         // ),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              ));
  }
}
