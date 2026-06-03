import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';

class CommonDataLoadingScreen extends StatelessWidget {
  const CommonDataLoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            strokeWidth: 4.0,
          ),
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: TColor.primaryColor1.withOpacity(0.3),
                width: 4.0,
              ),
            ),
          ),
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: TColor.secondaryColor1.withOpacity(0.5),
                width: 2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
