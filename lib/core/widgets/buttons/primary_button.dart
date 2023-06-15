import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: AppColor.red,
        // primary: AppColor.red,
        padding: EdgeInsets.symmetric(
          vertical: 16.0.h,
          horizontal: 16.0.w,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: AppFontSize.button),
      ),
    );
  }
}
