import 'package:flutter/material.dart';

import '/utils/constants.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onPressed;
  final String title;

  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: kRedColor,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: kButtonFontSize),
      ),
    );
  }
}
