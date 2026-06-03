import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginButton extends StatelessWidget {
  final String path;
  const SocialLoginButton({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 50,
      height: 50,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.80, color: Color(0xFFDDD9DA)),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: SvgPicture.asset(path),
    );
  }
}
