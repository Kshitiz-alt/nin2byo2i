import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/Repository/auth_repo.dart';
import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/ScreensAPP/ListOfAllBooks.dart';
import 'package:nin2byo2i/view/ScreensAPP/OrderHistory.dart';
import 'package:nin2byo2i/view/ScreensAPP/RozarPayPayment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nin2byo2i/constants/server.dart';

//cart page for book system
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

bool isLoadingScreenCheck = true;

class _CartPageState extends State<CartPage> {
  bool isSecondPageOpen = false;
  final UserProfileController _controller = UserProfileController();

  Map<int, String> bookNames = {};
  Map<int, String> bookImages = {};
  Map<int, int> bookQuantities = {};
  Map<int, double> bookPrice = {};

  double totalPrice = 0.0;
  double deliveryCharge = 0.0;
  double processingCharge = 0.0;
  double finalTotalAmount = 0.0;
  @override
  void initState() {
    super.initState();
    _getCartItems();
  }

  Future<void> fetchAmounts() async {
    // };
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    const String url =
        'https://apis.nutrifyindianow.in/api/booktables/getBooksByIds';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cartItems') ?? [];
    String requestBody = cartItems.join(',');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: requestBody, //cartItems
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("fgbfnbfjbmngfkbngm $data");
        setState(() {
          totalPrice = (data['totalPrice'] as num?)?.toDouble() ?? 0.0;
          deliveryCharge = (data['deliveryCharge'] as num?)?.toDouble() ?? 0.0;
          processingCharge =
              (data['processingCharge'] as num?)?.toDouble() ?? 0.0;
          finalTotalAmount =
              (data['finalTotalAmount'] as num?)?.toDouble() ?? 0.0;
        });
      } else {
        debugPrint("fgbfnbfjbmngfkbngm jj $requestBody ${response.body}");
        throw Exception('Failed to load data');
      }
    } catch (error) {
      debugPrint('Error: $error');
    }
  }

  List<String> cartItems = [];
  late Map<String, dynamic> OredrIdRozarPay;

  Future<void> _getCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cartItems = prefs.getStringList('cartItems') ?? [];
      debugPrint("Order cart ids first fetch $cartItems ");
    });
    await _fetchBookDetails();
    await fetchAmounts();
  }

  Future<void> _fetchBookDetails() async {
    // Extract the list of book IDs
    List<int> bookIds =
        cartItems.map((item) => int.parse(item.split('x')[0])).toList();

    // Prepare the request body as a JSON array
    // Map<String, dynamic> requestBody = {

    // };
    String? token = await AuthRepo.getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Auth': 'Bearer $token', // Use 'Authorization' instead of 'Auth'
    };
    // Convert the request body to a JSON string
    String requestBodyJson = json.encode(bookIds);
    debugPrint("book ids with q $cartItems");
    // Make an API request to get book details based on the book IDs
    final bookDetailsResponse = await http.post(
      Uri.parse('${API.server}/UserbookBuy/getMultipleBooks'),
      // Add any required headers here
      headers: headers,
      // Pass the request body
      body: requestBodyJson,
    );

    if (bookDetailsResponse.statusCode == 200) {
      // Parse the response
      debugPrint("data after api call is here ${bookDetailsResponse.body}");
      List<dynamic> bookDetailsList = json.decode(bookDetailsResponse.body);

      // Loop through the list of book details
      for (var bookDetails in bookDetailsList) {
        debugPrint("fdghgfgfhfghghjhg $bookDetails['imageFilename']");
        int bookId = bookDetails['id'];
        String bookName = bookDetails['title'];
        String bookImage = bookDetails['imageFilename'];
        debugPrint("fdghgfjhg $bookImage");
        bookImages[bookId] = bookImage;
        debugPrint("fdghgjhgyjghkghjfjhg $bookImages");
        int quantity = bookDetails['quantity'] ?? 0;
        double price = (bookDetails['price'] as num?)?.toDouble() ?? 0.0;

        bookNames[bookId] = bookName;
        bookQuantities[bookId] = quantity;
        // bookImages[bookId] = bookImage;
        // debugPrint("fdghgjhgyjghkghjfjhg $bookImages");
        bookPrice[bookId] = price;
      }

      // Update the state to trigger a rebuild with book names
      setState(() {
        isLoadingScreenCheck = false;
      });
    } else {
      // Handle error (you may want to show an error message)
      debugPrint("Error fetching book details for book IDs: $bookIds");
    }
  }

  Future<void> _updateQuantity(int index, int change) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedCartItems = List.from(cartItems);
    String item = cartItems[index];

    List<String> parts = item.split('x');
    int bookId = int.parse(parts[0]);
    int quantity = int.parse(parts[1]);
    double price = parts.length > 2 ? double.parse(parts[2]) : 0.0;

    // Check if the new quantity is within the available limit
    int availableQuantity = bookQuantities[bookId] ?? 0;
    int updatedQuantity = quantity + change;
    if (updatedQuantity < 1 ||
        updatedQuantity > availableQuantity ||
        updatedQuantity > 2) {
      // Display an error message or take appropriate action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: TColor.secondaryColor1,
          content: Text(Languages.of(context)!.quantityNotBetween1And2),
          duration: const Duration(milliseconds: 1500),
        ),
      );
      debugPrint('Invalid quantity');
      return;
    }

    quantity += change;

    updatedCartItems[index] = '${bookId}x$quantity${price > 0 ? 'x$price' : ''}';

    prefs.setStringList('cartItems', updatedCartItems);
    await fetchAmounts();
    setState(() {
      cartItems = updatedCartItems;

      debugPrint("Order cart ids $cartItems ");
    });
  }

  Future<void> _removeItem(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedCartItems = List.from(cartItems);

    updatedCartItems.removeAt(index);

    prefs.setStringList('cartItems', updatedCartItems);

    setState(() {
      cartItems = updatedCartItems;
      fetchAmounts();
    });
  }

  Future<void> _checkout() async {
    // Prepare the cart data for API
    if (!isSecondPageOpen) {
      // Set the flag to true to indicate that SecondPage is open
      setState(() {
        isSecondPageOpen = true;
      });
      
      // Extract only bookId and quantity for API (remove price)
      List<String> cartDataForAPI = cartItems.map((item) {
        List<String> parts = item.split('x');
        return '${parts[0]}x${parts[1]}'; // Only bookId x quantity
      }).toList();
      
      Map<String, dynamic> cartData = {
        "cart": cartDataForAPI,
      };
      final data = await _controller.SendCartAndGEtOrderID(cartData);
      if (mounted) {
        debugPrint("Order id is $cartData ");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPage(paymentData: data),
          ),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PaymentPage(paymentData: data),
        //   ),
        // );
        debugPrint("Order id is $data ");
      }
      debugPrint("Order cart ids $cartData ");
      setState(() {
        isSecondPageOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalCartPrice = 0;
    for (var index = 0; index < cartItems.length; index++) {
      List<String> parts = cartItems[index].split('x');
      int bookId = int.parse(parts[0]);
      int quantity = int.parse(parts[1]);
      double price = parts.length > 2 ? double.parse(parts[2]) : (bookPrice[bookId] ?? 0);
      totalCartPrice += quantity * price;
    }
    return isLoadingScreenCheck
        ? const CommonDataLoadingScreen()
        : Scaffold(
            // appBar: AppBar(
            //   title: Text('Cart'),
            // ),
            appBar: AppBar(
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
                      MaterialPageRoute(
                          builder: (context) => OrderHistoryPage()),
                    );
                  },
                ),
              ],
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
                Languages.of(context)!.labelCart,
                style: TextStyle(
                    color: ThemeManager.themeText,
                    fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.w700),
              ),
            ),
            backgroundColor: ThemeManager.themeColor,
            body: cartItems.isEmpty
                ? Center(
                    child: Text(
                      '${Languages.of(context)!.ninTextCartIsEmpty}.',
                      style: const TextStyle(
                        fontSize: AppFontSizes.mediumDefault,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  sizedBox30(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      Languages.of(context)!
                                          .labelItemsInMyOrders,
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
                                      '${cartItems.length} ${Languages.of(context)!.labelItemsInMyOrders}',
                                      style: TextStyle(
                                        color: ThemeManager.themeText,
                                        fontSize: AppFontSizes.smallDefault,
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 0.14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  debugPrint("fcdsgdsfgdfh $cartItems");

                                  List<String> parts = cartItems[index].split('x');
                                  int bookId = int.parse(parts[0]);
                                  int quantity = int.parse(parts[1]);
                                  double price = parts.length > 2 ? double.parse(parts[2]) : (bookPrice[bookId] ?? 0);
                                  String bookName =
                                      bookNames[bookId] ?? 'Unknown Book';
                                  String bookImage0 =
                                      bookImages[bookId] ?? 'Unknown Book';
                                  debugPrint(
                                      "${API.server}/images/$bookImage0 $bookImages");
                                  double totalPrice = quantity * price;

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5))),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: 90,
                                              height: 90,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                              ),
                                              child: Image.network(
                                                "${API.server}/images/$bookImage0",
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
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
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object error,
                                                    StackTrace? stackTrace) {
                                                  // Error occurred while loading image
                                                  return const Text(
                                                      'Error loading image');
                                                },
                                              )),
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: 156,
                                                child: Text(
                                                  bookName,
                                                  style: TextStyle(
                                                    color:
                                                        ThemeManager.themeText,
                                                    fontSize: AppFontSizes
                                                        .mediumDefault,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.remove,
                                                      color: ThemeManager
                                                          .themeText,
                                                    ),
                                                    onPressed: () =>
                                                        _updateQuantity(
                                                            index, -1),
                                                  ),
                                                  // Add some spacing between the icons and the value
                                                  // Text(
                                                  //   '10', // Replace this with your actual value
                                                  //   style: TextStyle(fontSize: AppFontSizes.mediumDefault),
                                                  // ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    '$quantity',
                                                    style: TextStyle(
                                                      fontSize: AppFontSizes
                                                          .mediumDefault,
                                                      color: ThemeManager
                                                          .themeText,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: ThemeManager
                                                          .themeText,
                                                    ),
                                                    onPressed: () =>
                                                        _updateQuantity(
                                                            index, 1),
                                                  ), // Add some spacing between the value and the next icon
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () =>
                                                    _removeItem(index),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              Text(
                                                '${Languages.of(context)!.labelTotal}: ₹$totalPrice',
                                                style: TextStyle(
                                                  fontSize:
                                                      AppFontSizes.smallDefault,
                                                  color: ThemeManager.themeText,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );

                                  // Card(
                                  //   color: Colors.lightBlue[50],
                                  //   margin:
                                  //       EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text(
                                  //           'Book name: $bookName',
                                  //           style: TextStyle(
                                  //             fontSize: AppFontSizes.mediumDefault.0,
                                  //             fontWeight: FontWeight.bold,
                                  //             color: Colors.black,
                                  //           ),
                                  //         ),
                                  //         Text(
                                  //           'Price: \₹$price',
                                  //           style: TextStyle(
                                  //             fontSize: AppFontSizes.mediumDefault.0,
                                  //             color: Colors.blue,
                                  //           ),
                                  //         ),
                                  //         Row(
                                  //           children: [
                                  //             IconButton(
                                  //               icon: Icon(
                                  //                 Icons.remove,
                                  //                 color: Colors.red,
                                  //               ),
                                  //               onPressed: () => _updateQuantity(index, -1),
                                  //             ),
                                  //             Text(
                                  //               'Quantity: $quantity',
                                  //               style: TextStyle(
                                  //                 fontSize: AppFontSizes.mediumDefault.0,
                                  //                 color: Colors.green,
                                  //               ),
                                  //             ),
                                  //             IconButton(
                                  //               icon: Icon(
                                  //                 Icons.add,
                                  //                 color: Colors.blue,
                                  //               ),
                                  //               onPressed: () => _updateQuantity(index, 1),
                                  //             ),
                                  //             Spacer(),
                                  //             Text(
                                  //               'Total: \₹$totalPrice',
                                  //               style: TextStyle(
                                  //                 fontSize: AppFontSizes.mediumDefault.0,
                                  //                 color: Colors.red,
                                  //               ),
                                  //             ),
                                  //             IconButton(
                                  //               icon: Icon(
                                  //                 Icons.delete,
                                  //                 color: Colors.red,
                                  //               ),
                                  //               onPressed: () => _removeItem(index),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Total Price: ',
                                                style: TextStyle(
                                                  fontSize: AppFontSizes
                                                      .mediumDefault,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Spacer(), // Spacer between text and price
                                              Text(
                                                '\₹${totalPrice.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontSize: AppFontSizes
                                                      .mediumDefault,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                'Delivery Charge: ',
                                                style: TextStyle(
                                                  fontSize: AppFontSizes
                                                      .mediumDefault,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              Spacer(), // Spacer between text and price
                                              Text(
                                                '\₹${deliveryCharge.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontSize: AppFontSizes
                                                      .mediumDefault,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                'Processing Charge: ',
                                                style: TextStyle(
                                                  fontSize: AppFontSizes
                                                      .mediumDefault,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              Spacer(), // Spacer between text and price
                                              Text(
                                                '\₹${processingCharge.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontSize: AppFontSizes
                                                      .mediumDefault,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Divider(
                                              color: Colors
                                                  .grey), // A separator for visual clarity
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                'Final Total Amount: ',
                                                style: TextStyle(
                                                  fontSize: AppFontSizes
                                                      .mediumDefault,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors
                                                      .green, // Green for the final total
                                                ),
                                              ),
                                              Spacer(), // Spacer between text and price
                                              Text(
                                                '\₹${finalTotalAmount.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontSize: AppFontSizes
                                                      .mediumDefault,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.5))),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 158,
                                        child: Text(
                                          '${Languages.of(context)!.labelTotalPrice} :  ₹${finalTotalAmount.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: Color(0xAAFF1515),
                                            fontSize:
                                                AppFontSizes.mediumDefault,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: _checkout,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: TColor
                                              .secondaryColor1, // Set the background color to light blue
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                25.0), // Set the border radius
                                          ),
                                        ),
                                        child: Text(Languages.of(context)!
                                            .labelCheckout),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     border: Border(
                      //         bottom:
                      //             BorderSide(color: Colors.grey.withOpacity(0.5))),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       SizedBox(
                      //         width: 158,
                      //         child: Text(
                      //           'Total Price :  ₹$totalCartPrice',
                      //           style: TextStyle(
                      //             color: Color(0xAAFF1515),
                      //             fontSize: AppFontSizes.mediumDefault,
                      //             fontFamily: 'Poppins',
                      //             fontWeight: FontWeight.w700,
                      //             height: 0,
                      //           ),
                      //         ),
                      //       ),
                      //       ElevatedButton(
                      //         onPressed: _checkout,
                      //         style: ElevatedButton.styleFrom(
                      //           primary: const Color.fromARGB(255, 106, 193,
                      //               233), // Set the background color to light blue
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(
                      //                 20.0), // Set the border radius
                      //           ),
                      //         ),
                      //         child: Text('Checkout'),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Text(
                      //   'Total \₹$totalCartPrice',
                      //   style: TextStyle(
                      //     fontSize: AppFontSizes.mediumDefault.0,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.green,
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: ElevatedButton(
                      //     onPressed: _checkout,
                      //     style: ElevatedButton.styleFrom(
                      //       primary: Colors.blue, // Background color
                      //       foregroundColor: Colors.white, // Text color
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 16, vertical: 12), // Padding
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8), // BorderRadius
                      //       ),
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Icon(Icons.payment),
                      //         SizedBox(width: 8), // Add spacing between icon and text
                      //         Text(
                      //           "Checkout",
                      //           style: TextStyle(
                      //             fontSize: AppFontSizes.mediumDefault.0,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),

            // floatingActionButton: FloatingActionButton.extended(
            //   onPressed: _checkout,
            //   label: Text(
            //     "Checkout",
            //     style: TextStyle(
            //       fontSize: AppFontSizes.mediumDefault.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   icon: Icon(Icons.payment),
            //   backgroundColor: Colors.blue,
            // ),
          );
  }
}
