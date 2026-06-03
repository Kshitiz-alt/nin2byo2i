import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/constants/server.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/ScreensAPP/BookInDetail.dart';
import 'package:nin2byo2i/view/ScreensAPP/CartForOrder.dart';
import 'package:http/http.dart' as http;
import 'package:nin2byo2i/view/ScreensAPP/OrderHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';

//all books display screen
class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final UserProfileController _controller = UserProfileController();
  List<Map<String, dynamic>> books = [];
  List<Map<String, dynamic>> filteredBooks = [];
  bool isLoading = true;
  bool isDisposed = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBooks();
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

  Future<void> _addToCart(
      BuildContext context, Map<String, dynamic> book) async {
    // Get the book ID
    int bookId = book['id'];
    double price = book['price']?.toDouble() ?? 0.0;

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
  void dispose() {
    isDisposed = true;
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchBooks() async {
    try {
      final data = await _controller.fetchBooks();
      if (!isDisposed) {
        setState(() {
          books = List<Map<String, dynamic>>.from(data);
          debugPrint("kefbnsgfngrk $books");
          filteredBooks = books;
          isLoading = false;
        });
      }
    } catch (error) {
      if (!isDisposed) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: ThemeManager.themelightColor,
              title: Text(
                Languages.of(context)!.error,
                style: TextStyle(color: ThemeManager.themeText),
              ),
              content: Text(
                Languages.of(context)!.failedToFetchBooks,
                style: TextStyle(color: ThemeManager.themeText),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    Languages.of(context)!.ok,
                    style: TextStyle(color: ThemeManager.themeText),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void filterBooks(String query) {
    setState(() {
      filteredBooks = books
          .where((book) =>
              book['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  final String assetImage = 'assets/images/book.png';

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate to the home screen when the back button is pressed
        // else if (value == 'UpdateProfile') {
        Navigator.pushNamed(context, '/root');

        return false; // Prevent the back operation
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ThemeManager.themeColor,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: Image.asset(
                "assets/images/myOrders.png",
                width: 24.0,
                color: ThemeManager.themeText,
                fit: BoxFit.cover,
              ),
              onPressed: () {
                // Navigate to the OrdersPage when the icon is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                );
              },
            ),
            // IconButton(
            //   icon: Image.asset(
            //     "assets/images/cart.png",
            //     width: 24.0, // Set the desired width
            //     // height: 24.0,
            //     color: ThemeManager.themeText,
            //     fit: BoxFit.cover,
            //   ),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => CartPage()),
            //     );
            //   },
            // ),
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
          // leading: InkWell(
          //   onTap: () {
          //     // Navigator.pop(context);
          //     Navigator.pushNamed(context, '/root');
          //   },
          //   child: Container(
          //     margin: const EdgeInsets.all(8),
          //     height: 40,
          //     width: 40,
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //         color: ThemeManager.themelightColor,
          //         borderRadius: BorderRadius.circular(10)),
          //     child: Image.asset(
          //       "assets/img/black_btn.png",
          //       width: 15,
          //       height: 15,
          //       color: ThemeManager.themeText,
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          // ),
          title: Text(
            Languages.of(context)!.labelBookStore,
            style: TextStyle(
              color: ThemeManager.themeText,
            ),
          ),
        ),
        backgroundColor: ThemeManager.themeColor,
        body: isLoading
            ? const CommonDataLoadingScreen()
            : RefreshIndicator(
                color: TColor
                    .secondaryColor1, // Set the color of the refresh indicator
                backgroundColor: TColor.primaryColor1,
                onRefresh: _refresh,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Center(
                                    child: Container(
                                      width: 314,
                                      height: 35.97,
                                      decoration: ShapeDecoration(
                                        color: ThemeManager.themelightColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: TextField(
                                        controller: searchController,
                                        onChanged: (query) =>
                                            filterBooks(query),
                                        decoration: InputDecoration(
                                          hintText: Languages.of(context)!
                                              .labelSearchBooks,
                                          hintStyle: TextStyle(
                                            color: ThemeManager.themeText
                                                .withOpacity(0.8),
                                          ), // Adjust the hint text color and opacity
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: ThemeManager.themeText,
                                          ), // Add a search icon as a prefix
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                            color: ThemeManager.themeText),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              sizedBox12(),
                              for (int i = 0; i < filteredBooks.length; i += 2)
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: ShapeDecoration(
                                            color: ThemeManager.themelightColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            //
                                            children: [
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              InkWell(
                                                  onTap: () async {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookDetailsPage(
                                                                book:
                                                                    filteredBooks[
                                                                        i]),
                                                      ),
                                                    );
                                                    setState(() {
                                                      _getCartItems();
                                                    });
                                                  },
                                                  child: SizedBox(
                                                    width: 120,
                                                    height: 180,
                                                    child: Image.network(
                                                      filteredBooks[i]
                                                          ['imageUrl'],
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          // Image is fully loaded
                                                          return child;
                                                        } else {
                                                          // Image is still loading
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
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
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object error,
                                                              StackTrace?
                                                                  stackTrace) {
                                                        // Error occurred while loading image
                                                        return const Text(
                                                            'Error loading image');
                                                      },
                                                    ),
                                                  )
                                                  // Image.network(
                                                  //     filteredBooks[i]
                                                  //         ['imageUrl'])

                                                  //  Image.network(
                                                  //     "${filteredBooks[i]['imageUrl']}")

                                                  // Container(
                                                  //   width: 71,
                                                  //   height: 95,
                                                  //   child: Image.asset(
                                                  //     assetImage,
                                                  //     width: double.infinity,
                                                  //     fit: BoxFit.cover,
                                                  //     errorBuilder:
                                                  //         (BuildContext context,
                                                  //             Object exception,
                                                  //             StackTrace?
                                                  //                 stackTrace) {
                                                  //       return Image.asset(
                                                  //         'assets/images/fork 2.png',
                                                  //         fit: BoxFit.cover,
                                                  //       );
                                                  //     },
                                                  //   ),
                                                  // ),
                                                  ),
                                              InkWell(
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BookDetailsPage(
                                                              book:
                                                                  filteredBooks[
                                                                      i]),
                                                    ),
                                                  );
                                                  setState(() {
                                                    _getCartItems();
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        // width: 116,
                                                        child: Text(
                                                          filteredBooks[i]
                                                              ['title'],
                                                          style: TextStyle(
                                                            color: ThemeManager
                                                                .themeText,
                                                            fontSize: AppFontSizes
                                                                .smallDefault,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   // width: 116,
                                                      //   child: Row(
                                                      //     children: [
                                                      //       Text(
                                                      //         "${Languages.of(context)!.TextAppRatings} ",
                                                      //         style: TextStyle(
                                                      //           color: ThemeManager
                                                      //               .themeText,
                                                      //           fontSize:
                                                      //               AppFontSizes
                                                      //                   .smallDefault,
                                                      //           fontFamily:
                                                      //               'Poppins',
                                                      //           fontWeight:
                                                      //               FontWeight
                                                      //                   .w400,
                                                      //           height: 0,
                                                      //         ),
                                                      //       ),
                                                      //       Text(
                                                      //         filteredBooks[i][
                                                      //                 'ratings']
                                                      //             .toStringAsFixed(
                                                      //                 1),
                                                      //         style: TextStyle(
                                                      //           color: Colors
                                                      //               .amber,
                                                      //           fontSize:
                                                      //               AppFontSizes
                                                      //                   .largeDefault,
                                                      //           fontFamily:
                                                      //               'Poppins',
                                                      //           fontWeight:
                                                      //               FontWeight
                                                      //                   .bold,
                                                      //           height: 0,
                                                      //         ),
                                                      //       ),
                                                      //       Icon(
                                                      //         Icons.star,
                                                      //         color:
                                                      //             Colors.yellow,
                                                      //         size: 20.0,
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // // Row(
                                                      //   mainAxisAlignment:
                                                      //       MainAxisAlignment
                                                      //           .start,
                                                      //   children: [
                                                      //     // Display 4 stars
                                                      //     for (int i = 0;
                                                      //         i < 4;
                                                      //         i++)
                                                      //       Icon(
                                                      //         Icons.star,
                                                      //         color:
                                                      //             Colors.yellow,
                                                      //         size: 20.0,
                                                      //       ),

                                                      //     // Display half star for 4.5 rating
                                                      //     Icon(
                                                      //       Icons.star_half,
                                                      //       color:
                                                      //           Colors.yellow,
                                                      //       size: 20.0,
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                      Row(
                                                        children: [
                                                          // SizedBox(
                                                          //   width: 8,
                                                          // ),
                                                          SizedBox(
                                                            // width: 48,
                                                            child: Text(
                                                              '${Languages.of(context)!.labelPrice} : ₹${filteredBooks[i]['price'].toStringAsFixed(1)}',
                                                              style: const TextStyle(
                                                                color: Color(
                                                                    0xAAFF1515),
                                                                fontSize:
                                                                    AppFontSizes
                                                                        .mediumDefault,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                height: 0,
                                                              ),
                                                            ),
                                                          ),

                                                          const SizedBox(
                                                            width: 8,
                                                          )
                                                        ],
                                                      ),
                                                      // Spacer(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if (((double.tryParse(filteredBooks[
                                                                  i]['quantity']
                                                              .toString()) ??
                                                          0.0)
                                                      .toInt()) >
                                                  5)
                                                SizedBox(
                                                  width: 120,
                                                  // height: 30,
                                                  child: RoundButton(
                                                    title:
                                                        Languages.of(context)!
                                                            .labelAddToCart,
                                                    type: RoundButtonType
                                                        .bgGradient,
                                                    fontSize: AppFontSizes
                                                        .mediumDefault,
                                                    fontWeight: FontWeight.w400,
                                                    onPressed: () => _addToCart(
                                                        context,
                                                        filteredBooks[i]),
                                                    // () {
                                                    //   // _addToCart(context,
                                                    //   //     filteredBooks[i]);
                                                    // },
                                                  ),
                                                )
                                              else
                                                SizedBox(
                                                  width: 120,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      gradient: const LinearGradient(
                                                        colors: [
                                                          Color.fromARGB(255,
                                                              117, 115, 116),
                                                          Color.fromARGB(255,
                                                              117, 115, 116),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.black26,
                                                          blurRadius: 4.0,
                                                          offset: Offset(0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Text(
                                                          "Out of Stock",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: AppFontSizes
                                                                .mediumDefault,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              sizedBox12()
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        if (i + 1 < filteredBooks.length)
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: ShapeDecoration(
                                              color:
                                                  ThemeManager.themelightColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              //
                                              children: [
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookDetailsPage(
                                                                book:
                                                                    filteredBooks[
                                                                        i + 1]),
                                                      ),
                                                    );
                                                    setState(() {
                                                      _getCartItems();
                                                    });
                                                  },
                                                  child: SizedBox(
                                                      width: 120,
                                                      height: 180,
                                                      child: Image.network(
                                                        filteredBooks[i + 1]
                                                            ['imageUrl'],
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent?
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            // Image is fully loaded
                                                            return child;
                                                          } else {
                                                            // Image is still loading
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
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
                                                        errorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Object error,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          // Error occurred while loading image
                                                          return const Text(
                                                              'Error loading image');
                                                        },
                                                      )),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BookDetailsPage(
                                                                book:
                                                                    filteredBooks[
                                                                        i + 1]),
                                                      ),
                                                    );
                                                    setState(() {
                                                      _getCartItems();
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          // width: 116,
                                                          child: Text(
                                                            filteredBooks[i + 1]
                                                                ['title'],
                                                            style: TextStyle(
                                                              color: ThemeManager
                                                                  .themeText,
                                                              fontSize: AppFontSizes
                                                                  .smallDefault,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ),
                                                        // SizedBox(
                                                        //   // width: 116,
                                                        //   child: Row(
                                                        //     children: [
                                                        //       Text(
                                                        //         "Ratings ",
                                                        //         style:
                                                        //             TextStyle(
                                                        //           color: ThemeManager
                                                        //               .themeText,
                                                        //           fontSize:
                                                        //               AppFontSizes
                                                        //                   .smallDefault,
                                                        //           fontFamily:
                                                        //               'Poppins',
                                                        //           fontWeight:
                                                        //               FontWeight
                                                        //                   .w400,
                                                        //           height: 0,
                                                        //         ),
                                                        //       ),
                                                        //       Text(
                                                        //         filteredBooks[i +
                                                        //                     1][
                                                        //                 'ratings']
                                                        //             .toStringAsFixed(
                                                        //                 1),
                                                        //         style:
                                                        //             const TextStyle(
                                                        //           color: Colors
                                                        //               .amber,
                                                        //           fontSize:
                                                        //               AppFontSizes
                                                        //                   .largeDefault,
                                                        //           fontFamily:
                                                        //               'Poppins',
                                                        //           fontWeight:
                                                        //               FontWeight
                                                        //                   .bold,
                                                        //           height: 0,
                                                        //         ),
                                                        //       ),
                                                        //       const Icon(
                                                        //         Icons.star,
                                                        //         color: Colors
                                                        //             .yellow,
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
                                                                '${Languages.of(context)!.labelPrice} : ₹${filteredBooks[i + 1]['price'].toStringAsFixed(1)}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xAAFF1515),
                                                                  fontSize:
                                                                      AppFontSizes
                                                                          .mediumDefault,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  height: 0,
                                                                ),
                                                              ),
                                                            ),

                                                            const SizedBox(
                                                              width: 8,
                                                            )
                                                          ],
                                                        ),
                                                        // Spacer(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                if (((double.tryParse(filteredBooks[
                                                                        i + 1]
                                                                    ['quantity']
                                                                .toString()) ??
                                                            0.0)
                                                        .toInt()) >
                                                    5)
                                                  SizedBox(
                                                    width: 120,
                                                    // height: 30,
                                                    child: RoundButton(
                                                      title:
                                                          Languages.of(context)!
                                                              .labelAddToCart,
                                                      type: RoundButtonType
                                                          .bgGradient,
                                                      fontSize: AppFontSizes
                                                          .mediumDefault,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      onPressed: () =>
                                                          _addToCart(
                                                              context,
                                                              filteredBooks[
                                                                  i + 1]),
                                                    ),
                                                  )
                                                else
                                                  SizedBox(
                                                    width: 120,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                117, 115, 116),
                                                            Color.fromARGB(255,
                                                                117, 115, 116),
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black26,
                                                            blurRadius: 4.0,
                                                            offset:
                                                                Offset(0, 2),
                                                          ),
                                                        ],
                                                      ),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                          child: Text(
                                                            "Out of Stock",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: AppFontSizes
                                                                  .mediumDefault,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                sizedBox12()
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                    sizedBox12()
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: GridView.builder(
                    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2,
                    //         crossAxisSpacing: 8.0,
                    //         mainAxisSpacing: 8.0,
                    //       ),
                    //       itemCount: filteredBooks.length,
                    //       itemBuilder: (context, index) {
                    //         var book = filteredBooks[index];
                    //         return Container(
                    //           width: 140,
                    //           height: 300.56,
                    //           decoration: ShapeDecoration(
                    //             color: ThemeManager.themelightColor,
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(14),
                    //             ),
                    //           ),
                    //           child: Column(
                    //             children: [
                    //               InkWell(
                    //                 onTap: () {
                    //                   Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                       builder: (context) =>
                    //                           BookDetailsPage(book: book),
                    //                     ),
                    //                   );
                    //                 },
                    //                 child: Container(
                    //                   width: 71,
                    //                   height: 95,
                    //                   child: Image.asset(
                    //                     assetImage,
                    //                     width: double.infinity,
                    //                     fit: BoxFit.cover,
                    //                     errorBuilder: (BuildContext context,
                    //                         Object exception,
                    //                         StackTrace? stackTrace) {
                    //                       return Image.asset(
                    //                         'assets/images/fork 2.png',
                    //                         fit: BoxFit.cover,
                    //                       );
                    //                     },
                    //                   ),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Column(
                    //                   mainAxisAlignment: MainAxisAlignment.start,
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     SizedBox(
                    //                       width: 116,
                    //                       child: Text(
                    //                         book['title'],
                    //                         style: TextStyle(
                    //                           color: ThemeManager.themeText,
                    //                           fontSize: 5.50,
                    //                           fontFamily: 'Poppins',
                    //                           fontWeight: FontWeight.w400,
                    //                           height: 0,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.start,
                    //                       children: [
                    //                         // Display 4 stars
                    //                         for (int i = 0; i < 4; i++)
                    //                           Icon(
                    //                             Icons.star,
                    //                             color: Colors.yellow,
                    //                             size: 20.0,
                    //                           ),

                    //                         // Display half star for 4.5 rating
                    //                         Icon(
                    //                           Icons.star_half,
                    //                           color: Colors.yellow,
                    //                           size: 20.0,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     Row(
                    //                       children: [
                    //                         // SizedBox(
                    //                         //   width: 8,
                    //                         // ),
                    //                         SizedBox(
                    //                           // width: 48,
                    //                           child: Text(
                    //                             'Price : ₹${book['price']}',
                    //                             style: TextStyle(
                    //                               color: Color(0xAAFF1515),
                    //                               fontSize: 9,
                    //                               fontFamily: 'Poppins',
                    //                               fontWeight: FontWeight.w700,
                    //                               height: 0,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                         Spacer(),
                    //                         SizedBox(
                    //                           width: 80,
                    //                           height: 25,
                    //                           child: RoundButton(
                    //                             title: "Add Cart",
                    //                             type: RoundButtonType.bgGradient,
                    //                             fontSize: AppFontSizes.mediumDefault,
                    //                             fontWeight: FontWeight.w400,
                    //                             onPressed: () {},
                    //                           ),
                    //                         ),
                    //                         SizedBox(
                    //                           width: 8,
                    //                         )
                    //                       ],
                    //                     )
                    //                   ],
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         );
                    //         // GestureDetector(
                    //         //   onTap: () {
                    //         //     Navigator.push(
                    //         //       context,
                    //         //       MaterialPageRoute(
                    //         //         builder: (context) => BookDetailsPage(book: book),
                    //         //       ),
                    //         //     );
                    //         //   },
                    //         //   child: Card(
                    //         //     shadowColor: Colors.black,
                    //         //     elevation: 4,
                    //         //     child: Container(
                    //         //       color: ThemeManager.themeColor,
                    //         //       child: Column(
                    //         //         children: [
                    //         //           Expanded(
                    //         //             child: Image.asset(
                    //         //               assetImage,
                    //         //               width: double.infinity,
                    //         //               fit: BoxFit.cover,
                    //         //               errorBuilder: (BuildContext context,
                    //         //                   Object exception,
                    //         //                   StackTrace? stackTrace) {
                    //         //                 return Image.asset(
                    //         //                   'assets/item.png',
                    //         //                   fit: BoxFit.cover,
                    //         //                 );
                    //         //               },
                    //         //             ),
                    //         //           ),
                    //         //           Padding(
                    //         //             padding: const EdgeInsets.all(8.0),
                    //         //             child: Column(
                    //         //               crossAxisAlignment:
                    //         //                   CrossAxisAlignment.start,
                    //         //               children: [
                    //         //                 Text(
                    //         //                   '${book['title']}',
                    //         //                   style: TextStyle(
                    //         //                       color: Colors.black),
                    //         //                 ),
                    //         //                 Text(
                    //         //                   'Price: ${book['price']}',
                    //         //                   style: TextStyle(
                    //         //                       color: Colors.black),
                    //         //                 ),
                    //         //                 Row(
                    //         //                   children: [
                    //         //                     Icon(Icons.star,
                    //         //                         color: Colors.yellow),
                    //         //                     Text(
                    //         //                       "4.2",
                    //         //                       style: TextStyle(
                    //         //                           color: Colors.black),
                    //         //                     ),
                    //         //                   ],
                    //         //                 ),
                    //         //               ],
                    //         //             ),
                    //         //           ),
                    //         //         ],
                    //         //       ),
                    //         //     ),
                    //         //   ),
                    //         // );
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
      ),
    );
  }
}
