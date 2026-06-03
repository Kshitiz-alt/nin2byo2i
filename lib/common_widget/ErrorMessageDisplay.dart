//common error messsage
import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  const ErrorPage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.themeColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 50,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(
                  fontSize: AppFontSizes.mediumDefault,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              'Error => $errorMessage',
              style: const TextStyle(
                  fontSize: AppFontSizes.mediumDefault, color: Colors.black),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
