import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColor.brown,
      keyboardType: TextInputType.phone,
      validator: AppValidator.phoneNumber,
      decoration: InputDecoration(
        labelText: 'Nomor Handphone',
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
