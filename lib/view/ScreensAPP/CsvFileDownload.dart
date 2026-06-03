import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';

// csv download page
class CsvDownloadScreen extends StatefulWidget {
  const CsvDownloadScreen({super.key});

  @override
  _CsvDownloadScreenState createState() => _CsvDownloadScreenState();
}

class _CsvDownloadScreenState extends State<CsvDownloadScreen> {
  final UserProfileController _controller = UserProfileController();
  Map<String, dynamic> jsonData = {
    "name": "John Doe",
    "age": 30,
    "contact": {"email": "john.doe@example.com", "phone": "+1234567890"}
  };
  late Map<String, dynamic> responseData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // final String startDate = '2023-12-15';
      // final String endDate = '2023-12-07';
      // final String authToken =
      //     'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJneWRpZmVAaW1hZ2Vwb2V0Lm5ldCIsImlhdCI6MTcwMjk2Mzg3NiwiZXhwIjoxNzAyOTgxODc2fQ.L6Gzd0k3XmFoELoZqu6pTt6-5LxX4yLHe-FSuceaU8q_7vhAmW4G_wR8k_CLiX3ZrfXeEMouTXuGkhdsu25jcw';

      // final response = await _controller.getCsvData();

      // setState(() {
      //   responseData = response;
      // });
    } catch (error) {
      // Handle errors
      debugPrint('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSV Download Example'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: TColor
                .secondaryColor1, // Set the background color to light blue
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(25.0), // Set the border radius
            ),
          ),
          onPressed: downloadCsv,
          child: const Text('Download CSV'),
        ),
      ),
    );
  }

  Future<void> downloadCsv() async {
    final csvData = convertJsonToCsv(jsonData);

    if (!(await Permission.storage.request()).isGranted) {
      return;
    }

    final directory = await getExternalStorageDirectory();
    final folderPath = '${directory!.path}/NIN'; // Folder name "NIN"
    final filePath = '$folderPath/data.csv';

    // Ensure the directory exists
    await Directory(folderPath).create(recursive: true);

    File file = File(filePath);
    await file.writeAsString(csvData);

    // Show a snackbar to indicate the CSV file has been saved
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        duration: const Duration(milliseconds: 1500),
        content: Text('${Languages.of(context)!.csvFileSavedTo}$filePath'),
      ),
    );
  }

  String convertJsonToCsv(Map<String, dynamic> jsonData) {
    final List<List<dynamic>> rows = [];

    _flatten(jsonData, '', rows);

    return const ListToCsvConverter().convert(rows);
  }

  void _flatten(dynamic data, String prefix, List<List<dynamic>> rows) {
    if (data is Map) {
      data.forEach((key, value) {
        _flatten(value, prefix.isEmpty ? key : '$prefix.$key', rows);
      });
    } else {
      rows.add([prefix, data]);
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: CsvDownloadScreen(),
  ));
}
