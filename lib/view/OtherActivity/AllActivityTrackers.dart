import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/OtherActivity/ShowIndividualActivityData.dart';
import 'package:nin2byo2i/view/OtherActivity/StopWatchSCreen.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//in this page all availbale acvtivity is showing
class AllActivityScreen extends StatefulWidget {
  const AllActivityScreen({super.key});

  @override
  _AllActivityScreenState createState() => _AllActivityScreenState();
}

class _AllActivityScreenState extends State<AllActivityScreen> {
  // Map each activity to its corresponding icon
  Map<String, IconData> activityIcons = {
    "SLEEPING": Icons.bedtime,
    "SITTING ONLY": Icons.event_seat,
    "WATCHING T.V": Icons.tv,
    "WORKING ON COMPUTERS": Icons.computer,
    "PLAYING GAMES WHILE SITTING (INDOOR GAMES)": Icons.videogame_asset,
    "READING PAPER, PUBLIC MAGAZINE, DOING HOMEWORK": Icons.menu_book,
    "EATING (BREAKFAST/LUNCH/DINNER)": Icons.restaurant,
    "FRESH UP (BATHING/DRESSING)": Icons.accessibility,
    "DOING PRAYER/POOJA": Icons.self_improvement,
    "SOCIALIZATION (TIME PASS WITH FRIENDS/ RELATIVES)": Icons.group,
    "WALKING/STANDING": Icons.directions_walk,
    "HOUSEHOLD ACTIVITIES (CLEANING, SWEEPING, WASHING CLOTHES, COOKING)":
        Icons.cleaning_services,
    "GARDENING": Icons.local_florist,
    "FETCHING WATER": Icons.water,
    "ANIMAL/CHILD/DEPENDANT CARE": Icons.child_care,
    "SHOPPING": Icons.shopping_cart,
    "ARTISAN WORK": Icons.handyman,
    "LABOUR WORK": Icons.work,
    "CULTIVATION": Icons.agriculture,
    "TRAVELLING": Icons.directions_bus,
    "DRIVING": Icons.directions_car,
    "CYCLING": Icons.directions_bike,
    "BRISK WALKING": Icons.directions_walk,
    "JOGGING": Icons.directions_run,
    "ANY EXERCISE": Icons.fitness_center,
    "YOGA": Icons.self_improvement,
    "SWIMMING": Icons.pool,
    "PLAYING ANY OUTDOOR GAME": Icons.sports_soccer,
    "LIFTING OF LOADS": Icons.fitness_center,
    "RICKSHAW PULLING": Icons.electric_rickshaw,
    "ANY HEAVY DUTY ACTIVITY": Icons.build,
    "MOBILE USAGE": Icons.smartphone,
    // "OTHERS": Icons.more_horiz,
  };

  List<String> activities = [
    "SLEEPING",
    "SITTING ONLY",
    "WATCHING T.V",
    "WORKING ON COMPUTERS",
    "PLAYING GAMES WHILE SITTING (INDOOR GAMES)",
    "READING PAPER, PUBLIC MAGAZINE, DOING HOMEWORK",
    "EATING (BREAKFAST/LUNCH/DINNER)",
    "FRESH UP (BATHING/DRESSING)",
    "DOING PRAYER/POOJA",
    "SOCIALIZATION (TIME PASS WITH FRIENDS/ RELATIVES)",
    "WALKING/STANDING",
    "HOUSEHOLD ACTIVITIES (CLEANING, SWEEPING, WASHING CLOTHES, COOKING)",
    "GARDENING",
    "FETCHING WATER",
    "ANIMAL/CHILD/DEPENDANT CARE",
    "SHOPPING",
    "ARTISAN WORK",
    "LABOUR WORK",
    "CULTIVATION",
    "TRAVELLING",
    "DRIVING",
    "CYCLING",
    "BRISK WALKING",
    "JOGGING",
    "ANY EXERCISE",
    "YOGA",
    "SWIMMING",
    "PLAYING ANY OUTDOOR GAME",
    "LIFTING OF LOADS",
    "RICKSHAW PULLING",
    "ANY HEAVY DUTY ACTIVITY",
    "MOBILE USAGE",
    // "OTHERS",
  ];
  List<String> filteredActivities = [];

  @override
  void initState() {
    super.initState();
    filteredActivities.addAll(activities);
  }

  void filterActivities(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredActivities = activities
          .where((activity) => activity.toLowerCase().contains(query))
          .toList();
    });
  }

  void showActivityData(String activity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowIndividualActivityData(activity),
      ),
    );
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
              "assets/img/black_btn.png",
              color: ThemeManager.themeText,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.activities,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {},
        //     child: Container(
        //       margin: EdgeInsets.all(8),
        //       height: 40,
        //       width: 40,
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //           color: ThemeManager.themelightColor,
        //           borderRadius: BorderRadius.circular(10)),
        //       child: Image.asset(
        //         "assets/img/more_btn.png",
        //         color: ThemeManager.themeText,
        //         width: 15,
        //         height: 15,
        //         fit: BoxFit.contain,
        //       ),
        //     ),
        //   )
        // ],
      ),
      backgroundColor: ThemeManager.themeColor,
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // width: 314,
                height: 45.97,
                decoration: ShapeDecoration(
                  color: ThemeManager.themelightColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: TextField(
                  onChanged: filterActivities,
                  decoration: InputDecoration(
                    hintText: Languages.of(context)!.searchActivityHere,
                    hintStyle: TextStyle(
                      color: ThemeManager.themeText,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: ThemeManager.themeText,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: ThemeManager.themeText),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  Languages.of(context)!.orSelectActivityFromBelow,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ThemeManager.themeText),
                ),
              ],
            ),
          ),
          sizedBox12(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     onChanged: filterActivities,
          //     decoration: InputDecoration(
          //       labelText: 'Search Activities',
          //       prefixIcon: Icon(Icons.search),
          //     ),
          //   ),
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < filteredActivities.length; i++)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                showActivityData(filteredActivities[i]),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                // gradient: LinearGradient(colors: [
                                //   TColor.primaryColor1.withOpacity(0.6),
                                //   TColor.secondaryColor1.withOpacity(0.6)
                                // ]),

                                borderRadius: BorderRadius.circular(14),
                                color: const Color.fromARGB(255, 34, 104, 161),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  activityIcons[filteredActivities[i]],
                                  color: Colors.white,
                                  size: 35,
                                ),
                                title: Text(
                                  filteredActivities[i],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                // Add onTap or other interactions as needed
                              ),
                            ),
                          ),
                        ),
                        // if (i + 1 < filteredActivities.length)
                        //   Expanded(
                        //     child: GestureDetector(
                        //       onTap: () =>
                        //           showActivityData(filteredActivities[i + 1]),
                        //       child: Container(
                        //         margin: const EdgeInsets.symmetric(
                        //             horizontal: 8.0, vertical: 4.0),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(14),
                        //           color: Color.fromARGB(255, 34, 104, 161),
                        //         ),
                        //         child: ListTile(
                        //           leading: Icon(
                        //             activityIcons[filteredActivities[i + 1]],
                        //             color: Colors.white,
                        //             size: 35,
                        //           ),
                        //           title: Text(
                        //             filteredActivities[i + 1],
                        //             style: TextStyle(color: Colors.white),
                        //           ),
                        //           // Add onTap or other interactions as needed
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
