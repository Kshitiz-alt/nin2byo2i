import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

// Import the class containing the saveBloodPressureLevel function
class DateRange {
  String startDate;
  String endDate;

  DateRange(this.startDate, this.endDate);
}

DateRange getDateRange(String range) {
  DateTime currentDate = DateTime.now();
  DateTime startDate;
  DateTime endDate;

  switch (range) {
    case 'Today':
      startDate =
          DateTime(currentDate.year, currentDate.month, currentDate.day);
      endDate = startDate;
      break;
    case 'Week':
      endDate = currentDate.subtract(Duration(days: currentDate.weekday - 1));
      startDate = endDate.subtract(const Duration(days: 6));
      break;
    case 'Month':
      startDate = DateTime(currentDate.year, currentDate.month, 1);
      endDate = DateTime(currentDate.year, currentDate.month + 1, 0);
      break;
    default:
      throw Exception(
          'Invalid range. Valid values are "Today", "week", or "month"');
  }

  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formattedStartDate = formatter.format(startDate);
  String formattedEndDate = formatter.format(endDate);

  return DateRange(formattedStartDate, formattedEndDate);
}

class BloodPressurePage extends StatefulWidget {
  const BloodPressurePage({super.key});

  @override
  _BloodPressurePageState createState() => _BloodPressurePageState();
}

class _BloodPressurePageState extends State<BloodPressurePage> {
  List<Map<String, dynamic>> _bloodPressureData = [];
  bool _isLoading = false;
  final UserProfileController _controller = UserProfileController();

  @override
  void initState() {
    super.initState();
    _fetchBloodPressureData();
  }

  Future<void> _fetchBloodPressureData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      DateRange dateRange = getDateRange(selectedOption);
      // Replace 'startDate' and 'endDate' with your desired date range
      final bloodPressureData =
          await _controller.getBloodPressureDataByDateRange(
              dateRange.startDate, dateRange.endDate);
      setState(() {
        _bloodPressureData = bloodPressureData;
        debugPrint("hjdejcfdkvnfvbgf $_bloodPressureData");
        _isLoading = false;
      });
    } catch (error) {
      // Handle error
      debugPrint('Error fetching blood pressure data: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Map<String, dynamic> bloodPressureData = {};
  String selectedOption = "Today";

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  //   selectedDate = DateFormat("yyyy-MM-dd").format(_selectedDate);
  // }

  String selectedDate = "";
  DateTime _selectedDate = DateTime.now();

  Future<void> fetchData() async {
    try {
      // Change this to 'Today', 'week', or 'month' to get different date ranges
      DateRange dateRange = getDateRange(selectedOption);
      debugPrint('Start gvhvyjghnb: ${dateRange.startDate}');
      debugPrint('End Date: ${dateRange.endDate}');
      final data = await _controller.getBloodPressureDataByDateRange(
          dateRange.startDate, dateRange.endDate);
      setState(() {
        setState(() {
          _bloodPressureData = data;
          debugPrint("hjdejcfdkvnfvbgf $_bloodPressureData");
          _isLoading = false;
        });
        // blodsydia = data;
        // debugPrint('Start gvhvdcvdfdfyjghnb: ${blodsydia.length} ${blodsydia}');
      });
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(Languages.of(context)!.error),
          content: Text('${Languages.of(context)!.error}: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  double? systolicValue;
  double? diastolicValue;

  void _openInputDialog(BuildContext context) {
    var media = MediaQuery.of(context).size;
    _selectedDate = DateTime.now();
    selectedDate = DateFormat("yyyy-MM-dd").format(_selectedDate);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(Languages.of(context)!.mainlabelEnterBloodPressure),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
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
                    decoration: InputDecoration(
                        labelText:
                            '${Languages.of(context)!.mainlabelSystolicBloodPressure} (mmHg)'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      systolicValue = double.tryParse(value);
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText:
                            '${Languages.of(context)!.mainlabelDiastolicBloodPressure} (mmHg)'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      diastolicValue = double.tryParse(value);
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      // color: Colors.yellow[100],
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.black, width: 1.0),
                    ),
                    child: const Text(
                      "Note: Hypertension (high blood pressure) is when the pressure in your blood vessels is too high (140/90 mmHg or higher)",
                      style: TextStyle(
                        fontSize: AppFontSizes.mediumDefault,
                        color: Colors.black87,
                      ),
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(Languages.of(context)!.cancel),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColor
                        .secondaryColor1, // Set the background color to light blue
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(25.0), // Set the border radius
                    ),
                  ),
                  onPressed: () async {
                    if (systolicValue != null && diastolicValue != null) {
                      await _controller.saveBloodPressureLevel(
                          selectedDate, systolicValue!, diastolicValue!);
                      fetchData();
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(Languages.of(context)!.submit),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> Senddatatoapimodal(BuildContext context) async {
    double manualWeight = 0;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: ThemeManager.themelightColor,
              title: Text(
                Languages.of(context)!.NINTextAddNewWeight,
                style: TextStyle(color: ThemeManager.themeText),
              ),
              content: SizedBox(
                width: 300.0, // Set the width of the modal
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      Languages.of(context)!.NINTextEnterWeight,
                      style: TextStyle(color: ThemeManager.themeText),
                    ),
                    Row(
                      children: [
                        Text(
                            "${Languages.of(context)!.labelSelectDate} : ${DateFormatter.convertDate(selectedDate)}"),
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
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          manualWeight = double.tryParse(value) ?? 0;
                        });
                      },
                      style: TextStyle(color: ThemeManager.themeText),
                      decoration: InputDecoration(
                        labelText:
                            '${Languages.of(context)!.TextAppWeight} (kg)',
                      ),
                    ),
                  ],
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
                    Languages.of(context)!.submit,
                    style: TextStyle(color: ThemeManager.themeText),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    // await _controller.UpdateWeightData(
                    //     manualWeight, selectedDate);
                    // Call function to update weight data
                    // await _updateWeightData(manualWeight);
                    // You can perform further actions here if needed
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
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
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.mainlabelBloodPressure,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
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
                        icon: Icon(Icons.expand_more,
                            color: ThemeManager.themeColor),
                        value: selectedOption,
                        items: ["Today", "Week", "Month"]
                            .map((name) => DropdownMenuItem(
                                  value: name,
                                  child: Container(
                                    child: Text(
                                      name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: AppFontSizes.mediumDefault),
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                            fetchData();
                            // _loadData(selectedOption);
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
                  const Spacer(),
                  SizedBox(
                    width: 90,
                    // height: 30,
                    child: RoundButton(
                      title: Languages.of(context)!.add,
                      type: RoundButtonType.bgGradient,
                      fontSize: AppFontSizes.smallDefault,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        _openInputDialog(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       _openInputDialog(context);
            //     },
            //     child: Text('Add Blood Pressure'),
            //   ),
            // ),
            for (int i = 0; i < _bloodPressureData.length; i++)
              Container(
                padding: const EdgeInsets.all(8.0), // Adjust padding as needed
                child: Card(
                  color: ThemeManager.themeColor,
                  elevation: 4, // Adjust elevation as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15.0), // Adjust border radius as needed
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // [{"id":44,"localDate":"2024-05-16","systolicValue":78.0,"diastolicValue":78.0}]
                            SizedBox(
                              width: media.width * 0.6,
                              child: Text(
                                '${Languages.of(context)!.mainlabelSystolicBloodPressure}: ${_bloodPressureData[i]["systolicValue"]} mmHg',
                                style: const TextStyle(
                                    color: Colors.blue), // Custom color
                              ),
                            ),

                            Row(
                              children: [
                                SizedBox(
                                  width: media.width * 0.6,
                                  child: Text(
                                    '${Languages.of(context)!.mainlabelDiastolicBloodPressure}: ${_bloodPressureData[i]["diastolicValue"]} mmHg',
                                    style: const TextStyle(
                                        color: Colors.blue), // Custom color
                                  ),
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
                                                debugPrint(":rggrbfrbfbgfbhhgfb");
                                                await UserProfileController
                                                    .DleteSystolicDiastolic(
                                                        _bloodPressureData[i]
                                                            ["id"]);
                                                debugPrint(":rggrbfrbfbgfbhhgfb 1");
                                                setState(() {
                                                  _bloodPressureData
                                                      .removeAt(i);
                                                  _fetchBloodPressureData();
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
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: media.width * 0.6,
                          child: Text(
                            '${Languages.of(context)!.mainlabelMeasuredon}: ${_bloodPressureData[i]["localDate"]}',
                            style:
                                const TextStyle(color: Colors.grey), // Custom color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            // _buildListItem(
            //     _bloodPressureData[i]['localDate'],
            //     _bloodPressureData[i]['systolicValue'],
            //     _bloodPressureData[i]['diastolicValue'])

            // _isLoading
            //     ? Center(child: CircularProgressIndicator())
            //     : _bloodPressureData.isEmpty
            //         ? Center(child: Text('No data available'))
            //         :
            //         ListView.builder(
            //             itemCount: _bloodPressureData.length,
            //             itemBuilder: (context, index) {
            //               final bloodPressure = _bloodPressureData[index];
            //               final date = bloodPressure['localDate'];
            //               final systolic = bloodPressure['systolicValue'];
            //               final diastolic = bloodPressure['diastolicValue'];
            //               return _buildListItem(date, systolic, diastolic);
            //             },
            //           ),
            // for (int i = 0; i < _bloodPressureData.length; i++)
            //   Container(
            //     padding: EdgeInsets.all(8.0), // Adjust padding as needed
            //     child: Card(
            //       color: ThemeManager.themeColor,
            //       elevation: 4, // Adjust elevation as needed
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(
            //             15.0), // Adjust border radius as needed
            //       ),
            //       child: Row(
            //         children: [
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               ListTile(
            //                 title: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     // [{"id":44,"localDate":"2024-05-16","systolicValue":78.0,"diastolicValue":78.0}]
            //                     Text(
            //                       '${Languages.of(context)!.mainlabelSystolicBloodPressure}: ${_bloodPressureData[i]["systolicValue"]} mmHg',
            //                       style: TextStyle(
            //                           color: Colors.blue), // Custom color
            //                     ),
            //                     Text(
            //                       '${Languages.of(context)!.mainlabelDiastolicBloodPressure}: ${_bloodPressureData[i]["diastolicValue"]} mmHg',
            //                       style: TextStyle(
            //                           color: Colors.blue), // Custom color
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Text(
            //                   '${Languages.of(context)!.mainlabelMeasuredon}: ${_bloodPressureData[i]["localDate"]}',
            //                   style:
            //                       TextStyle(color: Colors.grey), // Custom color
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   )
          ],
        ),
      ),
    );
  }

  // Widget _buildListItem(String date, double systolic, double diastolic) {
  //   return Container(
  //     padding: EdgeInsets.all(8.0), // Adjust padding as needed
  //     child: Card(
  //       color: ThemeManager.themeColor,
  //       elevation: 4, // Adjust elevation as needed
  //       shape: RoundedRectangleBorder(
  //         borderRadius:
  //             BorderRadius.circular(15.0), // Adjust border radius as needed
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           ListTile(
  //             title: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 // [{"id":44,"localDate":"2024-05-16","systolicValue":78.0,"diastolicValue":78.0}]
  //                 Text(
  //                   '${Languages.of(context)!.mainlabelSystolicBloodPressure}: ${systolicValue} mmHg',
  //                   style: TextStyle(color: Colors.blue), // Custom color
  //                 ),
  //                 Text(
  //                   '${Languages.of(context)!.mainlabelDiastolicBloodPressure}: ${diastolicValue} mmHg',
  //                   style: TextStyle(color: Colors.blue), // Custom color
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               '${Languages.of(context)!.mainlabelMeasuredon}: ${date}',
  //               style: TextStyle(color: Colors.grey), // Custom color
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   )
  //       // ListTile(
  //       //   title: Text('Date: $date'),
  //       //   subtitle: Text('Systolic: $systolic, Diastolic: $diastolic'),
  //       // )
  //       ;
  // }
}
