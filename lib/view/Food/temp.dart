import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown with Shared Preferences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DropdownPage(),
    );
  }
}

class DropdownPage extends StatefulWidget {
  const DropdownPage({super.key});

  @override
  _DropdownPageState createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  String selectedOption = 'Calories';

  @override
  void initState() {
    super.initState();
    loadSavedOption();
  }

  Future<void> loadSavedOption() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = prefs.getString('selectedOption') ?? 'Calories';
    });
  }

  Future<void> saveSelectedOption(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedOption', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown with Shared Preferences'),
      ),
      body: Center(
        child: DropdownButton<String>(
          style: const TextStyle(color: Colors.white),
          dropdownColor: const Color.fromARGB(255, 189, 20, 124),
          icon: const Icon(Icons.expand_more, color: Colors.white),
          underline: Container(),
          menuMaxHeight: 400,
          value: selectedOption,
          onChanged: (newValue) {
            setState(() {
              selectedOption = newValue!;
            });
            saveSelectedOption(newValue!);
          },
          items: <String>[
            'Calories',
            'Proteins',
            'Carbs',
            'Fats',
            'Fibers',
            'Calcium',
            'Iron',
            'Zinc',
            'Magnesium',
            'ThiamineB1',
            'RiboflavinB2',
            'NiacinB3',
            'FolatesB9',
            'RetinolVitA',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
