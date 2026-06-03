// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:nin2byo2i/Repository/auth_repo.dart';
import 'package:nin2byo2i/constants/server.dart';
// class ExerciseAPI {
//   static Future<List<Map<String, dynamic>>> fetchExerciseData(
//       String startDate, String endDate) async {
//     String? token = await AuthRepo.getToken();

//     final headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Auth': 'Bearer $token',
//     };

//     final Uri url = Uri.parse(
//         '${API.server}/api/exercises/calories-burned-and-energy-intake-range?startDate=$startDate&endDate=$endDate');

//     final response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       List<Map<String, dynamic>> exerciseDataList = [];

//       Map<String, dynamic> data = json.decode(response.body);

//       data.forEach((key, value) {
//         List<Map<String, dynamic>> totalEnergyIntake = [];
//         if (value['totalEnergyIntake'] != null) {
//           totalEnergyIntake =
//               List<Map<String, dynamic>>.from(value['totalEnergyIntake']);
//         }

//         Map<String, dynamic> entry = {
//           'date': key,
//           'totalDuration': value['totalDuration'] ?? 0.0,
//           'totalCaloriesExpenditure': value['totalCaloriesExpenditure'] ?? 0.0,
//           'totalEnergyIntake': totalEnergyIntake,
//           'totalCaloriesBurned': value['totalCaloriesBurned'] ?? 0.0,
//           'energyBalance': value['energyBalance'] ?? 0.0,
//           'restIntakeCalories': value['restIntakeCalories'] ?? 0.0,
//         };
//         exerciseDataList.add(entry);
//       });

//       return exerciseDataList;
//     } else {
//       debugPrint("Failed to load exercise data: ${response.statusCode}");
//       throw Exception('Failed to load exercise data');
//     }
//   }
// }

// class ExerciseScreen extends StatefulWidget {
//   @override
//   _ExerciseScreenState createState() => _ExerciseScreenState();
// }

// class _ExerciseScreenState extends State<ExerciseScreen> {
//   List<Map<String, dynamic>> exerciseData = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchExerciseDataAndUpdateUI();
//   }

//   void fetchExerciseDataAndUpdateUI() async {
//     try {
//       List<Map<String, dynamic>> data =
//           await ExerciseAPI.fetchExerciseData('2024-06-19', '2024-06-20');

//       setState(() {
//         exerciseData = data;
//       });
//     } catch (e) {
//       // Handle error, e.g., show an error message
//       debugPrint('Error fetching exercise data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Exercise Data'),
//       ),
//       body: exerciseData.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: exerciseData.length,
//               itemBuilder: (context, index) {
//                 final data = exerciseData[index];
//                 return ListTile(
//                   title: Text(data['date']),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Total Duration: ${data['totalDuration']}'),
//                       Text(
//                           'Total Calories Expenditure: ${data['totalCaloriesExpenditure']}'),
//                       Text(
//                           'Total Calories Burned: ${data['totalCaloriesBurned']}'),
//                       Text('Energy Balance: ${data['energyBalance']}'),
//                       ...data['totalEnergyIntake'].map<Widget>((entry) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Meal Date: ${entry['date']}'),
//                             Text('Meal Energy: ${entry['mealEnergy']}'),
//                             Text('Meal List: ${entry['rlist']}'),
//                           ],
//                         );
//                       }).toList(),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: ExerciseScreen(),
//   ));
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nin2byo2i/Repository/auth_repo.dart';
import 'package:nin2byo2i/view/home/PieChartSample2.dart';

class ExerciseAPI {
  static Future<List<Map<String, dynamic>>> fetchExerciseData(
      String startDate, String endDate) async {
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token',
    };

    final Uri url = Uri.parse(
        '${API.server}/api/exercises/calories-burned-and-energy-intake-range?startDate=$startDate&endDate=$endDate');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      debugPrint(
          "Failed to load exercise gfgfgfgdata:$startDate $endDate ${response.body}");
      List<Map<String, dynamic>> exerciseDataList = [];

      Map<String, dynamic> data = json.decode(response.body);

      data.forEach((key, value) {
        List<Map<String, dynamic>> totalEnergyIntake = [];
        if (value['totalEnergyIntake'] != null) {
          totalEnergyIntake =
              List<Map<String, dynamic>>.from(value['totalEnergyIntake']);
        }

        Map<String, dynamic> entry = {
          'date': key,
          'totalDuration': value['totalDuration'] ?? 0.0,
          'totalCaloriesExpenditure': value['totalCaloriesExpenditure'] ?? 0.0,
          'totalEnergyIntake': totalEnergyIntake,
          'totalCaloriesBurned': value['totalCaloriesBurned'] ?? 0.0,
          'energyBalance': value['energyBalance'] ?? 0.0,
          'restIntakeCalories': value['restIntakeCalories'] ?? 0.0,
        };
        exerciseDataList.add(entry);
      });

      return exerciseDataList;
    } else {
      debugPrint("Failed to load exercise data: ${response.statusCode}");
      throw Exception('Failed to load exercise data');
    }
  }
}

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  List<Map<String, dynamic>> exerciseData = [];

  @override
  void initState() {
    super.initState();
    fetchExerciseDataAndUpdateUI();
  }

  void fetchExerciseDataAndUpdateUI() async {
    try {
      List<Map<String, dynamic>> data =
          await ExerciseAPI.fetchExerciseData('2024-06-19', '2024-06-20');

      setState(() {
        exerciseData = data;
      });
    } catch (e) {
      // Handle error, e.g., show an error message
      debugPrint('Error fetching exercise data: $e');
    }
  }

  void _navigateToDetailScreen(Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseDetailScreen(data: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Data'),
      ),
      body: exerciseData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: exerciseData.length,
              itemBuilder: (context, index) {
                final data = exerciseData[index];
                return ListTile(
                  title: Text(data['date']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Duration: ${data['totalDuration']}'),
                      Text(
                          'Total Calories Expenditure: ${data['totalCaloriesExpenditure']}'),
                      Text(
                          'Total Calories Burned: ${data['totalCaloriesBurned']}'),
                      Text('Energy Balance: ${data['energyBalance']}'),
                      ElevatedButton(
                        onPressed: () => _navigateToDetailScreen(data),
                        child: const Text('View Details'),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class ExerciseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ExerciseDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Details for ${data['date']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Duration: ${data['totalDuration']}'),
            Text(
                'Total Calories Expenditure: ${data['totalCaloriesExpenditure']}'),
            Text('Total Calories Burned: ${data['totalCaloriesBurned']}'),
            Text('Energy Balance: ${data['energyBalance']}'),
            Text('Rest Intake Calories: ${data['restIntakeCalories']}'),
            const Text('Total Energy Intake:'),
            ...data['totalEnergyIntake'].map<Widget>((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Meal Date: ${entry['date']}'),
                  Text('Meal Energy: ${entry['mealEnergy']}'),
                  Text('Meal List: ${entry['rlist']}'),
                ],
              );
            }).toList(),
            Center(
              child: PieChartSample2(
                value1: 0.0, // Example values: 50%
                value2: (data['totalDuration'] != null
                        ? double.tryParse(data['totalDuration'].toString())
                        : 0.0) ??
                    0.0, // Example values: 30%
                value3: (24 -
                        (data['totalDuration'] != null
                            ? int.tryParse(data['totalDuration'].toString()) ??
                                0
                            : 0))
                    .toDouble(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExerciseScreen(),
  ));
}
