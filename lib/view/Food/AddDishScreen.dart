import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/DishSelectionOptions.dart';
import 'package:nin2byo2i/view/Food/AddCustomDish1.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';

//add dish selection page type of meal-breakfast,dinner,lunch etc..
class AddDishScreen extends StatelessWidget {
  const AddDishScreen({super.key});

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
          Languages.of(context)!.labelFoodTable,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedBox30(),
              sizedBox30(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDishPage(
                            dishType:
                                Languages.of(context)!.mainlabelEarlyMorning,
                            dishTypeSendForBackened: 'Early Morning',
                          ),
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OptionPage(
                      //             Languages.of(context)!.labelDinner,
                      //             "assets/img/dinner.jpg")));
                    },
                    child: Foodlisttype(
                      fObj: {
                        "name": Languages.of(context)!.mainlabelEarlyMorning,
                        "image": "assets/img/early_morning_lemon_tea.jpg",
                        "number": "120+ Foods"
                      },
                      index: 3,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDishPage(
                            dishType: Languages.of(context)!.labelBreakfast,
                            dishTypeSendForBackened: "Breakfast",
                          ),
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OptionPage(
                      //             Languages.of(context)!.labelBreakfast,
                      //             "assets/img/mid_morning.jpg")));
                    },
                    child: Foodlisttype(
                      fObj: {
                        "name": Languages.of(context)!.labelBreakfast,
                        "image": "assets/img/breakfast.jpg",
                        "number": "120+ Foods"
                      },
                      index: 1,
                    ),
                  ),
                ],
              ),
              sizedBox12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDishPage(
                            dishType:
                                Languages.of(context)!.mainlabelMidMorning,
                            dishTypeSendForBackened: "Mid Morning",
                          ),
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OptionPage(
                      //             Languages.of(context)!.labelBreakfast,
                      //             "assets/img/mid_morning.jpg")));
                    },
                    child: Foodlisttype(
                      fObj: {
                        "name": Languages.of(context)!.mainlabelMidMorning,
                        "image": "assets/img/mid_morning.jpg",
                        "number": "120+ Foods"
                      },
                      index: 1,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDishPage(
                            dishType: Languages.of(context)!.labelLunch,
                            dishTypeSendForBackened: "Lunch",
                          ),
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OptionPage(
                      //             Languages.of(context)!.labelLunch,
                      //             "assets/img/lunch.jpg")));
                    },
                    child: Foodlisttype(
                      fObj: {
                        "name": Languages.of(context)!.labelLunch,
                        "image": "assets/img/lunch.jpg",
                        "number": "120+ Foods"
                      },
                      index: 2,
                    ),
                  ),
                ],
              ),
              sizedBox12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDishPage(
                            dishType: Languages.of(context)!.mainlabelEvening,
                            dishTypeSendForBackened: "Evening",
                          ),
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OptionPage(
                      //             Languages.of(context)!.labelSnacks,
                      //             "assets/img/bed time.jpg")));
                    },
                    child: Foodlisttype(
                      fObj: {
                        "name": Languages.of(context)!.mainlabelEvening,
                        "image": "assets/img/evening.jpg",
                        "number": "120+ Foods"
                      },
                      index: 4,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDishPage(
                            dishType: Languages.of(context)!.labelDinner,
                            dishTypeSendForBackened: "Dinner",
                          ),
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OptionPage(
                      //             Languages.of(context)!.labelDinner,
                      //             "assets/img/dinner.jpg")));
                    },
                    child: Foodlisttype(
                      fObj: {
                        "name": Languages.of(context)!.labelDinner,
                        "image": "assets/img/dinner.jpg",
                        "number": "120+ Foods"
                      },
                      index: 3,
                    ),
                  ),
                ],
              ),
              sizedBox12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDishPage(
                            dishType: Languages.of(context)!.mainlabelBedtime,
                            dishTypeSendForBackened: "Bed Time",
                          ),
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OptionPage(
                      //             Languages.of(context)!.labelSnacks,
                      //             "assets/img/bed time.jpg")));
                    },
                    child: Foodlisttype(
                      fObj: {
                        "name": Languages.of(context)!.mainlabelBedtime,
                        "image": "assets/img/bed time.jpg",
                        "number": "120+ Foods"
                      },
                      index: 4,
                    ),
                  ),
                ],
              ),
              sizedBox30(),
            ],
          ),
        ),
      ),
    );
  }
}

class Foodlisttype extends StatelessWidget {
  final Map fObj;
  final int index;
  const Foodlisttype({super.key, required this.index, required this.fObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    bool isEvent = index % 2 == 0;
    return Column(
      children: [
        Container(
          // padding: const EdgeInsets.all(8.0),
          width: 143,
          height: 143,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            // shadows: [
            //   BoxShadow(
            //     color: Color(0xAA15B8FF),
            //     blurRadius: 4,
            //     offset: Offset(0, 4),s
            //     spreadRadius: 0,
            //   )
            // ],
          ),
          child: Image.asset(fObj["image"].toString()),
        ),
        sizedBox30(),
        Text(
          fObj["name"],
          style: const TextStyle(
            color: Color(0xFF007BC1),
            fontSize: AppFontSizes.mediumDefault,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            height: 0.09,
          ),
        )
      ],
    );

    //  Container(
    //   margin: const EdgeInsets.all(8),
    //   width: media.width * 0.5,
    //   decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //         colors: isEvent
    //             ? [
    //                 TColor.primaryColor2.withOpacity(0.5),
    //                 TColor.primaryColor1.withOpacity(0.5)
    //               ]
    //             : [
    //                 TColor.secondaryColor2.withOpacity(0.5),
    //                 TColor.secondaryColor1.withOpacity(0.5)
    //               ],
    //       ),
    //       borderRadius: const BorderRadius.only(
    //           topLeft: Radius.circular(25),
    //           topRight: Radius.circular(75),
    //           bottomLeft: Radius.circular(25),
    //           bottomRight: Radius.circular(25))),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           Image.asset(
    //             fObj["image"].toString(),
    //             width: media.width * 0.3,
    //             height: media.width * 0.25,
    //             fit: BoxFit.contain,
    //           )
    //         ],
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 15),
    //         child: Text(
    //           fObj["name"],
    //           style: TextStyle(
    //               color: Colors.black,
    //               fontSize: AppFontSizes .mediumDefault,
    //               fontWeight: FontWeight.w500),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 15),
    //         child: Text(
    //           fObj["number"],
    //           style: TextStyle(color: Colors.black, fontSize: AppFontSizes

    //         ),
    //       ),
    //       const SizedBox(
    //         height: 15,
    //       ),
    //     ],
    //   ),
    // );
  }
}
