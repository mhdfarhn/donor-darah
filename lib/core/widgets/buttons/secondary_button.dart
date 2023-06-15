import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const SecondaryButton({
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
        // primary: AppColor.white,
        backgroundColor: AppColor.white,
        padding: EdgeInsets.symmetric(
          vertical: 16.0.h,
          horizontal: 16.0.w,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: AppFontSize.button,
          color: AppColor.brown,
        ),
      ),
    );
  }
}
