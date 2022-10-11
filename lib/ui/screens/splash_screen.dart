import 'package:donor_darah/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                kAppLogo,
                width: screenWidth / 4,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 16.0),
              const Text(
                kAppTitle,
                style: kHeading,
              ),
              const Spacer(),
              const CircularProgressIndicator(color: kPrimaryColor),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
