import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/ScreensAPP/CartForOrder.dart';
import 'package:nin2byo2i/view/ScreensAPP/OrderHistory.dart';
import 'package:nin2byo2i/view/ScreensAPP/PaymentSuccessPage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

//payment page and sddress filling page
class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> paymentData;

  const PaymentPage({super.key, required this.paymentData});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  final TextEditingController _amountController = TextEditingController();
  final UserProfileController _controller = UserProfileController();
  String recipientName = '';
  // String email = '';
  String Landmark = '';
  String address = '';
  String locality = '';
  String phoneNumnber = '';
  String pinCode = '';
  String landmark = '';
  String city = '';
  String state = '';
  List<String> states = [
    // Indian States
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',

    // Union Territories
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi (NCT)',
    'Jammu & Kashmir',
    'Ladakh',
    'Lakshadweep',
    'Puducherry'
  ];

  // List<String> cities = [
  //   'Agra',
  //   'Ahmedabad',
  //   'Ajmer',
  //   'Aligarh',
  //   'Allahabad (Prayagraj)',
  //   'Amritsar',
  //   'Aurangabad',
  //   'Bangalore (Bengaluru)',
  //   'Bareilly',
  //   'Bhopal',
  //   'Bhubaneswar',
  //   'Chandigarh',
  //   'Chennai',
  //   'Coimbatore',
  //   'Dehradun',
  //   'Delhi',
  //   'Dhanbad',
  //   'Durgapur',
  //   'Faridabad',
  //   'Ghaziabad',
  //   'Goa',
  //   'Gorakhpur',
  //   'Guntur',
  //   'Gurgaon',
  //   'Guwahati',
  //   'Gwalior',
  //   'Hyderabad',
  //   'Indore',
  //   'Jabalpur',
  //   'Jaipur',
  //   'Jalandhar',
  //   'Jammu',
  //   'Jodhpur',
  //   'Kanpur',
  //   'Kochi',
  //   'Kolkata',
  //   'Kota',
  //   'Kozhikode',
  //   'Lucknow',
  //   'Ludhiana',
  //   'Madurai',
  //   'Meerut',
  //   'Mysore',
  //   'Nagpur',
  //   'Nashik',
  //   'Noida',
  //   'Patna',
  //   'Pimpri-Chinchwad',
  //   'Pune',
  //   'Raipur',
  //   'Rajkot',
  //   'Ranchi',
  //   'Salem',
  //   'Shimla',
  //   'Srinagar',
  //   'Surat',
  //   'Thane',
  //   'Thiruvananthapuram',
  //   'Tiruchirappalli',
  //   'Tirupati',
  //   'Udaipur',
  //   'Vadodara',
  //   'Varanasi',
  //   'Vellore',
  //   'Vijayawada',
  //   'Visakhapatnam',
  //   'Warangal'
  // ];

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Map<String, dynamic> paymentData = {
      "paymentId": "${response.paymentId}",
      "amount": int.parse(widget.paymentData['razorPay']['applicationFee']),
    };
    debugPrint("Payment Succbhhhbhess: ${response.data}");
    try {
      final data = await _controller.ValidatePayment(paymentData);

      // Handle successful response or further processing if needed
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Delete the 'cartItems' key
      prefs.remove('cartItems');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle the exception and show an alert box
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
              "${Languages.of(context)!.errorOccurred}$error",
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

    // Handle payment success
    debugPrint("Payment Success: ${response.paymentId}");
    // You can navigate to a success page or perform other actions
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _isLoading = false;
    });
    // Handle payment failure
    debugPrint("Payment Error: ${response.message}");
    // You can show an error message or perform other actions
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      _isLoading = false;
    });
    // Handle external wallet payments
    debugPrint("External Wallet: ${response.walletName}");
    // You can perform actions for external wallet payments
  }

  void _startPayment() {
    setState(() {
      _isLoading = true;
    });
    var options = {
      'key': widget.paymentData['razorPay']['secretKey'],
      'amount': int.parse(widget.paymentData['razorPay']['applicationFee']),
      'name': widget.paymentData['razorPay']['merchantName'],
      'description': widget.paymentData['razorPay']['purchaseDescription'],
      'prefill': {
        'contact': '',
        'email': widget.paymentData['razorPay']['customerEmail'],
      },
      'external': {
        'wallets': ['paytm'],
      },
      'notes': {
        'razorpayOrderId': widget.paymentData['razorPay']['razorpayOrderId'],
        'OrderIdNIN': widget.paymentData['razorPay']['notes'],
        'userEmail': widget.paymentData['razorPay']['customerEmail'],
        'address':
            "$address ,City : $city ,State : $state,PinCode: $pinCode, Landmark: $landmark ",
        'Contact': phoneNumnber,
        'recipientName': recipientName
      },
    };

    try {
      debugPrint(
          "amount is ${int.parse(widget.paymentData['razorPay']['applicationFee'])}");
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error in starting Razorpay payment: $e");
    }
  }

  bool _validateForm() {
    // Regular expression to match exactly 10 digits
    final RegExp phoneRegex = RegExp(r'^\d{10}$');
    // Regular expression to match exactly 6 digits
    final RegExp pinCodeRegex = RegExp(r'^\d{6}$');

    return address.isNotEmpty &&
        locality.isNotEmpty &&
        phoneRegex.hasMatch(phoneNumnber) &&
        pinCodeRegex.hasMatch(pinCode) &&
        city.isNotEmpty &&
        state.isNotEmpty;
  }

// Function to show validation error
  void _showValidationError() {
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
            Languages.of(context)!.pleaseEnterValidValuesForAllFields,
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

  @override
  Widget build(BuildContext context) {
    String amount = widget.paymentData['razorPay']['applicationFee'].substring(
        0, widget.paymentData['razorPay']['applicationFee'].length - 2);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: ThemeManager.themeColor,
            centerTitle: true,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                height: MediaQuery.of(context).size.width * 0.1,
                width: MediaQuery.of(context).size.width * 0.1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ThemeManager.themelightColor,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.025),
                ),
                child: Image.asset(
                  "assets/img/black_btn.png",
                  color: ThemeManager.themeText,
                  width: MediaQuery.of(context).size.width * 0.0375,
                  height: MediaQuery.of(context).size.width * 0.0375,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: Text(
              " Check and Pay",
              style: TextStyle(
                  color: ThemeManager.themeText,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w700),
            ),
          ),
          backgroundColor: ThemeManager.themeColor,
          body: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        'Add a new address',
                        style: TextStyle(
                          color: ThemeManager.themeText,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.05,
                      decoration: ShapeDecoration(
                        color: const Color(0xAA15B8FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.115),
                        ),
                      ),
                      child: Icon(
                        Icons.star,
                        color: ThemeManager.themeText,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.0075,
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: ShapeDecoration(
                    color: ThemeManager.themelightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.012),
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        recipientName = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      filled: true,
                      labelStyle: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.mediumDefault,
                      ),
                      hintStyle: TextStyle(
                        color: ThemeManager.themeText,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeManager.themeText,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeManager.themeText,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: ThemeManager.themeText,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.025),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: ShapeDecoration(
                    color: ThemeManager.themelightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.012),
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        phoneNumnber = value;
                      });
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      filled: true,
                      labelStyle: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.mediumDefault,
                      ),
                      hintStyle: TextStyle(
                        color: ThemeManager.themeText,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeManager.themeText,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeManager.themeText,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: ThemeManager.themeText,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.025),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: ShapeDecoration(
                    color: ThemeManager.themelightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.012),
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        address = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Flat No./Door No.',
                      filled: true,
                      labelStyle: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.mediumDefault,
                      ),
                      hintStyle: TextStyle(
                        color: ThemeManager.themeText,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeManager.themeText,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeManager.themeText,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: ThemeManager.themeText,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.025),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: ShapeDecoration(
                    color: ThemeManager.themelightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.012),
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        locality = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Village/Locality/Area',
                      filled: true,
                      labelStyle: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.mediumDefault,
                      ),
                      hintStyle: TextStyle(
                        color: ThemeManager.themeText,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeManager.themeText,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ThemeManager.themeText,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: ThemeManager.themeText,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.025),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.437,
                        decoration: ShapeDecoration(
                          color: ThemeManager.themelightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.012),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              city = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'City',
                            filled: true,
                            labelStyle: TextStyle(
                              color: ThemeManager.themeText,
                              fontSize: AppFontSizes.mediumDefault,
                            ),
                            hintStyle: TextStyle(
                              color: ThemeManager.themeText,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeManager.themeText,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeManager.themeText,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: ThemeManager.themeText,
                          ),
                        ),
                      ),

                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.437,
                      //   height: MediaQuery.of(context).size.height *
                      //       0.06, // Adjusted height
                      //   decoration: ShapeDecoration(
                      //     color: ThemeManager.themelightColor,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(
                      //         MediaQuery.of(context).size.width * 0.012,
                      //       ),
                      //     ),
                      //   ),
                      //   child: Autocomplete<String>(
                      //     optionsBuilder: (TextEditingValue textEditingValue) {
                      //       if (textEditingValue.text.isEmpty) {
                      //         return const Iterable<String>.empty();
                      //       }
                      //       return cities.where((city) => city
                      //           .toLowerCase()
                      //           .contains(textEditingValue.text.toLowerCase()));
                      //     },
                      //     onSelected: (String selection) {
                      //       setState(() {
                      //         city = selection;
                      //       });
                      //     },
                      //     fieldViewBuilder: (BuildContext context,
                      //         TextEditingController textEditingController,
                      //         FocusNode focusNode,
                      //         VoidCallback onFieldSubmitted) {
                      //       return TextField(
                      //         controller: textEditingController,
                      //         focusNode: focusNode,
                      //         onChanged: (value) {
                      //           setState(() {
                      //             city = value;
                      //           });
                      //         },
                      //         decoration: InputDecoration(
                      //           labelText: 'City',
                      //           filled: true,
                      //           labelStyle: TextStyle(
                      //             color: ThemeManager.themeText,
                      //           ),
                      //           hintStyle: TextStyle(
                      //             color: ThemeManager.themeText,
                      //           ),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: ThemeManager.themeText,
                      //             ),
                      //           ),
                      //           focusedBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: ThemeManager.themeText,
                      //             ),
                      //           ),
                      //         ),
                      //         style: TextStyle(
                      //           color: ThemeManager.themeText,
                      //         ),
                      //       );
                      //     },
                      //     optionsViewBuilder: (BuildContext context,
                      //         AutocompleteOnSelected<String> onSelected,
                      //         Iterable<String> options) {
                      //       return Align(
                      //         alignment: Alignment.topLeft,
                      //         child: Material(
                      //           child: Container(
                      //             width:
                      //                 MediaQuery.of(context).size.width * 0.437,
                      //             height:
                      //                 MediaQuery.of(context).size.width * 0.9,
                      //             color: const Color.fromARGB(255, 225, 222,
                      //                 222), // Set the dropdown background color to grey
                      //             child: ListView.builder(
                      //               padding: EdgeInsets.zero,
                      //               itemCount: options.length,
                      //               itemBuilder:
                      //                   (BuildContext context, int index) {
                      //                 final String option =
                      //                     options.elementAt(index);
                      //                 return InkWell(
                      //                   onTap: () {
                      //                     onSelected(option);
                      //                   },
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.all(8.0),
                      //                     child: Text(
                      //                       option,
                      //                       style: TextStyle(
                      //                           color: ThemeManager.themeText,
                      //                           fontSize:
                      //                               AppFontSizes.mediumDefault),
                      //                     ),
                      //                   ),
                      //                 );
                      //               },
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.437,
                        decoration: ShapeDecoration(
                          color: ThemeManager.themelightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.012,
                            ),
                          ),
                        ),
                        child: Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable<String>.empty();
                            }
                            return states.where((state) => state
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()));
                          },
                          onSelected: (String selection) {
                            setState(() {
                              state = selection;
                            });
                          },
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            return TextField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              onChanged: (value) {
                                setState(() {
                                  state = value;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'State',
                                filled: true,
                                labelStyle: TextStyle(
                                    color: ThemeManager.themeText,
                                    fontSize: AppFontSizes.mediumDefault),
                                hintStyle: TextStyle(
                                  color: ThemeManager.themeText,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ThemeManager.themeText,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ThemeManager.themeText,
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                color: ThemeManager.themeText,
                              ),
                            );
                          },
                          optionsViewBuilder: (BuildContext context,
                              AutocompleteOnSelected<String> onSelected,
                              Iterable<String> options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.437,
                                  height:
                                      MediaQuery.of(context).size.width * 0.6,
                                  color: const Color.fromARGB(255, 185, 183,
                                      183), // Dropdown background color
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: options.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final String option =
                                          options.elementAt(index);
                                      return InkWell(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            option,
                                            style: TextStyle(
                                              color: ThemeManager.themeText,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.025),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.437,
                        decoration: ShapeDecoration(
                          color: ThemeManager.themelightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.012),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              pinCode = value;
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'PIN Code',
                            filled: true,
                            labelStyle: TextStyle(
                              color: ThemeManager.themeText,
                              fontSize: AppFontSizes.mediumDefault,
                            ),
                            hintStyle: TextStyle(
                              color: ThemeManager.themeText,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeManager.themeText,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeManager.themeText,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: ThemeManager.themeText,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.437,
                        decoration: ShapeDecoration(
                          color: ThemeManager.themelightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.012),
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              landmark = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Landmark (Optional)',
                            filled: true,
                            labelStyle: TextStyle(
                              color: ThemeManager.themeText,
                              fontSize: AppFontSizes.mediumDefault,
                            ),
                            hintStyle: TextStyle(
                              color: ThemeManager.themeText,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeManager.themeText,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeManager.themeText,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: ThemeManager.themeText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBox30(),
                // SizedBox(height: MediaQuery.of(context).size.width * 0.025),
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.9,
                //   decoration: ShapeDecoration(
                //     color: ThemeManager.themelightColor,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(
                //           MediaQuery.of(context).size.width * 0.012),
                //     ),
                //   ),
                //   child: TextField(
                //     onChanged: (value) {
                //       setState(() {
                //         phoneNumnber = value;
                //       });
                //     },
                //     keyboardType: TextInputType.phone,
                //     decoration: InputDecoration(
                //       labelText: 'Phone Number',
                //       filled: true,
                //       labelStyle: TextStyle(
                //         color: ThemeManager.themeText,
                //         fontSize: AppFontSizes.mediumDefault,
                //       ),
                //       hintStyle: TextStyle(
                //         color: ThemeManager.themeText,
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: ThemeManager.themeText,
                //         ),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: ThemeManager.themeText,
                //         ),
                //       ),
                //     ),
                //     style: TextStyle(
                //       color: ThemeManager.themeText,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 235, 239, 209),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    child: const Text(
                      'Disclaimer: Delivery/packing and processing charges are non-refundable. This includes situations where you enter the wrong address.',
                      style: TextStyle(
                        fontSize: AppFontSizes.smallDefault,
                        color: Color.fromARGB(255, 48, 47, 47),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const Spacer(),
                SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                InkWell(
                  onTap: () {
                    if (_validateForm()) {
                      _startPayment();
                    } else {
                      _showValidationError();
                    }
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.0544,
                      decoration: ShapeDecoration(
                        color: TColor.secondaryColor1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.012,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Make Payment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppFontSizes.mediumDefault,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isLoading) // Show loading overlay
          const Positioned.fill(
            child: ModalBarrier(
              dismissible: false, // Disable tapping on the barrier
              color: Colors.black54, // Semi-transparent background
            ),
          ),
      ],
    );
  }
}
