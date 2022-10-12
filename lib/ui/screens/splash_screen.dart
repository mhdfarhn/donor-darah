import 'dart:async';

import 'package:donor_darah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 3000), () {
      context.go('/auth');
    });
    super.initState();
  }

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
              SvgPicture.asset(
                kAppLogo,
                width: screenWidth / 4,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 16.0),
              const Text(
                kAppTitle,
                style: kHeadingTextStyle,
              ),
              const Spacer(),
              const CircularProgressIndicator(color: kBrownColor),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
