import 'package:flutter/material.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';

class BloodPressurePage1 extends StatefulWidget {
  const BloodPressurePage1({super.key});

  @override
  _BloodPressurePage1State createState() => _BloodPressurePage1State();
}

class _BloodPressurePage1State extends State<BloodPressurePage1> {
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
      // Replace 'startDate' and 'endDate' with your desired date range
      final bloodPressureData =
          await _controller.getBloodPressureDataByDateRange(
        '2024-05-16',
        '2024-05-16',
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Pressure Data'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _bloodPressureData.isEmpty
              ? const Center(child: Text('No data available'))
              : ListView.builder(
                  itemCount: _bloodPressureData.length,
                  itemBuilder: (context, index) {
                    final bloodPressure = _bloodPressureData[index];
                    final date = bloodPressure['localDate'];
                    final systolic = bloodPressure['systolicValue'];
                    final diastolic = bloodPressure['diastolicValue'];
                    return _buildListItem(date, systolic, diastolic);
                  },
                ),
    );
  }

  Widget _buildListItem(String date, double systolic, double diastolic) {
    return ListTile(
      title: Text('Date: $date'),
      subtitle: Text('Systolic: $systolic, Diastolic: $diastolic'),
    );
  }
}
