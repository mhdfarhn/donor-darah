import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: AppColor.brown,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obsecureText,
      validator: AppValidator.password,
      decoration: InputDecoration(
        filled: true,
        labelStyle: const TextStyle(color: AppColor.brown),
        labelText: 'Kata Sandi',
        suffix: Padding(
          padding: EdgeInsets.only(right: 8.0.w),
          child: GestureDetector(
            onTap: () {
              setState(() {
                obsecureText = !obsecureText;
              });
            },
            child: obsecureText != true
                ? FaIcon(
                    FontAwesomeIcons.eyeSlash,
                    size: 20.0.sp,
                  )
                : FaIcon(
                    FontAwesomeIcons.eye,
                    size: 20.0.sp,
                  ),
          ),
        ),
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
