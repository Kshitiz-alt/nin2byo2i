import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/view/ScreensAPP/OrderHistory.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button swipe gesture
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeManager.themeColor,
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false, // Disables the back button
          title: Text(
            "Payment Successful",
            style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: ThemeManager.themeColor,
        body: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                decoration: BoxDecoration(
                  color: ThemeManager.themelightColor,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.02),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: MediaQuery.of(context).size.width * 0.15,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      "Payment successful. The books purchased will be delivered within a maximum of 20 working days.",
                      style: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      "If not received within the mentioned time, please contact: petninhyd@yahoo.com (Ph.no.04027197247).",
                      style: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              InkWell(
                onTap: () {
                  // Navigate to OrderHistoryPage after successful payment
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                  );
                },
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
                  child: Center(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
