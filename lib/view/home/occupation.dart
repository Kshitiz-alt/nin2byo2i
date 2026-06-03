import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';

//user can select occupation from here
class OccupationsScreen extends StatefulWidget {
  const OccupationsScreen({super.key});

  @override
  _OccupationsScreenState createState() => _OccupationsScreenState();
}

class _OccupationsScreenState extends State<OccupationsScreen> {
  final UserProfileController _controller = UserProfileController();

  // Initial Dropdown value
  String _selectedOccupation = "Artisan";

  // List of occupations
  List<String> _occupations = [];

  @override
  void initState() {
    super.initState();
    _fetchOccupations();
  }

// Fetch occupations and update the state
  void _fetchOccupations() async {
    List<String> occupationsList = await _controller.getAllOccupations();

    // Find the index of "Artisan" in the list
    int artisanIndex = occupationsList.indexOf("Artisan");

    // If "Artisan" exists in the list, remove it from its current position
    // and insert it at the beginning
    if (artisanIndex != -1) {
      occupationsList.removeAt(artisanIndex);
      occupationsList.insert(0, "Artisan");
    }

    setState(() {
      debugPrint("gfdghgfhg $_occupations");
      _occupations = occupationsList;
      // Optionally, set an initial value for the dropdown
    });
  }

  // Function to handle submission
  void _handleSubmit() async {
    bool success =
        await _controller.saveWorkLevelOccupation(_selectedOccupation);
    if (success) {
      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Occupation saved successfully'),
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to save occupation'),
        ),
      );
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Occupations'),
      ),
      body: Center(
        child: _occupations.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: _selectedOccupation,
                    dropdownColor: const Color.fromARGB(255, 189, 20, 124),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedOccupation = newValue!;
                      });
                    },
                    items: _occupations
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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
                    onPressed: _handleSubmit,
                    child: const Text('Submit'),
                  ),
                ],
              )
            : const CircularProgressIndicator(), // Show loading indicator while fetching data
      ),
    );
  }
}
