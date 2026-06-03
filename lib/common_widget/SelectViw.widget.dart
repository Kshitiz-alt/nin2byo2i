import 'package:flutter/material.dart';
import '../../Common/colo_extension.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class SelectViewWidget extends StatelessWidget {
  final Map fObj;
  final int index;
  const SelectViewWidget({super.key, required this.index, required this.fObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    bool isEvent = index % 2 == 0;
    return Container(
      margin: const EdgeInsets.all(5),
      width: media.width * 0.4,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isEvent
                ? [
                    TColor.primaryColor2.withOpacity(0.5),
                    TColor.primaryColor1.withOpacity(0.5)
                  ]
                : [
                    TColor.secondaryColor2.withOpacity(0.5),
                    TColor.secondaryColor1.withOpacity(0.5)
                  ],
          ),
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            fObj["image"].toString(),
            width: media.width * 0.15,
            height: media.width * 0.10,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              fObj["name"],
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.w500),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Text(
          //     "${fObj["size"]} | ${fObj["time"]} | ${fObj["kcal"]}",
          //     style: TextStyle(color: TColor.gray, fontSize: AppFontSizes

          //   ),
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: SizedBox(
          //     width: 90,
          //     height: 35,
          //     child: RoundButton(
          //         fontSize: AppFontSizes

          //         type: isEvent
          //             ? RoundButtonType.bgGradient
          //             : RoundButtonType.bgSGradient,
          //         title: "View",
          //         onPressed: () {}),
          //   ),
          // ),
        ],
      ),
    );
  }
}
