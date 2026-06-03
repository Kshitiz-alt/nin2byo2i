// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:nin2byo2i/Repository/auth_repo.dart';

// class ServerApi {
//   static Future<List<dynamic>> fetchWaterIntakeData(String date) async {
//     String? token = await AuthRepo.getToken();

//     final headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Auth': 'Bearer $token',
//     };

//     final Uri url =
//         Uri.parse('${API.server}/api/water/all-intake?date=$date');

//     final response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       return json.decode(response.body) as List;
//     } else {
//       return [];
//     }
//   }

//   static Future<void> deleteWaterIntakeEntry(int entryId) async {
//     String? token = await AuthRepo.getToken();

//     final headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Auth': 'Bearer $token',
//     };

//     final Uri url = Uri.parse(
//         '${API.server}/api/water/intake/entry?entryId=$entryId');

//     final response = await http.delete(url, headers: headers);

//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete water intake entry');
//     }
//   }

// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Water Intake Dashboard',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: WaterIntakeDashboard(),
//     );
//   }
// }

// class WaterIntakeDashboard extends StatefulWidget {
//   @override
//   _WaterIntakeDashboardState createState() => _WaterIntakeDashboardState();
// }

// class _WaterIntakeDashboardState extends State<WaterIntakeDashboard> {
//   List<dynamic> _waterIntakeData = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }

//   Future<void> _fetchData() async {
//     final data = await ServerApi.fetchWaterIntakeData('2024-07-27');
//     setState(() {
//       _waterIntakeData = data;
//       _isLoading = false;
//     });
//   }

//   Future<void> _deleteEntry(int entryId) async {
//     try {
//       await ServerApi.deleteWaterIntakeEntry(entryId);
//       await _fetchData();
//     } catch (e) {
//       debugPrint('Failed to delete entry: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Water Intake Dashboard'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Column(
//               children: [
//                 for (var intake in _waterIntakeData)
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children:
//                         (intake['waterEntries'] as List<dynamic>).map((entry) {
//                       return ListTile(
//                         title: Text('Time: ${entry['localTime']}'),
//                         subtitle: Text('Intake: ${entry['waterIntake']}'),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete, color: Colors.red),
//                           onPressed: () {
//                             // Show confirmation dialog
//                             showDialog(
//                               context: context,
//                               builder: (context) => AlertDialog(
//                                 title: Text('Confirm Deletion'),
//                                 content: Text(
//                                     'Are you sure you want to delete this entry?'),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () =>
//                                         Navigator.of(context).pop(),
//                                     child: Text('Cancel'),
//                                   ),
//                                   TextButton(
//                                     onPressed: () async {
//                                       Navigator.of(context).pop();
//                                       await _deleteEntry(entry['entryId']);
//                                     },
//                                     child: Text('Delete'),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     }).toList(),
//                   ),
//               ],
//             )

//               // _buildWaterIntakeList(),
//               ),
//     );
//   }

//   Widget _buildWaterIntakeList() {
//     if (_waterIntakeData.isEmpty) {
//       return Center(child: Text('No data available'));
//     }

//     List<Widget> intakeWidgets = [];
//     for (var intake in _waterIntakeData) {
//       intakeWidgets.add(Card(
//         child: ListTile(
//           title: Text('Date: ${intake['localDate']}'),
//           subtitle: Text('Cups: ${intake['noOfCups']}'),
//           onTap: () {
//             // Show detailed entries if needed
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: Text('Water Entries'),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children:
//                       (intake['waterEntries'] as List<dynamic>).map((entry) {
//                     return ListTile(
//                       title: Text('Time: ${entry['localTime']}'),
//                       subtitle: Text('Intake: ${entry['waterIntake']}'),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.red),
//                         onPressed: () {
//                           // Show confirmation dialog
//                           showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                               title: Text('Confirm Deletion'),
//                               content: Text(
//                                   'Are you sure you want to delete this entry?'),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () => Navigator.of(context).pop(),
//                                   child: Text('Cancel'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () async {
//                                     Navigator.of(context).pop();
//                                     await _deleteEntry(entry['entryId']);
//                                   },
//                                   child: Text('Delete'),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             );
//           },
//         ),
//       ));
//     }

//     return Column(
//       children: intakeWidgets,
//     );
//   }
// }
