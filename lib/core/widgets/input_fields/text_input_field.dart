import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';

class TextInputField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  final TextInputType keyboardType;
  final bool obsecureText;
  final bool readOnly;
  final void Function()? onTap;
  final String? hint;

  const TextInputField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obsecureText = false,
    this.readOnly = false,
    this.onTap,
    this.hint,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obsecureText != true ? false : obsecureText,
      cursorColor: AppColor.brown,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      decoration: InputDecoration(
        hintText: widget.hint,
        suffix: widget.obsecureText != true
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      obsecureText = !obsecureText;
                    });
                  },
                  child: obsecureText != true
                      ? const FaIcon(
                          FontAwesomeIcons.eyeSlash,
                          size: 20.0,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.eye,
                          size: 20.0,
                        ),
                ),
              ),
        labelText: widget.labelText,
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
      validator: widget.validator,
    );
  }
}
