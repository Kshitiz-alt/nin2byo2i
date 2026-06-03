// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Time Picker Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: TimePickerPage(),
//     );
//   }
// }

// class TimePickerPage extends StatefulWidget {
//   @override
//   _TimePickerPageState createState() => _TimePickerPageState();
// }

// class _TimePickerPageState extends State<TimePickerPage> {
//   late TimeOfDay selectedTime;
//   String formattedTime = '';

//   @override
//   void initState() {
//     super.initState();
//     selectedTime = TimeOfDay.now();
//     formattedTime = _formatTime(selectedTime);
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//     if (picked != null && picked != selectedTime) {
//       setState(() {
//         selectedTime = picked;
//         formattedTime = _formatTime(picked);
//       });
//     }
//   }

//   String _formatTime(TimeOfDay time) {
//     final int hour = time.hour;
//     final int minute = time.minute;
//     final String formattedHour = hour.toString().padLeft(2, '0');
//     final String formattedMinute = minute.toString().padLeft(2, '0');
//     return '$formattedHour:$formattedMinute';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Time Picker Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Selected time: $formattedTime',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _selectTime(context),
//               child: Text('Select Time'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
