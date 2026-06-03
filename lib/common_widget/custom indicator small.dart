import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';

class CommonDataLoadingScreenForSmall extends StatelessWidget {
  const CommonDataLoadingScreenForSmall({
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
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: TColor.primaryColor1.withOpacity(0.3),
                width: 2.0,
              ),
            ),
          ),
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: TColor.secondaryColor1.withOpacity(0.5),
                width: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
