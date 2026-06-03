import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common/colo_extension.dart';
import 'package:nin2byo2i/common_widget/CustomTextEditing.dart';
import 'package:nin2byo2i/constants/assets.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Classes/userprofileModal.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';

//update user profile page
class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TimeOfDay _selectedTime = TimeOfDay.now();

  late TimeOfDay selectedTime;
  String formattedTime = '';
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        formattedTime = _formatTime(picked);
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final int hour = time.hour;
    final int minute = time.minute;
    final String formattedHour = hour.toString().padLeft(2, '0');
    final String formattedMinute = minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute';
  }

  String convert12to24(String time12hr) {
    // Extract hours, minutes, and period (AM/PM)
    int hours = int.parse(time12hr.substring(0, 2));
    int minutes = int.parse(time12hr.substring(3, 5));
    String period = time12hr
        .substring(6, 8)
        .toUpperCase(); // Convert to uppercase for consistency

    // Handle special cases for 12 AM and 12 PM
    if (hours == 12) {
      hours = (period == "AM") ? 0 : 12;
    } else {
      hours = (period == "AM") ? hours : hours + 12;
    }

    // Format hours and minutes to 24-hour format
    String hours24 = hours.toString().padLeft(2, '0');
    String minutes24 = minutes.toString().padLeft(2, '0');

    // Return the formatted time
    return '$hours24:$minutes24';
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController heightFtController = TextEditingController();
  final TextEditingController heightInController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController googleController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final _controller = TextEditingController();
  late DateTime _dateOfBirth;
  String _activityLevel = '';

  Map<String, String> getActivityDescriptions(BuildContext context) {
    return {
      'Sedentary': Languages.of(context)!.sedentaryDescription,
      'Moderate': Languages.of(context)!.moderateDescription,
      'Heavy': Languages.of(context)!.heavyDescription,
    };
  }

  // Map<String, String> _activityDescriptions = {
  //   'Sedentary':
  //       'This category includes occupations with little to no physical movement throughout the day. People in these jobs spend most of their time sitting or lying down. Examples include office workers, teachers, and those in administrative roles.',
  //   'Moderate':
  //       'Individuals in this category engage in some level of physical activity, such as walking or light jogging, for around 30 minutes to an hour daily. Occupations like manual laborers, artisans, and some types of skilled workers fall into this category.',
  //   'Heavy':
  //       'This category comprises occupations involving regular and intense physical activity, such as running, cycling, or heavy lifting, for more than an hour each day. Examples include blacksmiths, miners, and construction workers.'
  // };

  // final TextEditingController occupationController = TextEditingController();

// Fetch occupations and update the state

  // Function to handle submission

  final UserProfileController _controller1 = UserProfileController();

  // Initial Dropdown value

  // List of occupations
  final List<String> _occupations = [];
  @override
  void initState() {
    super.initState();

    // Fetch the user's profile data and populate the controllers
    final userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    final userProfile = userProfileController.userProfile;

    firstNameController.text = userProfile!.firstName;
    lastNameController.text = userProfile.lastName;
    mobileController.text = userProfile.mobile;
    weightController.text = userProfile.weight.toString();
    emailController.text = userProfile.email;
    heightFtController.text = userProfile.heightFt.toString();
    heightInController.text = userProfile.heightIn.toString();
    ageController.text = userProfile.age.toString();
    googleController.text = userProfile.googlelink.toString();
    facebookController.text = userProfile.facebooklink.toString();
    linkedinController.text = userProfile.linkdinlink.toString();
    twitterController.text = userProfile.twitterlink.toString();
    _activityLevel = userProfile.workLevel.toString();
    _controller.text = userProfile.Dob;

    // occupationController.text = userProfile.occupation.toString();

    // setState(() {
    //   _selectedOccupation = userProfile.occupation.toString();
    // });
    selectedTime = TimeOfDay.now();
    formattedTime = _formatTime(selectedTime);
    formattedTime = userProfile.wakeupTime;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> activityDescriptions =
        getActivityDescriptions(context);
    final userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    final userProfile = userProfileController.userProfile;
    final userName =
        '${userProfile?.firstName} ${userProfile?.lastName}';
    // formattedTime = userProfile?.wakeupTime ?? formattedTime;
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
          "Update Profile",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  CustomTextField(
                    icon: Icons.person,
                    labelText: Languages.of(context)!.firstname,
                    controller: firstNameController,
                    keyboardType:
                        TextInputType.name, // Phone number keyboard type
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    icon: Icons.person,
                    labelText: Languages.of(context)!.lastname,
                    controller: lastNameController,
                    keyboardType:
                        TextInputType.name, // Phone number keyboard type
                  ),
                  // const SizedBox(height: 20),
                  // CustomTextField(
                  //   icon: Icons.phone,
                  //   labelText: Languages.of(context)!.labelPhoneNumber,
                  //   controller: mobileController,
                  //   keyboardType:
                  //       TextInputType.phone, // Phone number keyboard type
                  // ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Wake Up Time: $formattedTime',
                        style: const TextStyle(fontSize: AppFontSizes.largeDefault),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _selectTime(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColor.primaryColor1, // Background color

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Adjust the border radius to your preference
                          ),
                        ),
                        child: Text(
                          "Change",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: TextFormField(
                      controller: _controller,
                      validator: (value) =>
                          value!.isEmpty ? 'Date of Birth is Required' : null,
                      readOnly: true,
                      onChanged: (value) {
                        _dateOfBirth = DateTime.parse(value);
                      },
                      style: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.mediumDefault,
                      ),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: ThemeManager.themelightColor,
                          labelText: 'Date of Birth',
                          labelStyle: TextStyle(
                            color: ThemeManager.themeText,
                            fontSize: AppFontSizes.smallDefault,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_month,
                            color: ThemeManager.themeText,
                          ),
                          border: InputBorder.none),
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                primaryColor: ThemeManager
                                    .themelightColor, // Background color of the header

                                colorScheme: ColorScheme.dark(
                                  primary: TColor
                                      .primaryColor1, // Background color of the calendar
                                  onPrimary: Colors
                                      .white, // Text color of the calendar
                                  surface: TColor
                                      .primaryColor1, // Background color of the modal
                                  onSurface:
                                      Colors.white, // Text color of the modal
                                ), // Background color of the modal
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: TColor
                                        .primaryColor1, // Color of the "OK" button
                                  ),
                                ), dialogTheme: DialogThemeData(backgroundColor: Color.fromARGB(255, 91,
                                    92, 92)),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (date != null) {
                          // Calculate age based on selected date
                          int age =
                              DateTime.now().difference(date).inDays ~/ 365;

                          // Check if age is within the valid range
                          if (age >= 2 && age <= 100) {
                            setState(() {
                              _dateOfBirth = date;
                              _controller.text =
                                  DateFormat('yyyy-MM-dd').format(date);
                              // DateFormat('MM/dd/yyyy').format(date);
                              debugPrint("dsfgdbfhfgngn ${_controller.text}");
                            });
                          } else {
                            // Show an error message for invalid age
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.white,
                                  duration: const Duration(seconds: 2),
                                  content: Text(
                                    Languages.of(context)!
                                        .ageMustBeBetween2And100Years,
                                    style: const TextStyle(color: Colors.red),
                                  )),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    icon: Icons.fitness_center,
                    labelText: "${Languages.of(context)!.labelWeight} (kg)",
                    controller: weightController,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true), // Numeric keyboard type
                  ),
                  // const SizedBox(height: 20),
                  // CustomTextField(
                  //   icon: Icons.email,
                  //   labelText: Languages.of(context)!.labelEmail,
                  //   controller: emailController,
                  //   keyboardType:
                  //       TextInputType.emailAddress, // Email keyboard type
                  // ),
                  const SizedBox(
                    height: 12,
                  ),
                  // Center(
                  //   child: _occupations.isNotEmpty
                  //       ? Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             SizedBox(
                  //               width: 10,
                  //             ),
                  //             Text(
                  //               "select Occupation",
                  //               style: TextStyle(
                  //                 fontSize: AppFontSizes.mediumDefault,
                  //                 fontFamily: 'Poppins',
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //             Spacer(),
                  //             Container(
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(
                  //                     20.0), // Adjust the radius as needed
                  //                 color: ThemeManager
                  //                     .themelightColor, // Adjust the color as needed
                  //               ),
                  //               child: Padding(
                  //                 padding: const EdgeInsets.all(4.0),
                  //                 child: DropdownButton<String>(
                  //                   value: worklevel,
                  //                   style: TextStyle(
                  //                       color: ThemeManager.themeText),
                  //                   dropdownColor: ThemeManager.themelightColor,
                  //                   menuMaxHeight: 400,
                  //                   onChanged: (newValue) {
                  //                     setState(() {
                  //                       worklevel = newValue!;
                  //                       debugPrint("Dvfdgbfdhfgjhg $worklevel");
                  //                     });
                  //                   },
                  //                   items: _occupations
                  //                       .map<DropdownMenuItem<String>>(
                  //                           (String value) {
                  //                     return DropdownMenuItem<String>(
                  //                       value: value,
                  //                       child: Text(value),
                  //                     );
                  //                   }).toList(),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         )
                  //       : CircularProgressIndicator(), // Show loading indicator while fetching data
                  // ),
                  // const SizedBox(height: 20),
                  // CustomTextField(
                  //   icon: Icons.sensor_occupied,
                  //   labelText: 'Occupation',
                  //   controller: occupationController,
                  //   keyboardType:
                  //       TextInputType.emailAddress, // Email keyboard type
                  // ),
                  const SizedBox(height: 20),
                  Container(
                    padding:
                        const EdgeInsets.all(8.0), // Adjust padding for small size
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0), // Adjust margin if needed
                    // constraints: BoxConstraints(
                    //   maxWidth:
                    //       300.0, // Set a max width to control size
                    // ),
                    color: ThemeManager.themelightColor
                        .withOpacity(0.4), // Set background color to grey
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text to the start
                      children: [
                        const Text(
                          "Enter your height in feet and inches (e.g. 5 feet 9 inch)",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: CustomTextField(
                                icon: Icons.height,
                                labelText:
                                    '${Languages.of(context)!.labelHeight} in Feet',
                                controller: heightFtController,
                                keyboardType: const TextInputType.numberWithOptions(
                                    decimal: true), // Numeric keyboard type
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 150,
                              child: CustomTextField(
                                icon: Icons.height,
                                labelText:
                                    '${Languages.of(context)!.labelHeight} in inches',
                                controller: heightInController,
                                keyboardType: const TextInputType.numberWithOptions(
                                    decimal: true), // Numeric keyboard type
                              ),
                            ),
                          ],
                        ),

                        // SizedBox(
                        //     height: 8.0), // Add space between texts
                        // Text(
                        //   'Inches: Enter the number of inches (e.g., 9 for 9 inches). Make sure the number of inches is between 0 and 11.',
                        //   style: TextStyle(fontSize: 10),
                        // ),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 12,
                  // ),
                  // Center(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       // ElevatedButton(
                  //       //   onPressed: () => _selectTime(context),
                  //       //   child: Text('Select Time'),
                  //       // ),
                  //       // SizedBox(height: 20),
                  //       Text(
                  //         'Wake Up Time: ${_selectedTime.format(context)}',
                  //         style: TextStyle(fontSize: AppFontSizes.largeDefault),
                  //       ),
                  //       InkWell(
                  //         onTap: () => _selectTime(context),
                  //         child: Expanded(
                  //           child: Container(
                  //             width: 90,
                  //             height: 48,
                  //             decoration: ShapeDecoration(
                  //               color: TColor.primaryColor1,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(14),
                  //               ),
                  //             ),
                  //             child: const Center(
                  //                 child: Text(
                  //               'Change',
                  //               style: TextStyle(color: Colors.black),
                  //             )),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: ThemeManager.themelightColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, top: 8),
                            child: Text(
                              '${Languages.of(context)!.ninTextHowActiveAreYou}?',
                              style: const TextStyle(
                                fontSize: AppFontSizes.mediumDefault,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          RadioListTile(
                            title: const Text('Sedentary'),
                            activeColor: TColor.primaryColor1,
                            subtitle: Text(activityDescriptions['Sedentary']!),
                            value: 'Sedentary',
                            groupValue: _activityLevel,
                            onChanged: (value) {
                              setState(() {
                                _activityLevel = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Text('Moderate'),
                            activeColor: TColor.primaryColor1,
                            subtitle: Text(activityDescriptions['Moderate']!),
                            value: 'Moderate',
                            groupValue: _activityLevel,
                            onChanged: (value) {
                              setState(() {
                                _activityLevel = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Text('Heavy'),
                            activeColor: TColor.primaryColor1,
                            subtitle: Text(activityDescriptions['Heavy']!),
                            value: 'Heavy',
                            groupValue: _activityLevel,
                            onChanged: (value) {
                              setState(() {
                                _activityLevel = value!;
                              });
                            },
                          ),
                          // SizedBox(height: 20.0),
                          // Text(
                          //   'Selected Activity Level: $_activityLevel',
                          //   style: TextStyle(
                          //     fontSize: AppFontSizes.mediumDefault.0,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // CustomEditableFieldLink(
                  //   svgIconPath: '${Assets.linkedin}',
                  //   labelText: Languages.of(context)!.labelLinkedInProfileLink,
                  //   controller: linkedinController,
                  // ),
                  // const SizedBox(height: 20),
                  // CustomEditableFieldLink(
                  //   svgIconPath: '${Assets.facebook}',
                  //   labelText: Languages.of(context)!.labelFacebookProfileLink,
                  //   controller: facebookController,
                  // ),
                  // const SizedBox(height: 20),
                  // CustomEditableFieldLink(
                  //   svgIconPath: '${Assets.google}',
                  //   labelText: Languages.of(context)!.labelGoogleProfileLink,
                  //   controller: googleController,
                  // ),
                  // const SizedBox(height: 20),
                  // CustomEditableFieldLink(
                  //   svgIconPath: '${Assets.twitter}',
                  //   labelText: Languages.of(context)!.labelTwitterProfileLink,
                  //   controller: twitterController,
                  // ),
                  const SizedBox(height: 20),
                  sizedBox30(),
                  TextButton(
                    onPressed: () async {
                      final feet = int.tryParse(heightFtController.text) ?? 0;
                      final inches = int.tryParse(heightInController.text) ?? 0;

                      if (feet > 10 || inches > 12) {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Invalid Height'),
                              content: const Text(
                                  'Feet cannot be greater than 10 and inches cannot be greater than 12.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }
                      final weightcheck =
                          int.tryParse(weightController.text) ?? 0;
                      if (weightcheck > 300) {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Invalid Weight'),
                              content:
                                  const Text('Weight cannot be greater than 300 Kg.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }

                      double calculateAge(String birthDateString) {
                        DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                        DateTime birthDate = dateFormat.parse(birthDateString);
                        DateTime today = DateTime.now();

                        // Calculate the difference in years
                        int yearsDifference = today.year - birthDate.year;

                        // Calculate the fractional part of the year
                        int monthsDifference = today.month - birthDate.month;
                        int daysDifference = today.day - birthDate.day;

                        double age = yearsDifference.toDouble();

                        if (monthsDifference < 0 ||
                            (monthsDifference == 0 && daysDifference < 0)) {
                          age -= 1;
                          monthsDifference += 12;
                        }

                        double fractionalYear =
                            monthsDifference / 12.0 + daysDifference / 365.0;
                        age += fractionalYear;

                        return age;
                      }

                      if (_formKey.currentState!.validate()) {
                        final updatedProfile = UserProfile(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            mobile: mobileController.text,
                            weight: double.parse(weightController.text),
                            email: emailController.text,
                            heightFt: int.parse(heightFtController.text),
                            heightIn:
                                double.parse(heightInController.text).toInt(),
                            bmi: userProfile!.bmi,
                            bmr: userProfile.bmr,
                            age: calculateAge(_controller.text),
                            Dob: _controller.text,
                            gender: userProfile.gender,
                            facebooklink: facebookController.text,
                            linkdinlink: linkedinController.text,
                            googlelink: googleController.text,
                            twitterlink: twitterController.text,
                            androidLink: userProfile.androidLink,
                            ioslink: userProfile.ioslink,
                            messageOfLink: userProfile.messageOfLink,
                            // occupation: _selectedOccupation,
                            workLevel: _activityLevel,
                            wakeupTime: formattedTime);

                        final userProfileController =
                            Provider.of<UserProfileController>(context,
                                listen: false);

                        // Trigger the update to the API
                        userProfileController
                            .updateProfileInAPI(updatedProfile);

                        // Navigate back to the profile page
                        Navigator.pop(context);
                      }
                    },
                    child: Ink(
                      // decoration: BoxDecoration(
                      //   gradient: LinearGradient(
                      //     begin: Alignment(-1.00, 0.08),
                      //     end: Alignment(1, -0.08),
                      //     colors: [TColor.primaryColor1, TColor.primaryColor2],
                      //   ),
                      //   borderRadius: BorderRadius.circular(99),
                      // ),
                      child: Container(
                        width: 150,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 189, 20, 124),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          Languages.of(context)!.labelSubmit,
                          style: TextStyle(
                            color: ThemeManager.themeColor,
                            fontSize: AppFontSizes.smallDefault,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomEditableFieldLink extends StatelessWidget {
  final String svgIconPath; // Path to your SVG file
  final String labelText;
  final TextEditingController controller;

  const CustomEditableFieldLink({
    Key? key,
    required this.svgIconPath,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      // child: Container(
      //   padding: EdgeInsets.all(16.0),
      //   decoration: BoxDecoration(
      //     color: ThemeManager.themelightColor,
      //     borderRadius: BorderRadius.circular(8.0),
      //   ),
      //   child: Row(
      //     children: [
      //       // Use SvgPicture.asset to load the SVG icon
      //       SvgPicture.asset(
      //         svgIconPath,
      //         color: ThemeManager.themeText,
      //         width: 24, // Adjust the width as needed
      //         height: 24, // Adjust the height as needed
      //       ),
      //       SizedBox(width: 12.0),
      //       Expanded(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: ThemeManager.themelightColor,
          labelText: labelText,
          hintStyle: TextStyle(
            color: ThemeManager.themeText,
          ),
          labelStyle: TextStyle(
            color: ThemeManager.themeText,
            fontSize: AppFontSizes.smallDefault,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Transform.scale(
            scale: 0.6, // Adjust the scale factor as needed
            child: SvgPicture.asset(
              svgIconPath,
              color: ThemeManager.themeText,
            ),
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: ThemeManager.themeText,
        ),
      ),
      // TextFormField(
      //   controller: controller,
      //   style: TextStyle(
      //     color: ThemeManager.themeText,
      //     fontSize: AppFontSizes

      //     fontFamily: 'Poppins',
      //     fontWeight: FontWeight.w400,
      //   ),
      //   decoration: InputDecoration(
      //     border: InputBorder.none,
      //     hintText: 'Enter link',
      //     hintStyle: TextStyle(
      //       color: ThemeManager.themeText.withOpacity(0.5),
      //       fontSize: AppFontSizes

      //       fontFamily: 'Poppins',
      //       fontWeight: FontWeight.w400,
      //     ),
      //   ),
      // ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
