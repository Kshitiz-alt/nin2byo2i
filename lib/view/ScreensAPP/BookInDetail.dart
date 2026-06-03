import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/ScreensAPP/CartForOrder.dart';
import 'package:nin2byo2i/view/ScreensAPP/addReview.dart';
import 'package:shared_preferences/shared_preferences.dart';

//book detail page
class BookDetailsPage extends StatefulWidget {
  final Map<String, dynamic> book;

  const BookDetailsPage({super.key, required this.book});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  late Future<Map<String, dynamic>> _futureReview;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final UserProfileController controller = UserProfileController();

    _futureReview = controller.getReviewsByBook(widget.book['id']);
    _getCartItems();
  }

  int numberOfElements = 0;
  List<String> cartItems = [];
  Future<void> _getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cartItems = prefs.getStringList('cartItems') ?? [];
      numberOfElements = cartItems.length;
      debugPrint("Total number of elements in cartItems: $numberOfElements");
      debugPrint("Order cart ids first fetch $cartItems ");
    });
  }

  Future<void> _addToCart(BuildContext context) async {
    // Get the book ID
    int bookId = widget.book['id'];
    double price = widget.book['price']?.toDouble() ?? 0.0;

    // Save the book ID in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cartItems') ?? [];

    // Check if the book is already in the cart
    bool alreadyInCart =
        cartItems.any((item) => item.startsWith("${bookId.toString()}x"));

    if (alreadyInCart) {
      // Show a snackbar indicating that the book is already in the cart
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Languages.of(context)!.alreadyInCart),
          backgroundColor: Colors.blue,
          duration: const Duration(milliseconds: 1500),
        ),
      );
    } else {
      // Add the book to the cart with a default quantity of 1 and price
      cartItems.add("${bookId.toString()}x1x$price");
      prefs.setStringList('cartItems', cartItems);

      // Show a snackbar indicating that the book is added to the cart
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Languages.of(context)!.addedToCart),
          //Text('Added to Cart: ${book['title']}'),
          backgroundColor: Colors.green, duration: const Duration(milliseconds: 1500),
          // duration: Duration(seconds: 1),
        ),
      );
      setState(() {
        _getCartItems();
      });
    }
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
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          widget.book["title"],
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Image.asset(
                  "assets/images/cart.png",
                  width: 24.0, // Set the desired width
                  // height: 24.0,
                  color: ThemeManager.themeText,
                  fit: BoxFit.cover,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                  setState(() {
                    _getCartItems();
                  });
                },
              ),
              if (numberOfElements > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 24,
                      minHeight: 24,
                    ),
                    child: Center(
                      child: Text(
                        '$numberOfElements',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
      // appBar: AppBar(
      //   title: Text('Book Details'),
      // ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 312,
                  child: Text(
                    widget.book['title'],
                    style: TextStyle(
                      color: ThemeManager.themeText,
                      fontSize: AppFontSizes.largeDefault,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                    width: 307,
                    height: 423,
                    child: Image.network(
                      widget.book['imageUrl'],
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          // Image is fully loaded
                          return child;
                        } else {
                          // Image is still loading
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        // Error occurred while loading image
                        return const Text('Error loading image');
                      },
                    )),
              ),
              sizedBox12(),
              Text(
                'Publisher : ${widget.book['author']}',
                style: TextStyle(
                  color: ThemeManager.themeText,
                ),
              ),
              //   Text(
              //   '${Languages.of(context)!.labelAuthor}: ${widget.book['author']}',
              //   style: TextStyle(
              //     color: ThemeManager.themeText,
              //   ),
              // ),
              // Text(
              //   '${Languages.of(context)!.labelYear}: ${widget.book['year']}',
              //   style: TextStyle(
              //     color: ThemeManager.themeText,
              //   ),
              // ),
              // Text(
              //   '${Languages.of(context)!.labelQuantityAvailable}: ${widget.book['quantity']}',
              //   style: TextStyle(
              //     color: ThemeManager.themeText,
              //   ),
              // ),
              sizedBox12(),
              // SizedBox(
              //   // width: 116,
              //   child: Row(
              //     children: [
              //       Text(
              //         "${Languages.of(context)!.TextAppRatings} ",
              //         style: TextStyle(
              //           color: ThemeManager.themeText,
              //           fontSize: AppFontSizes.smallDefault,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.w400,
              //           height: 0,
              //         ),
              //       ),
              //       Text(
              //         widget.book['ratings'].toStringAsFixed(1),
              //         style: TextStyle(
              //           color: Colors.amber,
              //           fontSize: AppFontSizes.largeDefault,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.bold,
              //           height: 0,
              //         ),
              //       ),
              //       Icon(
              //         Icons.star,
              //         color: Colors.yellow,
              //         size: 20.0,
              //       ),
              //     ],
              //   ),
              // ),

              Row(
                children: [
                  // SizedBox(
                  //   width: 8,
                  // ),
                  SizedBox(
                    // width: 48,
                    child: Text(
                      '${Languages.of(context)!.labelPrice} : ₹${widget.book['price'].toStringAsFixed(1)}',
                      style: const TextStyle(
                        color: Color(0xAAFF1515),
                        fontSize: AppFontSizes.mediumDefault,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                  const Spacer(),

                  if (((double.tryParse(widget.book['quantity'].toString()) ??
                              0.0)
                          .toInt()) >
                      5)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: ElevatedButton(
                        onPressed: () => _addToCart(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColor
                              .secondaryColor1, // Set the background color to light blue
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25.0), // Set the border radius
                          ),
                        ),
                        child: Text(Languages.of(context)!.labelAddToCart),
                      ),
                    )
                  else
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 117, 115, 116),
                              Color.fromARGB(255, 117, 115, 116),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Out of Stock",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // ElevatedButton(
                  //   onPressed: () => _addToCart(context),
                  //   child: SizedBox(
                  //     width: 100,
                  //     height: 30,
                  //     child: RoundButton(
                  //       title: "Add Cart",
                  //       type: RoundButtonType.bgGradient,
                  //       fontSize: AppFontSizes.smallDefault,,
                  //       fontWeight: FontWeight.w400,
                  //       onPressed: () {},
                  //     ),
                  //   ),
                  //   style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all<Color?>(null),
                  //   ),
                  // ),
                  const SizedBox(
                    width: 8,
                  )
                ],
              ),
              sizedBox30(),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.90, // Adjust the percentage as needed
                  height: 1.0, // Adjust the height of the line
                  color: Colors.black,
                ),
              ),
              sizedBox12(),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SizedBox(
              //     width: MediaQuery.of(context).size.width * 1,
              //     child: Text(
              //       Languages.of(context)!.NINTextOurCustomerFeedback,
              //       textAlign: TextAlign.start,
              //       style: TextStyle(
              //         color: ThemeManager.themeText,
              //         fontSize: AppFontSizes.largeDefault,
              //         fontFamily: 'Manrope',
              //         fontWeight: FontWeight.w400,
              //         height: 0,
              //         letterSpacing: 0.30,
              //       ),
              //     ),
              //   ),
              // ),
              // // sizedBox12(),
              // FutureBuilder(
              //   future: _futureReview,
              //   builder:
              //       (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return CircularProgressIndicator();
              //     } else if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     } else {
              //       final reviews = snapshot.data!;
              //       final reviewAuthority = reviews['reviewauthority'];
              //       final overallRatings = reviews['overallratings'];
              //       final reviewList = reviews['reviews'];
              //       // debugPrint("fdkmfdklmfn $reviewAuthority");
              //       return Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           // Text('Review Authority: $reviewAuthority'),
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Row(
              //               children: [
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       // width:
              //                       //     MediaQuery.of(context).size.width * 0.8,
              //                       child: Text(
              //                         '${Languages.of(context)!.NINTextOverallRatings}: ${overallRatings.toStringAsFixed(1)}',
              //                         style: TextStyle(
              //                             fontSize: AppFontSizes.largeDefault,
              //                             color: Colors.amber),
              //                       ),
              //                     ),
              //                     Icon(
              //                       Icons.star,
              //                       color: Colors.amber,
              //                     )
              //                   ],
              //                 ),
              //                 Spacer(),
              //                 if (reviewAuthority ==
              //                     true) // Conditionally show button
              //                   ElevatedButton(
              //                     onPressed: () {
              //                       Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                           builder: (context) => AddReviewPage(
              //                               bookId: widget.book['id']),
              //                         ),
              //                       );
              //                       // Handle button press
              //                       // Add your logic here to navigate or perform an action when the button is pressed
              //                     },
              //                     style: ElevatedButton.styleFrom(
              //                       primary: TColor
              //                           .secondaryColor1, // Set the background color to light blue
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(
              //                             25.0), // Set the border radius
              //                       ),
              //                     ),
              //                     child: Text(
              //                         Languages.of(context)!.NINTextRateUs),
              //                   ),
              //               ],
              //             ),
              //           ),
              //           SingleChildScrollView(
              //             scrollDirection: Axis.horizontal,
              //             child: Row(
              //               children: [
              //                 for (final reviewItem in reviewList)
              //                   Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Container(
              //                       padding: const EdgeInsets.all(8.0),
              //                       width: MediaQuery.of(context).size.width *
              //                           0.6, // Adjust the factor as needed
              //                       height: 140.56,
              //                       decoration: ShapeDecoration(
              //                         color: ThemeManager.themelightColor,
              //                         shape: RoundedRectangleBorder(
              //                           borderRadius: BorderRadius.circular(14),
              //                         ),
              //                       ),
              //                       child: Column(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.spaceBetween,
              //                         children: [
              //                           Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               Container(
              //                                 width: 42,
              //                                 height: 41,
              //                                 decoration: ShapeDecoration(
              //                                   color: Color(0xFFD9D9D9),
              //                                   shape: OvalBorder(),
              //                                 ),
              //                               ),
              //                               Text(
              //                                 reviewItem['username'],
              //                                 textAlign: TextAlign.center,
              //                                 style: TextStyle(
              //                                   color: ThemeManager.themeText,
              //                                   fontSize:
              //                                       AppFontSizes.mediumDefault,
              //                                   fontFamily: 'Poppins',
              //                                   fontWeight: FontWeight.w400,
              //                                   height: 0,
              //                                   letterSpacing: 0.28,
              //                                 ),
              //                               )
              //                             ],
              //                           ),
              //                           SizedBox(
              //                             width: 177,
              //                             child: Text(
              //                               reviewItem['comment'],
              //                               style: TextStyle(
              //                                 color: ThemeManager.themeText,
              //                                 fontSize:
              //                                     AppFontSizes.smallDefault,
              //                                 fontFamily: 'Poppins',
              //                                 fontWeight: FontWeight.w400,
              //                                 height: 0,
              //                               ),
              //                             ),
              //                           ),
              //                           Row(
              //                             children: [
              //                               SizedBox(
              //                                 child: Row(
              //                                   children: [
              //                                     Text(
              //                                       " ${reviewItem['rating']}",
              //                                       style: TextStyle(
              //                                         color: Colors.yellow,
              //                                         fontSize: AppFontSizes
              //                                             .largeDefault,
              //                                         fontFamily: 'Poppins',
              //                                         fontWeight:
              //                                             FontWeight.w700,
              //                                         height: 0,
              //                                       ),
              //                                     ),
              //                                     Icon(
              //                                       Icons.star,
              //                                       color: Colors.yellow,
              //                                     )
              //                                   ],
              //                                 ),
              //                               ),
              //                               Spacer(),
              //                               SizedBox(
              //                                 child: Text(
              //                                   reviewItem['date'],
              //                                   style: TextStyle(
              //                                     color: ThemeManager.themeText,
              //                                     fontSize:
              //                                         AppFontSizes.smallDefault,
              //                                     fontStyle: FontStyle.italic,
              //                                     fontFamily: 'Poppins',
              //                                     fontWeight: FontWeight.w300,
              //                                     height: 0,
              //                                   ),
              //                                 ),
              //                               ),
              //                               SizedBox(
              //                                 width: 8,
              //                               )
              //                             ],
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //               ],
              //             ),
              //           )
              //         ],
              //       );
              //     }
              //   },
              // ),
              // sizedBox12(),
              // // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Container(
              //           padding: const EdgeInsets.all(8.0),
              //           width: 210,
              //           height: 140.56,
              //           decoration: ShapeDecoration(
              //             color: ThemeManager.themelightColor,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(14),
              //             ),
              //           ),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Container(
              //                     width: 42,
              //                     height: 41,
              //                     decoration: ShapeDecoration(
              //                       color: Color(0xFFD9D9D9),
              //                       shape: OvalBorder(),
              //                     ),
              //                   ),
              //                   Text(
              //                     'Calvin Harris',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: ThemeManager.themeText,
              //                       fontSize: AppFontSizes.mediumDefault,
              //                       fontFamily: 'Poppins',
              //                       fontWeight: FontWeight.w400,
              //                       height: 0,
              //                       letterSpacing: 0.28,
              //                     ),
              //                   )
              //                 ],
              //               ),
              //               SizedBox(
              //                 width: 177,
              //                 child: Text(
              //                   'Overall, I highly recommend "The Martian" to anyone who enjoys science fiction, suspense, or simply a good story. It is a well-written and engaging book that will keep you entertained from beginning to end.',
              //                   style: TextStyle(
              //                     color: ThemeManager.themeText,
              //                     fontSize: AppFontSizes.mediumDefault.50,
              //                     fontFamily: 'Poppins',
              //                     fontWeight: FontWeight.w400,
              //                     height: 0,
              //                   ),
              //                 ),
              //               ),
              //               Row(
              //                 children: [
              //                   // SizedBox(
              //                   //   width: 8,
              //                   // ),
              //                   SizedBox(
              //                     // width: 48,
              //                     child: Text(
              //                       'Price : ₹400.00',
              //                       style: TextStyle(
              //                         color: Color(0xAAFF1515),
              //                         fontSize: AppFontSizes.smallDefault,,
              //                         fontFamily: 'Poppins',
              //                         fontWeight: FontWeight.w700,
              //                         height: 0,
              //                       ),
              //                     ),
              //                   ),
              //                   Spacer(),
              //                   SizedBox(
              //                     // width: 39,
              //                     child: Text(
              //                       '19th Dec 2023',
              //                       style: TextStyle(
              //                         color: ThemeManager.themeText,
              //                         fontSize: AppFontSizes.smallDefault,,
              //                         fontStyle: FontStyle.italic,
              //                         fontFamily: 'Poppins',
              //                         fontWeight: FontWeight.w300,
              //                         height: 0,
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     width: 8,
              //                   )
              //                 ],
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Container(
              //           padding: const EdgeInsets.all(8.0),
              //           width: 210,
              //           height: 140.56,
              //           decoration: ShapeDecoration(
              //             color: ThemeManager.themelightColor,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(14),
              //             ),
              //           ),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Container(
              //                     width: 42,
              //                     height: 41,
              //                     decoration: ShapeDecoration(
              //                       color: Color(0xFFD9D9D9),
              //                       shape: OvalBorder(),
              //                     ),
              //                   ),
              //                   Text(
              //                     'Make Harris',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: ThemeManager.themeText,
              //                       fontSize: AppFontSizes.mediumDefault,
              //                       fontFamily: 'Poppins',
              //                       fontWeight: FontWeight.w400,
              //                       height: 0,
              //                       letterSpacing: 0.28,
              //                     ),
              //                   )
              //                 ],
              //               ),
              //               SizedBox(
              //                 width: 177,
              //                 child: Text(
              //                   'Overall, I highly recommend "The Martian" to anyone who enjoys science fiction, suspense, or simply a good story. It is a well-written and engaging book that will keep you entertained from beginning to end.',
              //                   style: TextStyle(
              //                     color: ThemeManager.themeText,
              //                     fontSize: AppFontSizes.mediumDefault.50,
              //                     fontFamily: 'Poppins',
              //                     fontWeight: FontWeight.w400,
              //                     height: 0,
              //                   ),
              //                 ),
              //               ),
              //               Row(
              //                 children: [
              //                   // SizedBox(
              //                   //   width: 8,
              //                   // ),
              //                   SizedBox(
              //                     // width: 48,
              //                     child: Text(
              //                       'Price : ₹400.00',
              //                       style: TextStyle(
              //                         color: Color(0xAAFF1515),
              //                         fontSize: AppFontSizes.smallDefault,,
              //                         fontFamily: 'Poppins',
              //                         fontWeight: FontWeight.w700,
              //                         height: 0,
              //                       ),
              //                     ),
              //                   ),
              //                   Spacer(),
              //                   SizedBox(
              //                     // width: 39,
              //                     child: Text(
              //                       '11th Dec 2023',
              //                       style: TextStyle(
              //                         color: ThemeManager.themeText,
              //                         fontSize: AppFontSizes.smallDefault,,
              //                         fontStyle: FontStyle.italic,
              //                         fontFamily: 'Poppins',
              //                         fontWeight: FontWeight.w300,
              //                         height: 0,
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     width: 8,
              //                   )
              //                 ],
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              sizedBox30(),
              // Center(
              //   child: Image.asset(
              //     'assets/images/bookList.png', // Replace with the actual image path
              //     width: 150,
              //     height: 200,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              // SizedBox(height: 16),
              // Text(
              //   book['title'],
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: AppFontSizes.mediumDefault,
              //       color: Colors.black),
              // ),
              // SizedBox(height: 8),
              // Text(
              //   'Author: ${book['author']}',
              //   style: TextStyle(color: Colors.black),
              // ),
              // Text(
              //   'Year: ${book['year']}',
              //   style: TextStyle(color: Colors.black),
              // ),
              // Text(
              //   'Quantity: ${book['quantity']}',
              //   style: TextStyle(color: Colors.black),
              // ),
              // Text(
              //   'Price: \$${book['price']}',
              //   style: TextStyle(color: Colors.black),
              // ),
              // SizedBox(height: 16),
              // Text(
              //   'Description:', // Replace with your book description
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: AppFontSizes.mediumDefault,
              //       color: Colors.black),
              // ),
              // SizedBox(height: 8),
              // Text(
              //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              //   'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
              //   'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
              //   'nisi ut aliquip ex ea commodo consequat.',
              //   style: TextStyle(fontSize: AppFontSizes.mediumDefault, color: Colors.black),
              // ),
              // SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () => _addToCart(context),
              //   child: Text(
              //     'Add to Cart',
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }
}
