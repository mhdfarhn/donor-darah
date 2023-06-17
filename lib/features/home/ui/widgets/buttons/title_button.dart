import 'package:flutter/material.dart';

import '../../../../../core/constants/app_font_size.dart';

class TitleButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const TitleButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppFontSize.heading,
              fontWeight: FontWeight.w600,
            ),
          ),
          // const FaIcon(
          //   FontAwesomeIcons.arrowRight,
          // )
        ],
      ),
    );
  }
}
