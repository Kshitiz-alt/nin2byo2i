import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/constants/server.dart';
import 'package:intl/intl.dart';

//order history page
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final UserProfileController controller = UserProfileController();
  bool isLoadingScreenCheck = true;
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    loadOrderHistory();
  }

  Future<void> loadOrderHistory() async {
    final UserProfileController controller = UserProfileController();
    final data = await controller.fetchOrderHistory();
    if (mounted) {
      setState(() {
        isLoadingScreenCheck = false;
        orders = data.cast<Map<String, dynamic>>();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedOrders = {};

    // Group orders by ninOrderId
    for (var order in orders) {
      String ninOrderId = order["ninOrderId"];
      if (!groupedOrders.containsKey(ninOrderId)) {
        groupedOrders[ninOrderId] = [];
      }
      groupedOrders[ninOrderId]!.add(order);
      debugPrint("FfgbFGHgfhfghfg $groupedOrders");
    }
    // Reverse the groupedOrders map by reassigning the reversed entries
    groupedOrders = Map.fromEntries(
      groupedOrders.entries
          .toList()
          .reversed, // Reverse the map entries and convert it back to a map
    );
    String formatDate(int timestamp) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return DateFormat('dd-MM-yyyy').format(date); // Format as dd-MM-yyyy
    }

    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          // Handle back button press
          Navigator.pop(context);
          return false; // Return false to block the default behavior
        },
        child: isLoadingScreenCheck
            ? const CommonDataLoadingScreen()
            : Scaffold(
                // appBar: AppBar(
                //   title: Text('Order History'),
                // ),
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
                        width: 15,
                        height: 15,
                        color: ThemeManager.themeText,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  title: Text(
                    Languages.of(context)!.labelAllOrders,
                    style: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.mediumDefault,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                backgroundColor: ThemeManager.themeColor,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBox30(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Languages.of(context)!.labelMyOrders,
                            style: TextStyle(
                              color: ThemeManager.themeText,
                              fontSize: AppFontSizes.mediumDefault,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              height: 0.08,
                            ),
                          ),
                        ),
                        sizedBox12(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${groupedOrders.length} ${Languages.of(context)!.labelOrdersInMyOrders}',
                            style: TextStyle(
                              color: ThemeManager.themeText,
                              fontSize: AppFontSizes.smallDefault,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              height: 0.14,
                            ),
                          ),
                        ),
                        for (int i = 0; i < groupedOrders.length; i++)
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailedPage(
                                      groupedOrders[
                                          groupedOrders.keys.elementAt(i)]!),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.withOpacity(0.5))),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 85,
                                      height: 85,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                      child: Image.asset(
                                        "assets/images/book.png",
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                            'assets/images/fork 2.png',
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 186,
                                          child: Text(
                                            '${Languages.of(context)!.labelOrderId}:${groupedOrders.keys.elementAt(i)} ',
                                            style: TextStyle(
                                              color: ThemeManager.themeText,
                                              fontSize:
                                                  AppFontSizes.mediumDefault,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Show formatted deliveryDate or createTimestamp
                                        SizedBox(
                                          width: 186,
                                          child: Text(
                                            'Order Date: ${formatDate(groupedOrders[groupedOrders.keys.elementAt(i)]![0]["createTimestamp"])}',
                                            style: TextStyle(
                                              color: ThemeManager.themeText,
                                              fontSize:
                                                  AppFontSizes.smallDefault,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailedPage(groupedOrders[
                                                      groupedOrders.keys
                                                          .elementAt(i)]!),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.navigate_next,
                                          color: ThemeManager.themeText,
                                        )
                                        // Image.asset(
                                        //   "assets/img/next_icon.png",
                                        //   width: 35,
                                        //   height: 35,
                                        // ),
                                        )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   itemCount: groupedOrders.length,
                        //   itemBuilder: (context, index) {
                        //     String ninOrderId = groupedOrders.keys.elementAt(index);
                        //     return InkWell(
                        //       onTap: () {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) =>
                        //                 DetailedPage(groupedOrders[ninOrderId]!),
                        //           ),
                        //         );
                        //       },
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //             border: Border(
                        //                 bottom: BorderSide(
                        //                     color: Colors.grey.withOpacity(0.5))),
                        //           ),
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 width: 85,
                        //                 height: 85,
                        //                 decoration: ShapeDecoration(
                        //                   shape: RoundedRectangleBorder(
                        //                       borderRadius: BorderRadius.circular(4)),
                        //                 ),
                        //                 child: Image.asset(
                        //                   "assets/images/book.png",
                        //                   width: double.infinity,
                        //                   fit: BoxFit.cover,
                        //                   errorBuilder: (BuildContext context,
                        //                       Object exception,
                        //                       StackTrace? stackTrace) {
                        //                     return Image.asset(
                        //                       'assets/images/fork 2.png',
                        //                       fit: BoxFit.cover,
                        //                     );
                        //                   },
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 width: 16,
                        //               ),
                        //               Column(
                        //                 mainAxisAlignment: MainAxisAlignment.start,
                        //                 children: [
                        //                   SizedBox(
                        //                     width: 186,
                        //                     child: Text(
                        //                       'Order Id:$ninOrderId ',
                        //                       style: TextStyle(
                        //                         color: ThemeManager.themeText,
                        //                         fontSize: AppFontSizes .mediumDefault,
                        //                         fontFamily: 'Poppins',
                        //                         fontWeight: FontWeight.w400,
                        //                         height: 0,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //               Spacer(),
                        //               IconButton(
                        //                   onPressed: () {
                        //                     Navigator.push(
                        //                       context,
                        //                       MaterialPageRoute(
                        //                         builder: (context) => DetailedPage(
                        //                             groupedOrders[ninOrderId]!),
                        //                       ),
                        //                     );
                        //                   },
                        //                   icon: Icon(
                        //                     Icons.navigate_next,
                        //                     color: ThemeManager.themeText,
                        //                   )
                        //                   // Image.asset(
                        //                   //   "assets/img/next_icon.png",
                        //                   //   width: 35,
                        //                   //   height: 35,
                        //                   // ),
                        //                   )
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //     // InkWell(
                        //     //     onTap: () {
                        //     //       Navigator.push(
                        //     //         context,
                        //     //         MaterialPageRoute(
                        //     //           builder: (context) =>
                        //     //               DetailedPage(groupedOrders[ninOrderId]!),
                        //     //         ),
                        //     //       );
                        //     //     },
                        //     //     child: Container(
                        //     //         margin: const EdgeInsets.symmetric(
                        //     //             vertical: 8, horizontal: 2),
                        //     //         padding: const EdgeInsets.all(10),
                        //     //         decoration: BoxDecoration(
                        //     //             border: Border.all(
                        //     //               color: ThemeManager
                        //     //                   .themeText, // Set your border color here
                        //     //               width: 2.0, // Set the border width
                        //     //             ),
                        //     //             color: ThemeManager.themeColor,
                        //     //             borderRadius: BorderRadius.circular(15),
                        //     //             boxShadow: const [
                        //     //               BoxShadow(color: Colors.black12, blurRadius: 2)
                        //     //             ]),
                        //     //         child: Row(
                        //     //           children: [
                        //     //             // Image.asset(
                        //     //             //   'assets/img/f_1.png',
                        //     //             //   width: 50,
                        //     //             //   height: 50,
                        //     //             //   fit: BoxFit.contain,
                        //     //             // ),
                        //     //             const SizedBox(
                        //     //               width: 15,
                        //     //             ),
                        //     //             Expanded(
                        //     //               child: Column(
                        //     //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //     //                 children: [
                        //     //                   Text(
                        //     //                     'Order ID: ',
                        //     //                     style: TextStyle(
                        //     //                         color: Colors.black,
                        //     //                         fontSize: AppFontSizes .mediumDefault,
                        //     //                         fontWeight: FontWeight.w500),
                        //     //                   ),
                        //     //                   Text(
                        //     //                     "$ninOrderId",
                        //     //                     style: TextStyle(
                        //     //                       fontSize: AppFontSizes.mediumDefault,
                        //     //                       color: Colors.black,
                        //     //                     ),
                        //     //                   )
                        //     //                 ],
                        //     //               ),
                        //     //             ),
                        //     //             IconButton(
                        //     //               onPressed: () {
                        //     //                 Navigator.push(
                        //     //                   context,
                        //     //                   MaterialPageRoute(
                        //     //                     builder: (context) => DetailedPage(
                        //     //                         groupedOrders[ninOrderId]!),
                        //     //                   ),
                        //     //                 );
                        //     //               },
                        //     //               icon: Image.asset(
                        //     //                 "assets/img/next_icon.png",
                        //     //                 width: 25,
                        //     //                 height: 25,
                        //     //               ),
                        //     //             )
                        //     //           ],
                        //     //         )));
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class DetailedPage extends StatefulWidget {
  final List<Map<String, dynamic>> orders;

  const DetailedPage(this.orders, {super.key});

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  String _formatTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    // Formatting the date and time
    return '${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)} ${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}:${_twoDigits(dateTime.second)}';
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;

    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        //  Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => SecondPage()),
        //   );
        Navigator.pop(context);
        return false; // Return false to block the default behavior
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Detailed Page'),
        // ),
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
            Languages.of(context)!.labelOrderDetail,
            style: TextStyle(
                color: ThemeManager.themeText,
                fontSize: AppFontSizes.mediumDefault,
                fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: ThemeManager.themeColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Languages.of(context)!.labelOrderDetail,
                  style: TextStyle(
                    fontSize: AppFontSizes.largeDefault,
                    fontWeight: FontWeight.bold,
                    color: ThemeManager.themeText,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${Languages.of(context)!.labelOrderId}: ${widget.orders.first["ninOrderId"]}',
                  style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.bold,
                    color: ThemeManager.themeText,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    Languages.of(context)!.NINTextBookDetails,
                    style: TextStyle(
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.bold,
                      color: ThemeManager.themeText,
                    ),
                  ),
                ),
                // Use Column to display the list of books
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.orders.map((order) {
                    debugPrint("gfvfdhfnjgh mageName $order");
                    String ImageName = order["book"]["imageFilename"];
                    debugPrint("gfvfdhfnjgh $ImageName");
                    // Null checks before performing multiplication
                    double orderPrice = order["book"]["price"] ?? 0.0;
                    final int orderQuantity = order["quantity"] ?? 0;

                    orderPrice = orderPrice * orderQuantity;

                    // Update total price
                    totalPrice += orderPrice;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.5))),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: 85,
                                height: 85,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                child: Image.network(
                                  "${API.server}/images/$ImageName",
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      // Image is fully loaded
                                      return child;
                                    } else {
                                      // Image is still loading
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    // Error occurred while loading image
                                    return const Text('Error loading image');
                                  },
                                )),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 220,
                                  child: Text(
                                    order["book"]["title"],
                                    style: TextStyle(
                                      color: ThemeManager.themeText,
                                      fontSize: AppFontSizes.mediumDefault,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 220,
                                    child: Text(
                                      'Quantity Ordered : $orderQuantity',
                                      style: TextStyle(
                                        color: ThemeManager.themeText,
                                      ),
                                    )),
                                SizedBox(
                                    width: 220,
                                    child: Text(
                                      '${Languages.of(context)!.labelPrice}: ${orderPrice.toStringAsFixed(orderPrice >= 99 ? 0 : 2)}',
                                      style: TextStyle(
                                        color: ThemeManager.themeText,
                                      ),
                                      // style: TextStyle(
                                      //   color: Colors.black,
                                      //   fontSize: AppFontSizes.mediumDefault,
                                      //   fontFamily: 'Poppins',
                                      //   fontWeight: FontWeight.w500,
                                      //   height: 0,
                                      // ),
                                    )),
                                // SizedBox(
                                //     width: 220,
                                //     child: Text(
                                //       '${Languages.of(context)!.labelDeliverystatus}: ${order["deliveryDate"]}',
                                //       style: TextStyle(
                                //         color: ThemeManager.themeText,
                                //       ),
                                //     )),
                                SizedBox(
                                  width: 220,
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                          color: ThemeManager
                                              .themeText), // Default text style for the whole text
                                      children: [
                                        TextSpan(
                                          text:
                                              '${Languages.of(context)!.labelDeliverystatus}: ',
                                          style: TextStyle(
                                              color: ThemeManager
                                                  .themeText), // Default color for the label
                                        ),
                                        TextSpan(
                                          text: '${order["deliveryDate"]}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255,
                                                  5,
                                                  76,
                                                  7)), // Green color for the delivery date
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 220,
                                    child: Text(
                                      '${Languages.of(context)!.labelOrderDate}: ${_formatTimestamp(order["createTimestamp"])}',
                                      style: TextStyle(
                                        color: ThemeManager.themeText,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );

                    //  Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         gradient: LinearGradient(colors: [
                    //           TColor.primaryColor2.withOpacity(0.5),
                    //           TColor.primaryColor1.withOpacity(0.5)
                    //         ]),
                    //         borderRadius: BorderRadius.circular(25)),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 24.0),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text(
                    //               'Title: ${order["book"]["title"]}',
                    //               style: TextStyle(
                    //                 fontSize: AppFontSizes.mediumDefault.0,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text('Quantity: ${orderQuantity}'),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text(
                    //                 'Price: ${orderPrice.toStringAsFixed(2)}'),
                    //           ), // Format price to two decimal places
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text(
                    //                 'Delivery Date: ${order["deliveryDate"]}'),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Text(
                    //                 'Order Date: ${order["createTimestamp"]}'),
                    //           ),
                    //           // Add more details if needed
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // Display total price
                Text(
                  '${Languages.of(context)!.labelTotalPrice}: ₹${totalPrice.toStringAsFixed(totalPrice >= 99 ? 0 : 2)}',
                  style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    color: ThemeManager.themeText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    // color: const Color(0xaa15b8ff).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xaa15b8ff), width: 2),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The books purchased will be delivered within a maximum of 20 working days. If not received within the mentioned time, please contact:',
                        style: TextStyle(
                          fontSize: AppFontSizes.mediumDefault,
                          fontWeight: FontWeight.bold,
                          color: Color(0xaa15b8ff),
                        ),
                      ),
                      Text(
                        'Email: petninhyd@yahoo.com',
                        style: TextStyle(
                          fontSize: AppFontSizes.mediumDefault,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Phone: 04027197247',
                        style: TextStyle(
                          fontSize: AppFontSizes.mediumDefault,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
