// import 'package:flutter/material.dart';
// import 'package:nin2byo2i/Controller/user_profile_controller.dart';

// void main() {
//   runApp(MaterialApp(
//     home: IngredientCalculatorPage(),
//   ));
// }

// class IngredientCalculatorPage extends StatefulWidget {
//   @override
//   _IngredientCalculatorPageState createState() =>
//       _IngredientCalculatorPageState();
// }

// class _IngredientCalculatorPageState extends State<IngredientCalculatorPage> {
//   final UserProfileController _controller = UserProfileController();
//   final List<Map<String, dynamic>> ingredients = [
//     {"ingredientName": "Amaranth seed", "weight": 1.0},
//     {"ingredientName": "Amaranth seed", "weight": 100},
//     {"ingredientName": "Bajra", "weight": 100},
//   ];

//   List<DataRow> tableRows = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ingredient Calculator'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 _calculateIngredients();
//               },
//               child: Text('Calculate Ingredients'),
//             ),
//             SizedBox(height: 20),
//             Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   color: Colors.grey[200],
//                 ),
//                 child: tableRows.isNotEmpty
//                     ? DataTable(
//                         headingRowColor: MaterialStateColor.resolveWith(
//                           (states) => Colors.grey,
//                         ),
//                         columns: [
//                           DataColumn(
//                             label: Text('Ingredient'),
//                             numeric: false,
//                             tooltip: 'Ingredient Name',
//                           ),
//                           DataColumn(
//                             label: Text('Weight(g)'),
//                             numeric: true,
//                             tooltip: 'Weight of Ingredient',
//                           ),
//                         ],
//                         rows: tableRows,
//                       )
//                     : Text("")),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _calculateIngredients() async {
//     try {
//       Map<String, dynamic> responseData =
//           await _controller.calculateIngredients(ingredients);
//       _displayNutritionalInfo(responseData);
//     } catch (error) {
//       // Handle error
//     }
//   }

//   void _displayNutritionalInfo(Map<String, dynamic> responseData) {
//     List<dynamic> nutritionalInfoList = responseData['nutritionalInfoList'];
//     double totalEnergy = responseData['totalEnergy'];
//     double totalProteins = responseData['totalProteins'];
//     double totalCarbs = responseData['totalCarbs'];
//     double totalFats = responseData['totalFats'];
//     double totalFibers = responseData['totalFibers'];

//     setState(() {
//       tableRows.clear();
//       tableRows.add(DataRow(cells: [
//         DataCell(Text('Energy')),
//         DataCell(Text('${totalEnergy.toStringAsFixed(2)}')),
//       ]));
//       tableRows.add(DataRow(cells: [
//         DataCell(Text('Proteins')),
//         DataCell(Text('${totalProteins.toStringAsFixed(2)}')),
//       ]));
//       tableRows.add(DataRow(cells: [
//         DataCell(Text('Carbs')),
//         DataCell(Text('${totalCarbs.toStringAsFixed(2)}')),
//       ]));
//       tableRows.add(DataRow(cells: [
//         DataCell(Text('Fats')),
//         DataCell(Text('${totalFats.toStringAsFixed(2)}')),
//       ]));
//       tableRows.add(DataRow(cells: [
//         DataCell(Text('Fibers')),
//         DataCell(Text('${totalFibers.toStringAsFixed(2)}')),
//       ]));
//     });
//   }
// }
