import 'package:flutter/material.dart';

import '../../../../../core/constants/app_font_size.dart';

class TitleText extends StatelessWidget {
  final String title;

  const TitleText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppFontSize.heading,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
