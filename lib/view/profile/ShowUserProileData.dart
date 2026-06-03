import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/constants/assets.dart';
import 'package:nin2byo2i/view/profile/UpdateProfileData.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:provider/provider.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';

//user profile data page
class ShowProfileDataScreen extends StatelessWidget {
  const ShowProfileDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    final userProfile = userProfileController.userProfile;
    final userName =
        '${userProfile?.firstName} ${userProfile?.lastName}';
    final gender = '${userProfile?.gender} ';
    // List<String> parts = userProfile!.height.toString().split('.');
    // int feet = int.tryParse(parts[0]) ?? 0;
    // int inches = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    // String formattedHeight = '$feet ft ${inches} in';
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
              "assets/img/ArrowLeft.png",
              color: ThemeManager.themeText,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          '${userProfile?.firstName} ${userProfile?.lastName}',
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
                      color: ThemeManager.themelightColor,
                      offset: const Offset(0, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onSelected: (value) {
                        if (value == 'Edit') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateProfilePage()));
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'Edit',
                              child: Text(
                                'Edit',
                                style: TextStyle(color: ThemeManager.themeText),
                              ),
                            ),
                          ],
                      child: Center(
                        child: Image.asset(
                          "assets/img/more_btn.png",
                          width: 15,
                          height: 15,
                          fit: BoxFit.contain,
                          color: ThemeManager.themeText,
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 5),
              if (gender.trim().toLowerCase() == 'female')
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/img/u2.png'),
                )
              else
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/man.png'),
                ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.person,
                labelText: Languages.of(context)!.labelName,
                value: " ${userProfile?.firstName} ${userProfile?.lastName}",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.person_2,
                labelText: Languages.of(context)!.mainlabelGender,
                value: "${userProfile?.gender.toString()}",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.person,
                labelText: "Wake up time",
                value: "${userProfile?.wakeupTime}",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.phone,
                labelText: Languages.of(context)!.labelPhoneNumber,
                value: "${userProfile?.mobile}",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.email,
                labelText: Languages.of(context)!.labelEmail,
                value: " ${userProfile?.email}",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.fitness_center,
                labelText: Languages.of(context)!.labelWeight,
                value: "${userProfile?.weight.toString()} Kg",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.date_range,
                labelText: Languages.of(context)!.labelDateOfBirth,
                value: DateFormatter.convertDate(userProfile!.Dob),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.height,
                labelText: Languages.of(context)!.labelHeight,
                value:
                    "${userProfile.heightFt} Ft ${userProfile.heightIn} In",
              ),
              const SizedBox(height: 20),
              // CustomTextField(
              //   icon: Icons.sensor_occupied,
              //   labelText: 'Occupation',
              //   value: "${userProfile?.occupation} ",
              // ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.work,
                labelText: Languages.of(context)!.NINTextWorkLevel,
                value: "${userProfile.workLevel} ",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.calculate,
                labelText: Languages.of(context)!.labelBMI,
                value:
                    userProfile.bmi.toStringAsFixed(userProfile.bmi >= 99 ? 0 : 2),
              ),

              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.data_object,
                labelText: Languages.of(context)!.labelAge,
                value: "${userProfile.age.toStringAsFixed(0)} years",
              ),
              const SizedBox(height: 20),
              // CustomShowFieldLink(
              //   svgIconPath: '${Assets.google}',
              //   labelText: Languages.of(context)!.labelGoogleProfileLink,
              //   value: "${userProfile?.googlelink.toString()}",
              // ),
              // const SizedBox(height: 20),
              // CustomShowFieldLink(
              //   svgIconPath: '${Assets.facebook}',
              //   labelText: Languages.of(context)!.labelFacebookProfileLink,
              //   value: "${userProfile?.facebooklink.toString()}",
              // ),
              // const SizedBox(height: 20),
              // CustomShowFieldLink(
              //   svgIconPath: '${Assets.linkedin}',
              //   labelText: Languages.of(context)!.labelLinkedInProfileLink,
              //   value: "${userProfile?.linkdinlink.toString()}",
              // ),
              // const SizedBox(height: 20),
              // CustomShowFieldLink(
              //   svgIconPath: '${Assets.twitter}',
              //   labelText: Languages.of(context)!.labelTwitterProfileLink,
              //   value: " ${userProfile?.twitterlink.toString()}",
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // itemProfile(String title, String subtitle, IconData iconData) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         color: ThemeManager.themeColor,
  //         borderRadius: BorderRadius.circular(40),
  //         boxShadow: [
  //           BoxShadow(
  //               offset: Offset(0, 5),
  //               color: TColor.primaryColor1,
  //               spreadRadius: 2,
  //               blurRadius: 10)
  //         ]),
  //     child: ListTile(
  //       title: Text(
  //         title,
  //         style: TextStyle(color: Colors.black),
  //       ),
  //       subtitle: Text(
  //         subtitle,
  //         style: TextStyle(color: Colors.black),
  //       ),
  //       leading: Icon(
  //         iconData,
  //         color: TColor.primaryColor1,
  //       ),
  //       trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
  //       tileColor: ThemeManager.themeColor,
  //     ),
  //   );
  // }
}

// class CustomTextField extends StatelessWidget {
//   final IconData icon;
//   final String labelText;
//   final String value;

//   const CustomTextField({
//     Key? key,
//     required this.icon,
//     required this.labelText,
//     required this.value,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var mediawidth = MediaQuery.of(context).size.width;
//     return ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           padding: EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: ThemeManager.themelightColor,
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 icon,
//                 color: ThemeManager.themeText,
//               ),
//               SizedBox(width: 12.0),
//               SizedBox(
//                 width: mediawidth * 0.2,
//                 child: Text(
//                   labelText,
//                   style: TextStyle(
//                     color: ThemeManager.themeText,
//                     fontSize: AppFontSizes

//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//               Spacer(),
//               SizedBox(
//                 width: mediawidth * 0.4,
//                 child: Expanded(
//                   child: Text(
//                     value,
//                     textAlign: TextAlign.right,
//                     style: TextStyle(
//                       color: ThemeManager.themeText,
//                       fontSize: AppFontSizes

//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// class CustomShowFieldLink extends StatelessWidget {
//   final String svgIconPath; // Path to your SVG file
//   final String labelText;
//   final String value;
//   const CustomShowFieldLink({
//     Key? key,
//     required this.svgIconPath,
//     required this.labelText,
//     required this.value,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var mediawidth = MediaQuery.of(context).size.width;
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: Container(
//         padding: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: ThemeManager.themelightColor,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Row(
//           children: [
//             // Use SvgPicture.asset to load the SVG icon
//             SvgPicture.asset(
//               svgIconPath,
//               color: ThemeManager.themeText,
//               width: 24, // Adjust the width as needed
//               height: 24, // Adjust the height as needed
//             ),
//             SizedBox(width: 12.0),
//             SizedBox(
//               width: mediawidth * 0.3,
//               child: Text(
//                 labelText,
//                 style: TextStyle(
//                   color: ThemeManager.themeText,
//                   fontSize: AppFontSizes

//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             Spacer(),
//             SizedBox(
//               width: mediawidth * 0.4,
//               child: Expanded(
//                 child: Text(
//                   value,
//                   textAlign: TextAlign.right,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: ThemeManager.themeText,
//                     fontSize: AppFontSizes

//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final String value;

  const CustomTextField({
    Key? key,
    required this.icon,
    required this.labelText,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediawidth = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: ThemeManager.themelightColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: ThemeManager.themeText,
            ),
            const SizedBox(width: 12.0),
            SizedBox(
              width: mediawidth * 0.2,
              child: Text(
                labelText,
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.smallDefault,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: mediawidth * 0.4, // Remove Expanded here
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.smallDefault,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShowFieldLink extends StatelessWidget {
  final String svgIconPath; // Path to your SVG file
  final String labelText;
  final String value;

  const CustomShowFieldLink({
    Key? key,
    required this.svgIconPath,
    required this.labelText,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediawidth = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: ThemeManager.themelightColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            // Use SvgPicture.asset to load the SVG icon
            SvgPicture.asset(
              svgIconPath,
              color: ThemeManager.themeText,
              width: 24, // Adjust the width as needed
              height: 24, // Adjust the height as needed
            ),
            const SizedBox(width: 12.0),
            SizedBox(
              width: mediawidth * 0.3,
              child: Text(
                labelText,
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.smallDefault,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: mediawidth * 0.4, // Remove Expanded here
              child: Text(
                value,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.smallDefault,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
