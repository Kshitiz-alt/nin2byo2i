import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Language/localization/locale_constants.dart';
import 'package:nin2byo2i/Language/model/language_model.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//user setting screen
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String selectedLanguage = "English";
  double fontSize = 16.0;
  bool balckthemeeon = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadinitialdata();
  }

  final UserProfileController _controller = UserProfileController();
  void _showSuccessDialog(BuildContext context, String res) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeManager.themelightColor,
          title: Text(
            Languages.of(context)!.resetPassword,
            style: TextStyle(color: ThemeManager.themeText),
          ),
          content: Text(
            res,
            style: TextStyle(color: ThemeManager.themeText),
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
  }

  Future<void> resetPassword(String email) async {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    try {
      await _controller.ResetPassward(oldPassword, newPassword, email);
      _showSuccessDialog(context, "Password Change Successfully");
      oldPasswordController.clear();
      newPasswordController.clear();
    } catch (e) {
      _showSuccessDialog(context, "$e");
      // debugPrint("error if calldfrjugtjugytjuyed $e ");
      // _showSuccessDialog(context);
      // SnackBar(content: Text('error if calldfrjugtjugytjuyed $e '));
    }

    // // Add your password reset logic here (e.g., validate old password and update with the new password).
    // if (success) {
    //   debugPrint("successfully");
    // } else {
    //   SnackBar(content: Text('error'));
    // }
    // Clear the text fields after the reset.
  }

  Future<void> loadinitialdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isBlackTheme = prefs.getBool('isBlackTheme');

    setState(() {
      if (isBlackTheme == true) {
        balckthemeeon = true;
      }
    });
  }

  bool isBlackTheme = Colors.black == const Color.fromARGB(255, 66, 64, 64);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    final userProfile = userProfileController.userProfile;

    final useremail = '${userProfile?.email} ';
    return WillPopScope(
      onWillPop: () async {
        // Reload the first page when the back button is pressed on the second page
        // Navigator.pushNamed(context, '/root');
        return true; // Prevent the default back navigation behavior
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeManager.themeColor,
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/root');
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
            Languages.of(context)!.labelSetting,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Text(
                //   "Font Size: $fontSize",
                //   style: TextStyle(
                //     color: Colors.black,
                //   ),
                // ),
                // Slider(
                //   value: fontSize,
                //   onChanged: _changeFontSize,
                //   min: 10,
                //   max: 30,
                //   divisions: 4,
                //   label: fontSize.toString(),
                // ),
                // SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  //    height: 59,
                  decoration: ShapeDecoration(
                    color: ThemeManager.themelightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: media.width * 0.45,
                        child: Text(
                          Languages.of(context)!.labelDarkMode,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: AppFontSizes.smallDefault,
                                fontWeight: FontWeight.w800,
                                color: ThemeManager.themeText,
                              ),
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: balckthemeeon,
                        onChanged: (value) {
                          setState(() {
                            balckthemeeon = value;
                            ThemeManager.blackTheme = balckthemeeon;
                            Navigator.pushNamed(context, '/root');
                          });
                        },
                        activeThumbColor:
                            TColor.primaryColor1, // Add your desired color here
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
                sizedBox12(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: 59,
                  decoration: ShapeDecoration(
                    color: ThemeManager.themelightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(children: [
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: media.width * 0.3,
                      child: Text(
                        Languages.of(context)!.labelChangeLanguage,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: AppFontSizes.smallDefault,
                            fontWeight: FontWeight.w800,
                            color: ThemeManager.themeText),
                      ),
                    ),
                    const Spacer(),
                    _createLanguageDropDown(),
                    const SizedBox(
                      width: 8,
                    ),
                  ]),
                ),

                sizedBox12(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: 59,
                  decoration: ShapeDecoration(
                    color: ThemeManager.themelightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: media.width * 0.45,
                        child: Text(
                          Languages.of(context)!.labelPassword,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: AppFontSizes.smallDefault,
                              fontWeight: FontWeight.w800,
                              color: ThemeManager.themeText),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: media.width * 0.4,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: TColor.secondaryColor1,
                          ),
                          // color: TColor.secondaryColor1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        color: ThemeManager.themelightColor,
                                        padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                Languages.of(context)!
                                                    .TextAppResetPassword,
                                                style: TextStyle(
                                                    fontSize: AppFontSizes
                                                        .mediumDefault,
                                                    color:
                                                        ThemeManager.themeText),
                                              ),
                                              TextField(
                                                controller:
                                                    oldPasswordController,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      Languages.of(context)!
                                                          .NINTextOldPassword,
                                                  labelStyle: TextStyle(
                                                      color: ThemeManager
                                                          .themeText), // Change label (hint) text color

                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ThemeManager
                                                            .themeText), // Change focused border color
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    color: ThemeManager
                                                        .themeText), // Change input text color
                                                obscureText: true,
                                              ),
                                              TextField(
                                                controller:
                                                    newPasswordController,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      Languages.of(context)!
                                                          .NINTextNewPassword,
                                                  labelStyle: TextStyle(
                                                      color: ThemeManager
                                                          .themeText), // Change label (hint) text color

                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ThemeManager
                                                            .themeText), // Change focused border color
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    color: ThemeManager
                                                        .themeText), // Change input text color
                                                obscureText: true,
                                              ),
                                              const SizedBox(height: 16.0),
                                              ElevatedButton(
                                                onPressed: () {
                                                  resetPassword(useremail);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: TColor
                                                      .secondaryColor1, // Set the background color to light blue
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0), // Set the border radius
                                                  ),
                                                ),
                                                child: Text(
                                                  Languages.of(context)!
                                                      .resetPassword,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              sizedBox30()
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              // style: ElevatedButton.styleFrom(
                              //   primary: const Color.fromARGB(255, 106, 193,
                              //       233), // Set the background color to light blue
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(
                              //         20.0), // Set the border radius
                              //   ),
                              // ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: media.width * 0.35,
                                    child: Center(
                                      child: Text(
                                        Languages.of(context)!
                                            .TextAppResetPassword,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // ElevatedButton(
                //   onPressed: () {
                //     showModalBottomSheet(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return Container(
                //           padding: EdgeInsets.all(16.0),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             mainAxisSize: MainAxisSize.min,
                //             children: [
                //               Text('Reset Password'),
                //               TextField(
                //                 controller: oldPasswordController,
                //                 decoration: InputDecoration(
                //                   labelText: 'Old Password',
                //                 ),
                //                 obscureText: true,
                //               ),
                //               TextField(
                //                 controller: newPasswordController,
                //                 decoration: InputDecoration(
                //                   labelText: 'New Password',
                //                 ),
                //                 obscureText: true,
                //               ),
                //               SizedBox(height: 16.0),
                //               ElevatedButton(
                //                 onPressed: () {
                //                   resetPassword(
                //                       useremail); // Call your resetPassword method
                //                   Navigator.of(context)
                //                       .pop(); // Close the modal
                //                 },
                //                 child: Text('Reset Password'),
                //               ),
                //             ],
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   child: Text('Reset Password'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _createLanguageDropDown() {
    var media = MediaQuery.of(context).size;
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      //   border: Border.all(color: ThemeManager.themeText),
      // ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: DropdownButton<LanguageModel>(
          style: const TextStyle(color: Colors.white),
          dropdownColor: const Color.fromARGB(255, 189, 20, 124),
          icon: const Icon(Icons.expand_more, color: Colors.black),
          underline: Container(),
          menuMaxHeight: 400,
          hint: SizedBox(
            width: media.width * 0.4,
            child: Text(
              Languages.of(context)!.labelSelectLanguage,
              style: TextStyle(color: ThemeManager.themeText),
              textAlign: TextAlign.end,
            ),
          ),
          onChanged: (LanguageModel? language) {
            if (language != null) {
              changeLanguage(context, language.languageCode);
              debugPrint("langusge code ${language.languageCode}");
              //Navigator.pushNamed(context, '/root');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            }
          },
          items: LanguageModel.languageList()
              .map<DropdownMenuItem<LanguageModel>>(
                (e) => DropdownMenuItem<LanguageModel>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        e.flag,
                        style: const TextStyle(color: Colors.white),
                      ),
                      // Spacer(),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        e.name,
                        style: const TextStyle(
                            fontSize: AppFontSizes.smallDefault,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
