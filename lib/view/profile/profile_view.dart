import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Help%20Supports/ContactUs.dart';
import 'package:nin2byo2i/Help%20Supports/FeedBack.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Help%20Supports/HelpChat.dart';
import 'package:nin2byo2i/Help%20Supports/Poliices.dart';
import 'package:nin2byo2i/Help%20Supports/UserSetting.dart';
import 'package:nin2byo2i/Help%20Supports/credits.dart';
import 'package:nin2byo2i/Help%20Supports/ShareAppAndBarcode.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Repository/auth_repo.dart';

import 'package:nin2byo2i/custom%20widgets/sized_box.dart';

import 'package:nin2byo2i/view/profile/UpdateProfileData.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/screens/SignIn/login.dart';
import 'package:nin2byo2i/view/home/home_view.dart';
import 'package:nin2byo2i/view/profile/ShowUserProileData.dart';
import 'package:provider/provider.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/setting_row.dart';
import '../../common_widget/title_subtitle_cell.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

//this page will show user profile data
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final UserProfileController _controller = UserProfileController();

  @override
  void initState() {
    super.initState();

    // Fetch the user's profile data and populate the controllers
    final userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    final userProfile = userProfileController.userProfile;

    // firstNameController.text = userProfile!.firstName;
    // lastNameController.text = userProfile.lastName;
    // mobileController.text = userProfile.mobile;
    // weightController.text = userProfile.weight.toString();
    // emailController.text = userProfile.email;
    // heightController.text = userProfile.height.toString();
    initializeData();
  }

  Future<void> initializeData() async {
    final bool mensurationOnOffBool = await _controller.MensurationOnOffBool();
    final bool Notificaytiononoff = await _controller.GetNotificationOnOff();
    MensurationToggle = mensurationOnOffBool;

    setState(() {
      MensurationToggle = mensurationOnOffBool;
      positive = Notificaytiononoff;
    });
  }

  bool positive = false;
  bool MensurationToggle = false;
  // Function to update the notification based on the toggle switch value
  Future<bool> updateNotification(bool newValue) async {
    bool feed = await _controller.onOffMensuration(newValue);
    //  bool notific = await _controller.notificationOnOff(newValue);
    if (feed == true) {
      return newValue;
    } else if (newValue == true) {
      return false;
    } else if (newValue == false) {
      return true;
    }
    return newValue;
  }

  Future<bool> updateNoti(bool newValue) async {
    // bool feed = await _controller.onOffMensuration(newValue);
    bool feed = await _controller.notificationOnOff(newValue);
    if (feed == true) {
      return newValue;
    } else if (newValue == true) {
      return false;
    } else if (newValue == false) {
      return true;
    }
    return newValue;
  }

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    final userProfile = userProfileController.userProfile;
    final userName =
        '${userProfile?.firstName} ${userProfile?.lastName}';
    final gender = '${userProfile?.gender} ';
    //height format here
    // List<String> parts = userProfile!.height.toString().split('.');
    // int feet = int.tryParse(parts[0]) ?? 0;
    // int inches = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    // String formattedHeight = '$feet ft ${inches} in';
    return WillPopScope(
      onWillPop: () async {
        // Navigate to the home screen when the back button is pressed
        // else if (value == 'UpdateProfile') {
        Navigator.pushNamed(context, '/root');

        return false; // Prevent the back operation
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeManager.themeColor,
          centerTitle: true,
          elevation: 0, automaticallyImplyLeading: false,
          // leadingWidth: 0,
          // leading: InkWell(
          //   onTap: () {
          //     // Navigator.pop(context);
          //   },
          //   child: Container(
          //     margin: const EdgeInsets.all(8),
          //     height: 40,
          //     width: 40,
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //         color: ThemeManager.themelightColor,
          //         borderRadius: BorderRadius.circular(10)),
          //     child: Image.asset(
          //       "assets/img/black_btn.png",
          //       width: 15,
          //       height: 15,
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          // ),
          title: Text(
            // "Profile",
            Languages.of(context)!.labelProfile,
            style: TextStyle(
                color: ThemeManager.themeText,
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.w700),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                    width: 32,
                    height: 32,
                    child: PopupMenuButton<String>(
                      offset: const Offset(0, 30),
                      color: ThemeManager.themelightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onSelected: (value) {
                        // if (value == 'Feedback') {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => FeedbackPage()));
                        //   // Navigator.pushNamed(context, '/MealShedule');
                        // } else
                        if (value == 'help') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HelpScreen()));
                        }
                        // else if (value == 'UpdateProfile') {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => UpdateProfilePage()));
                        // }
                        else if (value == 'logout') {
                          confirmLogout(context);
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        // PopupMenuItem<String>(
                        //   value: 'Feedback',
                        //   child: Text('Feedback'),
                        // ),
                        // PopupMenuItem<String>(
                        //   value: 'UpdateProfile',
                        //   child: Text('UpdateProfile'),
                        // ),
                        PopupMenuItem<String>(
                          value: 'help',
                          child: Text(
                            Languages.of(context)!.labelHelp,
                            style: TextStyle(color: ThemeManager.themeText),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'logout',
                          child: Text(
                            Languages.of(context)!.labelLogout,
                            style: TextStyle(color: ThemeManager.themeText),
                          ),
                        ),
                      ],
                      child: Center(
                          child: Icon(
                        Icons.more_horiz,
                        color: ThemeManager.themeText,
                      )),
                    ),
                  );
                },
              ),
            ),
            // InkWell(
            //   onTap: () {},
            //   child: Container(
            //     margin: const EdgeInsets.all(8),
            //     height: 40,
            //     width: 40,
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //         color: ThemeManager.themelightColor,
            //         borderRadius: BorderRadius.circular(10)),
            //     child: Image.asset(
            //       "assets/img/more_btn.png",
            //       width: 15,
            //       height: 15,
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // )
          ],
        ),
        backgroundColor: ThemeManager.themeColor,
        body: RefreshIndicator(
          color:
              TColor.secondaryColor1, // Set the color of the refresh indicator
          backgroundColor: TColor.primaryColor1,
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      if (gender.trim().toLowerCase() == 'female')
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            "assets/img/u2.png",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'assets/images/man.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                color: ThemeManager.themeText,
                                fontSize: AppFontSizes.mediumDefault,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              // "Lose a Fat Program",
                              Languages.of(context)!
                                  .ninTextAchieveYourHealthGoals,
                              style: TextStyle(
                                color: ThemeManager.themeText,
                                fontSize: AppFontSizes.smallDefault,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        // height: 25,
                        child: RoundButton(
                          title: Languages.of(context)!.labelEdit,
                          type: RoundButtonType.bgGradient,
                          fontSize: AppFontSizes.smallDefault,
                          fontWeight: FontWeight.w400,
                          onPressed: () async {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const ActivityTrackerView(),
                            //   ),
                            // );
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateProfilePage()));
                            setState(() {
                              final userProfileController =
                                  Provider.of<UserProfileController>(context,
                                      listen: false);
                              final userProfile =
                                  userProfileController.userProfile;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TitleSubtitleCell(
                          title:
                              "${userProfile?.heightFt.toStringAsFixed(0)} Ft ${userProfile?.heightIn.toStringAsFixed(0)} In",
                          subtitle: Languages.of(context)!.labelHeight,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TitleSubtitleCell(
                          title: '${userProfile?.weight.toString()} kg',
                          subtitle: Languages.of(context)!.labelWeight,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TitleSubtitleCell(
                          title:
                              '${userProfile?.age.toStringAsFixed(0)} years ',
                          subtitle: Languages.of(context)!.labelAge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: ThemeManager.themelightColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: ThemeManager.themeText, blurRadius: 0.1)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Languages.of(context)!.labelAccount,
                          style: TextStyle(
                            color: ThemeManager.themeText,
                            fontSize: AppFontSizes.mediumDefault,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SettingRow(
                          icon: 'assets/img/p_personal.png',
                          title: Languages.of(context)!.labelPersonalData,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ShowProfileDataScreen()));
                          },
                        ),
                        // SettingRow(
                        //   icon: "assets/img/p_achi.png",
                        //   title: Languages.of(context)!.labelAchievement,
                        //   onPressed: () {
                        //     //  Navigator.push(
                        //     //     context,
                        //     //     MaterialPageRoute(
                        //     //         builder: (context) =>
                        //     //             MyLocation()));
                        //   },
                        // ),
                        // SettingRow(
                        //   icon: "assets/img/p_activity.png",
                        //   title: Languages.of(context)!.labelActivityHistory,
                        //   onPressed: () {},
                        // ),
                        // SettingRow(
                        //   icon: "assets/img/p_workout.png",
                        //   title: Languages.of(context)!.labelWorkoutProgress,
                        //   onPressed: () {},
                        // ),
                        // ListView.builder(
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemCount: accountArr.length,
                        //   itemBuilder: (context, index) {
                        //     var iObj = accountArr[index] as Map? ?? {};
                        //     return SettingRow(
                        //       icon: iObj["image"].toString(),
                        //       title: iObj["name"].toString(),
                        //       onPressed: () {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) =>
                        //                     ShowProfileDataScreen()));
                        //       },
                        //     );
                        //   },
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: ThemeManager.themelightColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: ThemeManager.themeText, blurRadius: 0.1)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Languages.of(context)!.labelNotification,
                          style: TextStyle(
                            color: ThemeManager.themeText,
                            fontSize: AppFontSizes.mediumDefault,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // SizedBox(
                        //   height: 30,
                        //   child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Image.asset("assets/img/p_notification.png",
                        //             height: 15, width: 15, fit: BoxFit.contain),
                        //         const SizedBox(
                        //           width: 15,
                        //         ),
                        //         Expanded(
                        //           child: Text(
                        //             Languages.of(context)!
                        //                 .labelPopupNotification,
                        //             style: TextStyle(
                        //               color: Colors.black,
                        //               fontSize: AppFontSizes

                        //             ),
                        //           ),
                        //         ),
                        //         CustomAnimatedToggleSwitch<bool>(
                        //           current: positive,
                        //           values: [false, true],
                        //           dif: 0.0,
                        //           indicatorSize: Size.square(30.0),
                        //           animationDuration:
                        //               const Duration(milliseconds: 200),
                        //           animationCurve: Curves.linear,
                        //           onChanged: (b) =>
                        //               setState(() => positive = b),
                        //           iconBuilder: (context, local, global) {
                        //             return const SizedBox();
                        //           },
                        //           defaultCursor: SystemMouseCursors.click,
                        //           onTap: () =>
                        //               setState(() => positive = !positive),
                        //           iconsTappable: false,
                        //           wrapperBuilder: (context, global, child) {
                        //             return Stack(
                        //               alignment: Alignment.center,
                        //               children: [
                        //                 Positioned(
                        //                     left: 10.0,
                        //                     right: 10.0,
                        //                     height: 30.0,
                        //                     child: DecoratedBox(
                        //                       decoration: BoxDecoration(
                        //                         gradient: LinearGradient(
                        //                             colors: TColor.secondaryG),
                        //                         borderRadius:
                        //                             const BorderRadius.all(
                        //                                 Radius.circular(50.0)),
                        //                       ),
                        //                     )),
                        //                 child,
                        //               ],
                        //             );
                        //           },
                        //           foregroundIndicatorBuilder:
                        //               (context, global) {
                        //             return SizedBox.fromSize(
                        //               size: const Size(10, 10),
                        //               child: DecoratedBox(
                        //                 decoration: BoxDecoration(
                        //                   color: ThemeManager.themeColor,
                        //                   borderRadius: const BorderRadius.all(
                        //                       Radius.circular(50.0)),
                        //                   boxShadow: [
                        //                     BoxShadow(
                        //                         color: Colors.black,
                        //                         spreadRadius: 0.05,
                        //                         blurRadius: 1.1,
                        //                         offset: Offset(0.0, 0.8))
                        //                   ],
                        //                 ),
                        //               ),
                        //             );
                        //           },
                        //         ),
                        //       ]),
                        // ),
                        SizedBox(
                          height: 30,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/img/p_notification.png",
                                    height: 15, width: 15, fit: BoxFit.contain),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    Languages.of(context)!
                                        .labelPopupNotification,
                                    style: TextStyle(
                                      color: ThemeManager.themeText,
                                      fontSize: AppFontSizes.mediumDefault,
                                    ),
                                  ),
                                ),
                                CustomAnimatedToggleSwitch<bool>(
                                  current: positive,
                                  values: const [false, true],
                                  dif: 0.0,
                                  indicatorSize: const Size.square(30.0),
                                  animationDuration:
                                      const Duration(milliseconds: 100),
                                  animationCurve: Curves.linear,
                                  onChanged: (newValue) {},
                                  iconBuilder: (context, local, global) {
                                    return const SizedBox();
                                  },
                                  defaultCursor: SystemMouseCursors.click,
                                  onTap: () async {
                                    debugPrint('Toggle switch onChanged: ');
                                    positive = !positive;
                                    bool newPositive =
                                        await updateNoti(positive);
                                    debugPrint('new flag is here $newPositive');
                                    setState(() => positive = newPositive);
                                  },
                                  iconsTappable: false,
                                  wrapperBuilder: (context, global, child) {
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          left: 10.0,
                                          right: 10.0,
                                          height: 30.0,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: positive
                                                      ? [
                                                          const Color(0xFF007BC1),
                                                          const Color(0xFF007BC1)
                                                        ]
                                                      : TColor
                                                          .secondaryG), // Change color to grey when off
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50.0)),
                                            ),
                                          ),
                                        ),
                                        child,
                                      ],
                                    );
                                  },
                                  foregroundIndicatorBuilder:
                                      (context, global) {
                                    return SizedBox.fromSize(
                                      size: const Size(10, 10),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: ThemeManager
                                              .themeColor, // Change color to grey when off
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50.0)),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 0.05,
                                              blurRadius: 1.1,
                                              offset: Offset(0.0, 0.8),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        if (gender.trim().toLowerCase() == 'female')
                          SizedBox(
                            height: 30,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/img/p_notification.png",
                                      height: 15,
                                      width: 15,
                                      fit: BoxFit.contain),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      Languages.of(context)!
                                          .labelMensurationCycle,
                                      style: TextStyle(
                                        color: ThemeManager.themeText,
                                        fontSize: AppFontSizes.smallDefault,
                                      ),
                                    ),
                                  ),
                                  CustomAnimatedToggleSwitch<bool>(
                                    current: MensurationToggle,
                                    values: const [false, true],
                                    dif: 0.0,
                                    indicatorSize: const Size.square(30.0),
                                    animationDuration:
                                        const Duration(milliseconds: 100),
                                    animationCurve: Curves.linear,
                                    onChanged: (newValue) {},
                                    iconBuilder: (context, local, global) {
                                      return const SizedBox();
                                    },
                                    defaultCursor: SystemMouseCursors.click,
                                    onTap: () async {
                                      debugPrint('Toggle switch onChanged: ');
                                      MensurationToggle = !MensurationToggle;
                                      bool newPositive =
                                          await updateNotification(
                                              MensurationToggle);
                                      debugPrint('new flag is here $newPositive');
                                      setState(() =>
                                          MensurationToggle = newPositive);
                                    },
                                    iconsTappable: false,
                                    wrapperBuilder: (context, global, child) {
                                      return Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                              left: 10.0,
                                              right: 10.0,
                                              height: 30.0,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: MensurationToggle
                                                          ? [
                                                              const Color(0xFF007BC1),
                                                              const Color(0xFF007BC1)
                                                            ]
                                                          : TColor.secondaryG),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              50.0)),
                                                ),
                                              )),
                                          child,
                                        ],
                                      );
                                    },
                                    foregroundIndicatorBuilder:
                                        (context, global) {
                                      return SizedBox.fromSize(
                                        size: const Size(10, 10),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: ThemeManager.themeColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50.0)),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  spreadRadius: 0.05,
                                                  blurRadius: 1.1,
                                                  offset: Offset(0.0, 0.8))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ]),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: ThemeManager.themelightColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: ThemeManager.themeText, blurRadius: 0.1)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Languages.of(context)!.labelOther,
                          style: TextStyle(
                            color: ThemeManager.themeText,
                            fontSize: AppFontSizes.mediumDefault,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SettingRow(
                          icon: "assets/img/p_contact.png",
                          title: Languages.of(context)!.labelContactUs,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUsPage()));
                          },
                        ),
                        SettingRow(
                          icon: "assets/img/p_privacy.png",
                          title: Languages.of(context)!.labelPrivacyPolicy,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrivacyPolicyPage()));
                          },
                        ),
                        SettingRow(
                          icon: "assets/img/p_setting.png",
                          title: Languages.of(context)!.labelSetting,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsPage()));
                          },
                        ),

                        SettingRow(
                          icon: "assets/img/p_contact.png",
                          title: Languages.of(context)!.labelFeedback,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeedbackPage()));
                          },
                        ),
                        SettingRow(
                          icon: "assets/img/p_contact.png",
                          title: Languages.of(context)!.labelCredits,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HealthAppCreditsPage()));
                          },
                        ),
                        // ListView.builder(
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   padding: EdgeInsets.zero,
                        //   shrinkWrap: true,
                        //   itemCount: otherArr.length,
                        //   itemBuilder: (context, index) {
                        //     var iObj = otherArr[index] as Map? ?? {};
                        //     return SettingRow(
                        //       icon: iObj["image"].toString(),
                        //       title: iObj["name"].toString(),
                        //       onPressed: () {},
                        //     );
                        //   },
                        // )
                      ],
                    ),
                  ),
                  // QRCodeScreen(
                  //     url:
                  //         'https://play.google.com/store/apps/details?id=com.ionicframework.myapp863035&hl'),
                  ShareAppAndBarcode(
                    url: userProfile?.androidLink == null
                        ? ""
                        : "${userProfile?.androidLink}",
                    text: userProfile?.messageOfLink == null
                        ? ""
                        : "${userProfile?.messageOfLink}",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void confirmLogout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ThemeManager.themelightColor,
        title: Text(
          Languages.of(context)!.labelConfirmLogout,
          style: TextStyle(
            color: ThemeManager.themeText,
          ),
        ),
        content: Text(
          Languages.of(context)!.labelConfirmLogoutMessage,
          style: TextStyle(
            color: ThemeManager.themeText,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              Languages.of(context)!.cancel,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              Languages.of(context)!.labelLogout,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            onPressed: () async {
              try {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('token'); // Remove the token from storage
                await prefs.remove('refreshToken');
                //  await AuthRepo.clearToken();
                await FirebaseAuth.instance.signOut();

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                  (route) => false,
                );
              } catch (e) {
                debugPrint('Error during logout: $e');
              }
            },
          ),
        ],
      );
    },
  );
}
