import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nin2byo2i/Classes/OxygenClass.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class OxygenLevelScreen extends StatefulWidget {
  const OxygenLevelScreen({super.key});

  @override
  _OxygenLevelScreenState createState() => _OxygenLevelScreenState();
}

class _OxygenLevelScreenState extends State<OxygenLevelScreen> {
  final UserProfileController _controller = UserProfileController();
  List<OxygenClass> _data = [];
  final TextEditingController saturationController = TextEditingController();
  String selectedOption = "Today"; // Default selection
  DateTime? selectedDate2;
  @override
  void initState() {
    super.initState();
    _loadData(selectedOption);
    selectedDate = DateFormat("yyyy-MM-dd").format(_selectedDate);
  }

  String selectedDate = "";
  DateTime _selectedDate = DateTime.now();

  late bool status = false;
  Future<void> _loadData(String selectedOption) async {
    // debugPrint('selected data is --------$selectedOption');
    // String parameter = 'today';
    // final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // if (selectedOption == "today") {
    //   parameter = currentDate;
    // }
    // You will need to modify the _controller.fetchOxygenData method to accept the selectedOption
    final data = await _controller.fetchOxygenData(selectedOption);
    if (data.isEmpty) {
      status = true;
    }
    if (mounted) {
      setState(() {
        _data = data;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate2 ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
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
    if (picked != null) {
      setState(() {
        final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        selectedDate2 = picked; // Assign picked to selectedDate
        // Call your function with the selected date
        _loadData(formattedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Languages.of(context)!.mainlabelOxygenStatus,
              style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.w700),
            ),
          ),
          backgroundColor: ThemeManager.themeColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 189, 20, 124),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          style: const TextStyle(color: Colors.white),
                          dropdownColor: const Color.fromARGB(255, 189, 20, 124),
                          icon: const Icon(Icons.expand_more, color: Colors.white),
                          underline: Container(),
                          value: selectedOption,
                          items: ["Today", "Weekly", "Monthly"]
                              //, "Yesterday"
                              .map((name) => DropdownMenuItem(
                                    value: name,
                                    child: Text(
                                      name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: AppFontSizes.mediumDefault),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value!;
                              _loadData(selectedOption);
                            });
                          },
                          hint: Text(
                            selectedOption,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ThemeManager.themeText,
                                fontSize: AppFontSizes.smallDefault),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      // height: 30,
                      child: RoundButton(
                        title: Languages.of(context)!.TextAppSelectDate,
                        type: RoundButtonType.bgSGradient,
                        fontSize: AppFontSizes.smallDefault,
                        fontWeight: FontWeight.w400,
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      // height: 30,
                      child: RoundButton(
                        title: Languages.of(context)!.add,
                        type: RoundButtonType.bgGradient,
                        fontSize: AppFontSizes.smallDefault,
                        fontWeight: FontWeight.w400,
                        onPressed: () {
                          _showSaturationInputDialog(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _data.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                            right: 32.0, left: 32.0, bottom: 32.0),
                        child: ListView.builder(
                          itemCount: _data.length,
                          itemBuilder: (context, index) {
                            String percent = '0.${_data[index].value}';
                            percent = percent.substring(0, 4);
                            double percentAsDouble = 0;
                            try {
                              percentAsDouble = double.parse(percent);
                              if (percentAsDouble < 0) {
                                percentAsDouble = -percentAsDouble;
                              }
                            } catch (e) {}
                            // debugPrint('data is here----- $percent');
                            return Row(
                              children: [
                                Text(
                                  _data[index].localDate.join("-"),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 213, 167, 28)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SimpleAnimationProgressBar(
                                    height: 15,
                                    width: 120,
                                    backgroundColor: Colors.grey.shade100,
                                    foregroundColor: Colors.purple,
                                    ratio: percentAsDouble,
                                    direction: Axis.horizontal,
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    duration: const Duration(seconds: 3),
                                    borderRadius: BorderRadius.circular(7.5),
                                    gradientColor: LinearGradient(
                                        colors: TColor.primaryG,
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight),
                                  ),
                                ),
                                Text(
                                  '${_data[index].value} %',
                                  style: const TextStyle(color: Colors.blue),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(Languages.of(context)!
                                              .ninTextDelete),
                                          content: Text(Languages.of(context)!
                                              .confirmDelete),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close dialog
                                              },
                                              child: Text(Languages.of(context)!
                                                  .cancel),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                // Perform delete operation here
                                                await UserProfileController
                                                    .DleteOxygen(
                                                        _data[index].id);
                                                setState(() {
                                                  _data.removeAt(index);
                                                  _loadData(selectedOption);
                                                });
                                                Navigator.of(context)
                                                    .pop(); // Close dialog
                                              },
                                              child: Text(Languages.of(context)!
                                                  .ninTextDelete),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                )
                              ],
                            );
                          },
                        ),
                      )
                    : status
                        ? Center(
                            child: Text(
                              Languages.of(context)!.TextAppNoRecord,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: AppFontSizes.mediumDefault),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
              ),
            ],
          )),
    );
  }

  Future<void> _showSaturationInputDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        var media = MediaQuery.of(context).size;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
                backgroundColor: ThemeManager.themelightColor,
                title: Text(
                  Languages.of(context)!.enterOxygenSaturationLevel1to100,
                  style: TextStyle(
                    color: ThemeManager.themeText,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: media.width * 0.5,
                          child: Text(
                              "${Languages.of(context)!.labelSelectDate} : ${DateFormatter.convertDate(selectedDate)}"),
                        ),
                        IconButton(
                          onPressed: () async {
                            final DateTime now = DateTime.now();
                            final DateTime lastAllowedDate =
                                now.subtract(const Duration(days: 365));

                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2000),
                              lastDate:
                                  now, // Limit the maximum date to current date
                              selectableDayPredicate: (DateTime date) {
                                return date.isAfter(lastAllowedDate) ||
                                    date.isAtSameMomentAs(lastAllowedDate) &&
                                        date.isBefore(now);
                              },
                            );

                            if (picked != null && picked != _selectedDate) {
                              setState(() {
                                _selectedDate = picked;
                                selectedDate =
                                    DateFormat("yyyy-MM-dd").format(picked);
                              });
                            }
                          },
                          icon: const Icon(Icons.date_range),
                        ),
                      ],
                    ),
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: ThemeManager.themeText),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(
                            Languages.of(context)!.cancel,
                            style: TextStyle(color: ThemeManager.themeText),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColor
                                .secondaryColor1, // Set the background color to light blue
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  25.0), // Set the border radius
                            ),
                          ),
                          child: Text(
                            Languages.of(context)!.submit,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            double enteredLevel =
                                double.tryParse(controller.text) ?? 0.0;
                            if (enteredLevel > 100) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.white,
                                  duration: const Duration(milliseconds: 1500),
                                  content: Text(
                                    Languages.of(context)!
                                        .enterOxygenSaturationLevel1to100,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            } else {
                              // Call the API to submit the entered oxygen level
                              final success = await _controller.SaveOxygenLevel(
                                  selectedDate, enteredLevel);

                              if (success) {
                                debugPrint('success level is $success');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(milliseconds: 1500),
                                    content: Text(
                                      Languages.of(context)!
                                          .oxygenLevelSubmittedSuccessfully,
                                      style: TextStyle(
                                          color: ThemeManager.themeText),
                                    ),
                                    backgroundColor: Colors
                                        .green, // Set the snackbar color to green
                                  ),
                                );
                                setState(() {
                                  _loadData(selectedOption);
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(milliseconds: 1500),
                                    content: Text(
                                      Languages.of(context)!.failed,
                                      style: TextStyle(
                                          color: ThemeManager.themeText),
                                    ),
                                    backgroundColor: Colors
                                        .red, // Set the snackbar color to red or any other color for failure
                                  ),
                                );
                              }

                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ));
          },
        );
      },
    );
  }
}
