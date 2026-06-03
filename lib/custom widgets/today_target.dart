import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class TodayTarget extends StatelessWidget {
  final String image;
  final String val;
  final String name;
  const TodayTarget(
      {super.key, required this.image, required this.val, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 60,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // Image.asset(
            //   image,
            //   height: 32,
            //   width: 29,
            // ),
            Column(
              children: [
                Text(
                  val,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 12, 31, 126),
                    fontSize: AppFontSizes.mediumDefault,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF7B6F72),
                    fontSize: AppFontSizes.smallDefault,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
