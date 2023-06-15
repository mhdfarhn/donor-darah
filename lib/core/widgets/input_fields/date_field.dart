import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class DateField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final void Function() onTap;

  const DateField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.onTap,
  }) : super(key: key);

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: AppColor.brown,
      onTap: widget.onTap,
      readOnly: true,
      validator: AppValidator.date,
      decoration: InputDecoration(
        filled: true,
        labelStyle: const TextStyle(color: AppColor.brown),
        labelText: widget.labelText,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
