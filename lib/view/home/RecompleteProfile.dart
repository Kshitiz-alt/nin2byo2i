import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/constants/assets.dart';
import 'package:nin2byo2i/custom%20widgets/button.dart';
import 'package:nin2byo2i/custom%20widgets/custom_textfield.dart';
import 'package:nin2byo2i/screens/SignIn/InstructionScreen.dart';
import 'package:nin2byo2i/screens/SignIn/login.dart';
import 'package:nin2byo2i/view/home/home_view.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import '../../Providers/auth_provider.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//complte profile page i user miss the profile page on signup
class RecompleteProfile extends StatefulWidget {
  const RecompleteProfile({super.key});

  @override
  State<RecompleteProfile> createState() => _RecompleteProfileState();
}

class _RecompleteProfileState extends State<RecompleteProfile> {
  late String _email,
      _userName,
      _password,
      _phoneNumer,
      _firstName,
      _lastName,
      googlelink = '',
      facebooklink = '',
      linkdinlink = '',
      twitterlink = '',
      _gender = 'Male';
  String _activityLevel = '';
  final Map<String, String> _activityDescriptions = {
    'Sedentary':
        'This category includes occupations with little to no physical movement throughout the day. People in these jobs spend most of their time sitting or lying down. Examples include office workers, teachers, and those in administrative roles.',
    'Moderate':
        'Individuals in this category engage in some level of physical activity, such as walking or light jogging, for around 30 minutes to an hour daily. Occupations like manual laborers, artisans, and some types of skilled workers fall into this category.',
    'Heavy':
        'This category comprises occupations involving regular and intense physical activity, such as running, cycling, or heavy lifting, for more than an hour each day. Examples include blacksmiths, miners, and construction workers.'
  };

  late DateTime _dateOfBirth;
  late String _weight, _heightInFeet, _heightInInch;
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  int selectedGenderIndex = 0;
  final Map<int, String> genderOptions = {
    0: 'Male',
    1: 'Female',
  };
  late TimeOfDay selectedTime;
  String formattedTime = '';
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

  late LocationData _currentLocation = LocationData.fromMap({
    "latitude": 0.0,
    "longitude": 0.0,
    // Add any other necessary properties here
  });

  final TimeOfDay _selectedTime = TimeOfDay.now();

  // void _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedTime,
  //   );
  //   if (picked != null && picked != _selectedTime) {
  //     setState(() {
  //       _selectedTime = picked;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _getLocation();
    selectedTime = TimeOfDay.now();
    formattedTime = _formatTime(selectedTime);
  }

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

  final UserProfileController _controller1 = UserProfileController();

  // // Initial Dropdown value
  // String? _selectedOccupation;

  // // List of occupations
  // List<String> _occupations = [];
  Future<void> _getLocation() async {
    try {
      var location = Location();
      var currentLocation = await location.getLocation();
      setState(() {
        _currentLocation = currentLocation;
      });
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Returning false prevents the user from navigating back
        return false;
      },
      child: Scaffold(
        backgroundColor: ThemeManager.themeColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child:
                Consumer<AuthProviderNin>(builder: (context, authProvider, _) {
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.complete,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Let’s complete your profile',
                        style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.mediumDefault,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'It will help us to know more about you!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: AppFontSizes.smallDefault,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                label: "First Name",
                                icon: Icons.person_2_outlined,
                                keyboardType: TextInputType.name,
                                onProgress: (String value) {
                                  _firstName = value;
                                },
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'First Name is Required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                label: 'Last Name',
                                icon: Icons.person_2_outlined,
                                keyboardType: TextInputType.name,
                                onProgress: (String value) {
                                  _lastName = value;
                                },
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Last Name is Required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                width:
                                    350, // Set the width to your desired value
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Adjust the radius value as needed
                                  child: CupertinoSlidingSegmentedControl(
                                    groupValue: selectedGenderIndex,
                                    thumbColor: TColor
                                        .primaryColor1, // Set the selected color to blue
                                    children:
                                        genderOptions.map((index, gender) {
                                      return MapEntry(
                                        index,
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(gender),
                                        ),
                                      );
                                    }),
                                    onValueChanged: (value) {
                                      setState(() {
                                        selectedGenderIndex = value!;
                                        _gender =
                                            genderOptions[selectedGenderIndex]!;
                                      });
                                    },
                                  ),
                                ),
                              ),

                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(20),
                              //   child: DropdownButtonFormField<String>(
                              //     style: TextStyle(
                              //         fontSize: AppFontSizes .mediumDefault,
                              //         color: ThemeManager.themeText),
                              //     value: '',
                              //     onChanged: (newValue) {
                              //       _gender = newValue!;
                              //     },
                              //     validator: (value) {
                              //       if (value == null ||
                              //           value.isEmpty ||
                              //           value == '') {
                              //         return 'Gender is Required';
                              //       }
                              //       return null;
                              //     },
                              //     decoration: InputDecoration(
                              //         filled: true,
                              //         fillColor: ThemeManager.themelightColor,
                              //         labelText: 'Choose Gender',
                              //         labelStyle: TextStyle(
                              //           color: ThemeManager.themeText,
                              //           fontSize: AppFontSizes

                              //           fontWeight: FontWeight.w400,
                              //         ),
                              //         prefixIcon: Icon(
                              //           Icons.people_outline_outlined,
                              //           color: ThemeManager.themeText,
                              //         ),
                              //         border: InputBorder.none),
                              //     dropdownColor: ThemeManager.themelightColor,
                              //     items: <String>[
                              //       'Male',
                              //       'Female',
                              //       // 'Other',
                              //       ''
                              //     ].map<DropdownMenuItem<String>>((String value) {
                              //       return DropdownMenuItem<String>(
                              //         value: value,
                              //         child: Text(
                              //           value,
                              //           style: TextStyle(
                              //               color: ThemeManager.themeText),
                              //         ),
                              //       );
                              //     }).toList(),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 12,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: TextFormField(
                                  controller: _controller,
                                  validator: (value) => value!.isEmpty
                                      ? 'Date of Birth is Required'
                                      : null,
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
                                      builder: (BuildContext context,
                                          Widget? child) {
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
                                              onSurface: Colors
                                                  .white, // Text color of the modal
                                            ), // Background color of the modal
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: TColor
                                                    .primaryColor1, // Color of the "OK" button
                                              ),
                                            ), dialogTheme: DialogThemeData(backgroundColor: Color.fromARGB(
                                                255,
                                                91,
                                                92,
                                                92)),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (date != null) {
                                      // Calculate age based on selected date
                                      int age = DateTime.now()
                                              .difference(date)
                                              .inDays ~/
                                          365;

                                      // Check if age is within the valid range
                                      if (age >= 2 && age <= 100) {
                                        setState(() {
                                          _dateOfBirth = date;
                                          _controller.text =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(date);
                                        });
                                      } else {
                                        // Show an error message for invalid age
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              duration: const Duration(seconds: 2),
                                              content: Text(
                                                Languages.of(context)!
                                                    .ageMustBeBetween2And100Years,
                                                style: const TextStyle(
                                                    color: Colors.red),
                                              )),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      label: 'Your Weight in Kg',
                                      icon: Icons.speed,
                                      keyboardType: TextInputType.number,
                                      onProgress: (String value) {
                                        _weight = value;
                                      },
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          return 'Weight is Required';
                                        }
                                        if (!RegExp(r'^\d*\.?\d*$')
                                            .hasMatch(value!)) {
                                          return 'Invalid input. Please enter a valid number.';
                                        }
                                        int? weightcheck = int.tryParse(value);
                                        if (weightcheck != null &&
                                            weightcheck > 300) {
                                          return 'Weight cannot \nbe greater than\n 300 Kg.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: const Alignment(-1.00, 0.08),
                                          end: const Alignment(1, -0.08),
                                          colors: [
                                            TColor.primaryColor1,
                                            TColor.primaryColor2,
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Kg',
                                        style: TextStyle(color: Colors.black),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                padding: const EdgeInsets.all(
                                    8.0), // Adjust padding for small size
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0), // Adjust margin if needed
                                // constraints: BoxConstraints(
                                //   maxWidth:
                                //       300.0, // Set a max width to control size
                                // ),
                                color: ThemeManager.themelightColor.withOpacity(
                                    0.4), // Set background color to grey
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align text to the start
                                  children: [
                                    const Text(
                                      "Enter your height in feet and inches (e.g. 5 feet 9 inch)",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CustomTextField(
                                            label: 'Height(Ft.)',
                                            icon: Icons.height,
                                            keyboardType: TextInputType.number,
                                            onProgress: (String value) {
                                              _heightInFeet = value;
                                            },
                                            validator: (value) {
                                              if (value != null &&
                                                  value.isEmpty) {
                                                return 'Height in Feet \nRequired';
                                              }
                                              if (!RegExp(r'^\d+$')
                                                  .hasMatch(value!)) {
                                                return 'Only numbers \nallowed';
                                              }
                                              int? heightInFeet =
                                                  int.tryParse(value);
                                              if (heightInFeet != null &&
                                                  heightInFeet > 10) {
                                                return 'Height cannot \nbe greater than\n 10 feet.';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: CustomTextField(
                                            label: 'Height(Inch)',
                                            icon: Icons.height,
                                            keyboardType: TextInputType.number,
                                            onProgress: (String value) {
                                              _heightInInch = value;
                                            },
                                            validator: (value) {
                                              if (value != null &&
                                                  value.isEmpty) {
                                                return 'Height in Inch \nRequired';
                                              }
                                              if (!RegExp(r'^\d*\.?\d+$')
                                                  .hasMatch(value!)) {
                                                return 'Only numbers allowed';
                                              }
                                              // if (!RegExp(r'^\d+$')
                                              //     .hasMatch(value!)) {
                                              //   return 'Only numbers \nallowed';
                                              // }
                                              int? heightInInches =
                                                  int.tryParse(value);
                                              if (double.parse(value) > 12) {
                                                return 'Height cannot \nbe greater than\n 12 inches.';
                                              }
                                              return null;
                                            },
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
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Wake Up Time: $formattedTime',
                                    style: const TextStyle(
                                        fontSize: AppFontSizes.largeDefault),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _selectTime(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: TColor
                                          .primaryColor1, // Background color

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
                              )
                              // Center(
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: <Widget>[
                              //       // ElevatedButton(
                              //       //   onPressed: () => _selectTime(context),
                              //       //   child: Text('Select Time'),
                              //       // ),
                              //       // SizedBox(height: 20),
                              //       Text(
                              //         'Wake Up Time: $formattedTime',
                              //         style: TextStyle(
                              //             fontSize: AppFontSizes.largeDefault),
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
                              //                 borderRadius:
                              //                     BorderRadius.circular(14),
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
                              ,
                              const SizedBox(
                                height: 12,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  color: ThemeManager.themelightColor,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8, top: 8),
                                        child: Text(
                                          '${Languages.of(context)!.ninTextHowActiveAreYou}?',
                                          style: const TextStyle(
                                            fontSize:
                                                AppFontSizes.mediumDefault,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      RadioListTile(
                                        title: const Text('Sedentary'),
                                        activeColor: TColor.primaryColor1,
                                        subtitle: Text(_activityDescriptions[
                                            'Sedentary']!),
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
                                        subtitle: Text(
                                            _activityDescriptions['Moderate']!),
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
                                        subtitle: Text(
                                            _activityDescriptions['Heavy']!),
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
                              const SizedBox(
                                height: 12,
                              ),
                              // Center(
                              //   child: _occupations.isNotEmpty
                              //       ? Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
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
                              //                   value: _selectedOccupation,
                              //                   style: TextStyle(
                              //                       color:
                              //                           ThemeManager.themeText),
                              //                   dropdownColor:
                              //                       ThemeManager.themelightColor,
                              //                   menuMaxHeight: 400,
                              //                   onChanged: (newValue) {
                              //                     setState(() {
                              //                       _selectedOccupation =
                              //                           newValue!;
                              //                       debugPrint(
                              //                           "Dvfdgbfdhfgjhg $_selectedOccupation");
                              //                     });
                              //                   },
                              //                   items: _occupations.map<
                              //                           DropdownMenuItem<String>>(
                              //                       (String value) {
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
                              // const SizedBox(
                              //   height: 12,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Text(
                              //     "Optional",
                              //     style: TextStyle(
                              //         fontSize: AppFontSizes.mediumDefault,
                              //         color: ThemeManager.themeText),
                              //   ),
                              // ),
                              // CustomTextField(
                              //   label: 'Facebook Link',
                              //   icon: Icons.link,
                              //   keyboardType: TextInputType.name,
                              //   onProgress: (String value) {
                              //     facebooklink = value;
                              //   },
                              //   // validator: (value) {
                              //   //   if (value != null && value.isEmpty) {
                              //   //     return 'Last Name is Required';
                              //   //   }
                              //   //   return null;
                              //   // },
                              // ),
                              // const SizedBox(
                              //   height: 12,
                              // ),
                              // CustomTextField(
                              //   label: 'Linkdin Link',
                              //   icon: Icons.link,
                              //   keyboardType: TextInputType.name,
                              //   onProgress: (String value) {
                              //     linkdinlink = value;
                              //   },
                              // ),
                              // const SizedBox(
                              //   height: 12,
                              // ),
                              // CustomTextField(
                              //   label: 'Twitter Link',
                              //   icon: Icons.link,
                              //   keyboardType: TextInputType.name,
                              //   onProgress: (String value) {
                              //     twitterlink = value;
                              //   },
                              // ),
                              // const SizedBox(
                              //   height: 12,
                              // ),
                              // CustomTextField(
                              //   label: 'Google Link',
                              //   icon: Icons.person_2_outlined,
                              //   keyboardType: TextInputType.name,
                              //   onProgress: (String value) {
                              //     googlelink = value;
                              //   },
                              // ),
                              // const SizedBox(
                              //   height: 30,
                              // ),
                              InkWell(
                                onTap: () async {
                                  debugPrint("efdvgghfhgjghhgg");
                                  try {
                                    final formKeyState = _formKey.currentState!;
                                    // debugPrint(
                                    //     "fvbvgfbgfbg  ${convert12to24(_selectedTime.format(context))}");
                                    // debugPrint(
                                    //     "Error getting location: Latitude: ${_currentLocation.latitude} Longitude: ${_currentLocation.longitude}");
                                    debugPrint("efdvgghfhgjghhgg0");
                                    bool a = formKeyState.validate();
                                    bool isValid =
                                        _formKey.currentState!.validate();
                                    if (!isValid) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Error'),
                                            content: const Text(
                                                'Please fill in all mandatory fields and provide correct information.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                    if (formKeyState.validate()) {
                                      // final UserProfileController _controller =
                                      //     UserProfileController();
                                      debugPrint("efdvgghfhgjghhgg1");
                                      Map<String, dynamic> userData = {
                                        "firstName": _firstName,
                                        "lastName": _lastName,
                                        "gender": _gender,
                                        "dateOfBirth": _dateOfBirth,
                                        "heightFt": double.parse(_heightInFeet),
                                        "heightIn": double.parse(_heightInInch),
                                        "weight": double.parse(_weight),
                                        "googleAccountLink": googlelink,
                                        "facebookAccountLink": facebooklink,
                                        "twitterAccountLink": twitterlink,
                                        "linkedInAccountLink": linkdinlink,
                                        "workLevel": _activityLevel,
                                        "wakeupTime": formattedTime
                                        // convert12to24(
                                        //     _selectedTime.format(context)
                                        //  )
                                      };
                                      debugPrint("efdvgghfhgjghhgg2");
                                      debugPrint("error cout here");
                                      // Future.delayed(Duration(seconds: 3));
                                      UserProfileController.RecompleteProfile(
                                          userData);
                                      if (!mounted) return;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InstructionScreen()),
                                      );
                                      // Navigator.pushNamed(context, '/root');
                                    }
                                  } catch (e) {
                                    debugPrint("efdvgghfhgjghhgg3");
                                    // debugPrint(e.toString());
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.black,
                                            duration: const Duration(seconds: 2),
                                            content: Text(e.toString())));
                                  }
                                },
                                child: const CustomButton(
                                  text: 'Next >',
                                  isColored: true,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (authProvider.isLoading)
                    Positioned.fill(
                      child: Container(
                        color: ThemeManager.themeText,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
