import 'package:flutter/material.dart';

import '/utils/constants.dart';

class TextInputWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  final TextInputType keyboardType;
  final bool obsecureText;

  const TextInputWidget({
    super.key,
    required this.labelText,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obsecureText,
      cursorColor: kBrownColor,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: kBrownColor),
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
      validator: validator,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Masukkan alamat email anda.';
      //   }
      //   return null;
      // },
    );
  }
}
