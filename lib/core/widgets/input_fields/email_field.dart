import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;

  const EmailField({
    Key? key,
    required this.controller,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColor.brown,
      keyboardType: TextInputType.emailAddress,
      readOnly: readOnly,
      validator: AppValidator.email,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: const TextStyle(color: AppColor.brown),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: UnderlineInputBorder(
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
