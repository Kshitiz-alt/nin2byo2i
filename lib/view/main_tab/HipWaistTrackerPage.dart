import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:provider/provider.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//hip waist tracker page
class HipWaistTrackerPage extends StatefulWidget {
  const HipWaistTrackerPage({super.key});

  @override
  _HipWaistTrackerPageState createState() => _HipWaistTrackerPageState();
}

class _HipWaistTrackerPageState extends State<HipWaistTrackerPage> {
  final UserProfileController _controller = UserProfileController();
  double hipCircumference = 0.0;
  double waistCircumference = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    fetchData1();
    super.initState();
  }

  String classifyWaistCircumference(double waistCircumferenceCm) {
    if (waistCircumferenceCm <= 93.9) {
      return 'Low risk';
    } else if (waistCircumferenceCm >= 94.0 && waistCircumferenceCm <= 101.9) {
      return 'Increased risk';
    } else {
      return 'High risk';
    }
  }

  String classifyWaistCircumferenceWomen(double waistCircumferenceCm) {
    if (waistCircumferenceCm <= 79.9) {
      return 'Low risk';
    } else if (waistCircumferenceCm >= 80.0 && waistCircumferenceCm <= 87.9) {
      return 'Increased risk';
    } else {
      return 'High risk';
    }
  }

  Future<void> fetchData1() async {
    try {
      final data = await _controller.getHipCircumference();
      Map<String, dynamic>? waistData;
      setState(() {
        waistData = data;
        hipCircumference =
            double.parse(waistData!['hipCircumference'].toString());
        debugPrint(
            "gdfhgf ${waistData!['date']} ${waistData!['waistCircumference']}");
      });
    } catch (e) {
      // Handle error
      debugPrint('Error fetching waist circumference data: $e');
    }
  }

  Future<void> fetchData() async {
    try {
      final data = await _controller.getWaistCircumference();
      Map<String, dynamic>? waistData;
      setState(() {
        waistData = data;
        waistCircumference =
            double.parse(waistData!['waistCircumference'].toString());
        debugPrint(
            "gdfhgf ${waistData!['date']} ${waistData!['waistCircumference']}");
      });
    } catch (e) {
      // Handle error
      debugPrint('Error fetching waist circumference data: $e');
    }
  }

  // Future<void> waitforapi() async {
  //   // hipCircumference = await _controller.getHipCircumference();
  //   waistCircumference = await _controller.getWaistCircumference() as double;
  //   setState(() {});
  // }

  void updateHipCircumference(double newHip) {
    _controller.hipcircumferenceCircumference(newHip);
    setState(() {
      hipCircumference = newHip;
    });
  }

  void updateWaistCircumference(double newWaist) {
    _controller.sendWaistCircumference(newWaist);
    setState(() {
      waistCircumference = newWaist;
    });
  }

  void _showHipDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double newHipValue = 0.0;
        return AlertDialog(
          title: const Text("Update Hip Circumference"),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              newHipValue = double.tryParse(value) ?? 0.0;
            },
            decoration:
                const InputDecoration(labelText: "Enter Hip Circumference in cm"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                updateHipCircumference(newHipValue);
                Navigator.of(context).pop();
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _showWaistDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double newWaistValue = 0.0;
        return AlertDialog(
          title: const Text("Update Waist Circumference"),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              newWaistValue = double.tryParse(value) ?? 0.0;
            },
            decoration:
                const InputDecoration(labelText: "Enter Waist Circumference in cm"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                updateWaistCircumference(newWaistValue);
                Navigator.of(context).pop();
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfileController =
        Provider.of<UserProfileController>(context, listen: false);
    final userProfile = userProfileController.userProfile;
    final userName =
        '${userProfile?.firstName} ${userProfile?.lastName}';
    final gender = '${userProfile?.gender} ';
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
          "Hip and Waist Circumference",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            sizedBox30(),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/img/hip.jpeg"),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              'Hip Circumference: $hipCircumference cm',
              style: const TextStyle(fontSize: AppFontSizes.mediumDefault),
            ),
            sizedBox12(),
            InkWell(
              onTap: _showHipDialog,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust border radius as needed
                  color: TColor.primaryColor1, // Blue color
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.all(10.0), // Adjust padding as needed
                  child: Text(
                    'Update Hip',
                    style: TextStyle(color: Colors.white), // Text color
                  ),
                ),
              ),
            ),
            sizedBox12(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                color: Color.fromARGB(255, 134, 132, 132),
                height: 20, // You can adjust the height of the line
                thickness: 2, // You can adjust the thickness of the line
              ),
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/img/weighst.jpeg"),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(
              'Waist Circumference: $waistCircumference cm',
              style: const TextStyle(fontSize: AppFontSizes.mediumDefault),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: _showWaistDialog,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust border radius as needed
                      color: TColor.primaryColor1, // Blue color
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(
                          10.0), // Adjust padding as needed
                      child: Text(
                        'Update Waist',
                        style: TextStyle(color: Colors.white), // Text color
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10), // Set border radius as required
                    color: const Color.fromARGB(
                        255, 135, 207, 212), // Set background color as required
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 250,
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: AppFontSizes.mediumDefault,
                              color: Colors.black), // Default text style
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'The waist circumference of $waistCircumference cm falls into the category: ',
                            ),
                            if (gender.trim().toLowerCase() == 'male')
                              TextSpan(
                                text: classifyWaistCircumference(
                                    waistCircumference),
                                style: const TextStyle(
                                  color: Colors
                                      .red, // Change the color to any color you prefer
                                ),
                              )
                            else
                              TextSpan(
                                text: classifyWaistCircumferenceWomen(
                                    waistCircumference),
                                style: const TextStyle(
                                  color: Colors
                                      .red, // Change the color to any color you prefer
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Waist Circumference Information',
                  child: IconButton(
                    icon: Icon(
                      Icons.info,
                      color: ThemeManager.themeText,
                    ),
                    onPressed: () {
                      // Show WC information here
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Waist Circumference Information'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Waist Circumference (WC) Information:',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.mediumDefault,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Text(
                                  'Waist Circumference (WC) is the circumference of the subject at the waist or abdomen when the subject is standing in a relaxed position with feet apart. It is measured using a non-elastic fiber-reinforced tape in centimeters (cm) nearest to the millimeter (mm).',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.mediumDefault,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  'Procedure on how to measure WC:',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.mediumDefault,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Text(
                                  '- The subject should stand erect with weight evenly balanced on both feet, which are placed about 25-30 cm apart. Mark the level of the lowest rib margin.',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.mediumDefault,
                                  ),
                                ),
                                const Text(
                                  '- Feel the iliac crest in the mid-auxiliary line and make a mark. Pass the measuring tape around the waist horizontally midway between the lowest rib margin and iliac crest and measure the circumference in cm up to the nearest mm.',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.mediumDefault,
                                  ),
                                ),
                                const Text(
                                  '- Alternatively, mark one inch above the umbilicus and measure the horizontal circumference of the waist exactly at that point.',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.mediumDefault,
                                  ),
                                ),
                                const Text(
                                  '- It is advised that the observer should sit on a stool in front of the subject while taking the measurement to avoid parallax error.',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.mediumDefault,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  'WHO Classification of Waist Circumference:',
                                  style: TextStyle(
                                    fontSize: AppFontSizes.mediumDefault,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Table(
                                  border: TableBorder.all(),
                                  children: const [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Category'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Men (WC in cm)'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Women (WC in cm)'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Low risk'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('93.9 cm or less'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('79.9 cm or less'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Increased risk'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('94.0 to 101.9 cm'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('80.0 to 87.9 cm'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('High risk'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('102.0 cm or more'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('88.0 cm or more'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
