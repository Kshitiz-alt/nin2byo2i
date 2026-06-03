// import 'dart:convert';
import 'dart:io';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
import 'package:nin2byo2i/Common/DateFormatter.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';
// import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:provider/provider.dart';

class ExportToCsv extends StatefulWidget {
  const ExportToCsv({super.key});

  @override
  _ExportToCsvState createState() => _ExportToCsvState();
}

class _ExportToCsvState extends State<ExportToCsv> {
  final UserProfileController _controller = UserProfileController();
  late List<Map<String, dynamic>> responseData = [];

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String formatDate(DateTime date) {
    // List of month names
    List<String> monthNames = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    // Extract day, month, and year from the DateTime object
    int day = date.day;
    int month = date.month;
    int year = date.year;

    // Format the date as "day MonthName year"
    String formattedDate = "$day ${monthNames[month]} $year";

    return formattedDate;
  }

  @override
  void initState() {
    super.initState();

    fetchData();
    _requestStoragePermission();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _controller.MensurationOnOfffdgfdghfhBool(context);
    //   _controller.Mddd(context);
    // });
  }

  Future<void> _requestStoragePermission() async {
    await Permission.storage.request();
    setState(() {
      // _storagePermissionStatus = status;
    });
  }

  Future<void> fetchData() async {
    // await Permission.storage.request();
    try {
      final String startDate =
          selectedStartDate.toLocal().toString().split(' ')[0];
      final String endDate = selectedEndDate.toLocal().toString().split(' ')[0];
      // final String authToken =
      //     'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJneWRpZmVAaW1hZ2Vwb2V0Lm5ldCIsImlhdCI6MTcwMjk2Mzg3NiwiZXhwIjoxNzAyOTgxODc2fQ.L6Gzd0k3XmFoELoZqu6pTt6-5LxX4yLHe-FSuceaU8q_7vhAmW4G_wR8k_CLiX3ZrfXeEMouTXuGkhdsu25jcw';

      final response = await _controller.getCsvData(startDate, endDate);
      debugPrint("csv data is here $response $responseData");
      setState(() {
        responseData = response;
        debugPrint("csv data is here $response $responseData");
      });
    } catch (error) {
      // Handle errors
      debugPrint('Error: $error');
    }
    // _controller.MensurationOnOfffdgfdghfhBool(context);
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ))!;
    if (picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ))!;
    if (picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

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
              "assets/img/black_btn.png", // Replace with your health app logo asset path
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "${Languages.of(context)!.mainlabelDownloadActivityReportInCsv} ",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${Languages.of(context)!.NINTextSelectStartDate}  : ",
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    formatDate(selectedStartDate),
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold, // Make the date bold
                      color: Colors.red, // Change date text color to red
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await _selectStartDate(context);
                      await fetchData();
                    },
                    icon: const Icon(Icons.date_range),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${Languages.of(context)!.NINTextSelectEndDate} : ",
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    formatDate(selectedEndDate),
                    style: const TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold, // Make the date bold
                      color: Colors.red, // Change date text color to red
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await _selectEndDate(context);
                      await fetchData();
                    },
                    icon: const Icon(Icons.date_range),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: TColor.primaryColor1,
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: downloadCsv,
                      child: Center(
                        child: Text(
                          '${Languages.of(context)!.TextAppDownloadFile} ',
                          style: TextStyle(
                            color: ThemeManager.themeText,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(
                //           10), // Adjust the radius as needed
                //     ),
                //     child: ElevatedButton(
                //       onPressed: downloadCsv,
                //       child: Text('Download CSV'),
                //       style: ElevatedButton.styleFrom(
                //         primary: Colors.blue, // Background color of button
                //         foregroundColor: Colors.white, // Text color of button
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(
                //               10), // Adjust the radius as needed
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),

            // SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: fetchData,
            //   child: Text('Fetch Data'),
            // ),
            // SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity, // Adjust width as needed
                // height: 300, // Adjust height as needed
                decoration: BoxDecoration(
                  color: ThemeManager.themelightColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: DataTable(
                        columns: [
                          DataColumn(
                              label: Text(
                                  '${Languages.of(context)!.mainlabelDate} ')),
                          DataColumn(
                              label: Text(
                                  '${Languages.of(context)!.NINTextValue} ')),
                        ],
                        rows: responseData.map((data) {
                          return DataRow(cells: [
                            DataCell(Text(
                                "${DateFormatter.convertDate(data['date'])}")),
                            DataCell(Text(
                                "${data['value'].toString()} ${Languages.of(context)!.ninTextSteps} ")),
                          ]);
                        }).toList(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> downloadCsv() async {
    final csvData = convertJsonToCsv(responseData);

    // if (!(await Permission.storage.request()).isGranted) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text("Permission Denied !"),
    //   ));
    //   return;
    // }

    final directory = await getApplicationDocumentsDirectory();
    final folderPath = directory.path; // Folder name "NIN"
    final filePath = '$folderPath/data.csv';

    // Ensure the directory exists
    await Directory(folderPath).create(recursive: true);

    File file = File(filePath);
    await file.writeAsString(csvData);

    // Show a snackbar to indicate the CSV file has been saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text('${Languages.of(context)!.csvFileSavedTo} $filePath'),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  String convertJsonToCsv(List<Map<String, dynamic>> jsonData) {
    final userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    final userProfile = userProfileController.userProfile;
    final userName =
        '${userProfile?.firstName ?? ""} ${userProfile?.lastName ?? ""}';

    // Sort jsonData based on 'activityDate' in descending order
    jsonData.sort((a, b) => b['date'].compareTo(a['value'].toString()));

    final List<List<dynamic>> rows = [];
    // Additional information
    rows.add(['Activity Csv']);

    rows.add(['Name:', userName]);
    rows.add(['Email:', userProfile?.email]);
    rows.add(['Age:', '${userProfile?.age} years']);
    rows.add(['Gender:', userProfile?.gender]);
    rows.add(['bmi:', userProfile?.bmi]);
    rows.add([]); // Empty row for separation

    // Add header row
    rows.add(['Date', 'Steps']);

    for (var map in jsonData) {
      rows.add([map['date'], map['value']]);
    }

    return const ListToCsvConverter().convert(rows);
  }
}

void main() {
  runApp(MaterialApp(
    home: ExportToCsv(),
  ));
}
