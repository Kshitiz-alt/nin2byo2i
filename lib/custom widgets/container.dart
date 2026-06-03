import 'package:flutter/material.dart';
import 'package:nin2byo2i/constants/assets.dart';
import 'package:nin2byo2i/custom%20widgets/today_target.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class TodayTargetContainer extends StatelessWidget {
  const TodayTargetContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315,
      height: 140,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-1.00, 0.08),
          end: Alignment(1, -0.08),
          colors: [
            Color.fromARGB(255, 174, 188, 255),
            Color.fromARGB(255, 175, 214, 252)
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Today Target',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppFontSizes.mediumDefault,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 24,
                  height: 24,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, 0.08),
                      end: Alignment(1, -0.08),
                      colors: [
                        Color.fromARGB(255, 122, 144, 253),
                        Color.fromARGB(255, 121, 178, 235)
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                    child: TodayTarget(
                  image: Assets.glass,
                  val: '1L',
                  name: 'Water',
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TodayTarget(
                        image: Assets.glass, val: '2400', name: 'FootSteps')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
