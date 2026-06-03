import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Repository/auth_repo.dart';
import 'package:intl/intl.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/notification_row.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//notification page
class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final UserProfileController _controller = UserProfileController();
  Future<void> fetchData() async {
    try {
      List<Map<String, dynamic>> newData =
          await _controller.GetNotificationList();
      List<Map<String, dynamic>> reversedData = newData.reversed.toList();

      // debugPrint("dgdggdgdgdg $newData");
      setState(() {
        data = reversedData;
      });
    } catch (e) {
      debugPrint('Error: $e');
      // Handle error, e.g., show a snackbar or retry button
    }
  }

  Future<void> deleteAllNotifications() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //     title: Text(Languages.of(context)!.ninTextDeleteNotification),
          content: Text(Languages.of(context)!.confirmDeleteAllNotifications),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(Languages.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () async {
                // Perform delete operation here
                await _controller.deleteAllNotifications();
                setState(() {
                  fetchData();
                });
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(Languages.of(context)!.ninTextDelete),
            ),
          ],
        );
      },
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
          Languages.of(context)!.labelNotification,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: ThemeManager.themeText),
            onPressed: () async {
              await deleteAllNotifications();
            },
          ),
        ],
      ),
      backgroundColor: ThemeManager.themeColor,
      body: (data.isEmpty)
          ? Center(
              child: Text(
                Languages.of(context)!.TextAppNoNotificationsFound,
                style: const TextStyle(
                  fontSize: AppFontSizes.mediumDefault,
                  color: Colors.grey,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Loop through the data using a for loop
                  for (int index = 0; index < data.length; index++)
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        // height: 45,
                        decoration: ShapeDecoration(
                          color: ThemeManager.themelightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    "assets/icon.png",
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data[index]['body'] ?? '',
                                    style: TextStyle(
                                        color: ThemeManager.themeText,
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppFontSizes.mediumDefault),
                                  ),
                                  Text(
                                    data[index]['message'] ?? '',
                                    style: TextStyle(
                                      color: ThemeManager.themeText
                                          .withOpacity(0.8),
                                      fontSize: AppFontSizes.smallDefault,
                                    ),
                                  ),
                                ],
                              )),
                              Row(
                                children: [
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(
                                            data[index]['localDate'])),
                                    style: TextStyle(
                                        color: ThemeManager.themeText),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    ' ${data[index]['startTime'][0]}:${data[index]['startTime'][1].toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                        color: ThemeManager.themeText),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: ThemeManager.themeColor,
  //       centerTitle: true,
  //       elevation: 0,
  //       leading: InkWell(
  //         onTap: () {
  //           Navigator.pop(context);
  //         },
  //         child: Container(
  //           margin: const EdgeInsets.all(8),
  //           height: 40,
  //           width: 40,
  //           alignment: Alignment.center,
  //           decoration: BoxDecoration(
  //               color: ThemeManager.themelightColor,
  //               borderRadius: BorderRadius.circular(10)),
  //           child: Image.asset(
  //             "assets/img/black_btn.png",
  //             color: ThemeManager.themeText,
  //             width: 15,
  //             height: 15,
  //             fit: BoxFit.contain,
  //           ),
  //         ),
  //       ),
  //       title: Text(
  //         Languages.of(context)!.labelNotification,
  //         style: TextStyle(
  //             color: ThemeManager.themeText,
  //             fontSize: AppFontSizes.mediumDefault,
  //             fontWeight: FontWeight.w700),
  //       ),
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.delete, color: ThemeManager.themeText),
  //           onPressed: () async {
  //             await deleteAllNotifications();
  //           },
  //         ),
  //       ],
  //     ),
  //     backgroundColor: ThemeManager.themeColor,
  //     body: (data.isEmpty)
  //         ? Center(
  //             child: Text(
  //               Languages.of(context)!.TextAppNoNotificationsFound,
  //               style: TextStyle(
  //                 fontSize: AppFontSizes.mediumDefault,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           )
  //         : ListView.builder(
  //             itemCount: data.length,
  //             itemBuilder: (context, index) {
  //               final startTime = data[index]['startTime'];
  //               final date = data[index]['localDate'];
  //               return Padding(
  //                 padding: const EdgeInsets.all(8),
  //                 child: Container(
  //                   height: 45,
  //                   decoration: ShapeDecoration(
  //                     color: ThemeManager.themelightColor,
  //                     shape: RoundedRectangleBorder(
  //                       // side: BorderSide(width: 1, color: Color(0xFFF7F8F8)),
  //                       borderRadius: BorderRadius.circular(14),
  //                     ),
  //                   ),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: ClipRRect(
  //                           borderRadius: BorderRadius.circular(30),
  //                           child: Image.asset(
  //                             "assets/img/mid_morning.jpg",
  //                             width: 35,
  //                             height: 35,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(
  //                         width: 15,
  //                       ),
  //                       Expanded(
  //                           child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             data[index]['body'] ?? '',
  //                             style: TextStyle(
  //                                 color: ThemeManager.themeText,
  //                                 fontWeight: FontWeight.w500,
  //                                 fontSize: AppFontSizes.mediumDefault),
  //                           ),
  //                           Text(
  //                             data[index]['message'] ?? '',
  //                             style: TextStyle(
  //                               color: ThemeManager.themeText.withOpacity(0.8),
  //                               fontSize: AppFontSizes.smallDefault,
  //                             ),
  //                           ),
  //                         ],
  //                       )),
  //                       // Spacer(),
  //                       Row(
  //                         children: [
  //                           Text(
  //                             ' ${date[2].toString().padLeft(2, '0')}/${date[1]}/${date[0]}',
  //                             style: TextStyle(color: ThemeManager.themeText),
  //                           ),
  //                           SizedBox(
  //                             width: 5,
  //                           ),
  //                           Text(
  //                             ' ${startTime[0]}:${startTime[1].toString().padLeft(2, '0')}',
  //                             style: TextStyle(color: ThemeManager.themeText),
  //                           ),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         width: 10,
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //   );
  // }
}
