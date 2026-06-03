import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class ShareAppAndBarcode extends StatelessWidget {
  final String url;
  final String text;

  const ShareAppAndBarcode({
    Key? key,
    required this.url,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 210,
                  height: 210,
                  color: Colors.white,
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    color: Colors.black,
                    data: url,
                    width: 200,
                    height: 200,
                  ),
                ),
                // SizedBox(height: 20.0),
                // Text(
                //   Languages.of(context)!.TextAppShareApp,
                //   style: TextStyle(
                //     color: Colors.black, // Adjust text color as needed
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          SizedBox(
            width: 120,
            // height: 35,
            child: RoundButton(
              // title: Languages.of(context)!.labelShareAppButton,
              title: Languages.of(context)!.TextAppShareApp,
              type: RoundButtonType.bgGradient,
              fontSize: AppFontSizes.smallDefault,
              fontWeight: FontWeight.w400,
              onPressed: () {
                Share.share('$text $url');
              },
            ),
          ),
          const SizedBox(height: 30.0),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
