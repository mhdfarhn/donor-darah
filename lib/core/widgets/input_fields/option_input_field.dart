import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';

class OptionInputField extends StatefulWidget {
  final String labelText;
  final List<String> optionList;
  final String? Function(String?) validator;
  final String? value;
  final void Function(String?) onChanged;

  const OptionInputField({
    super.key,
    required this.labelText,
    required this.optionList,
    required this.validator,
    required this.onChanged,
    this.value,
  });

  @override
  State<OptionInputField> createState() => _OptionInputFieldState();
}

class _OptionInputFieldState extends State<OptionInputField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: AppColor.grey,
      iconEnabledColor: AppColor.brown,
      icon: const Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: FaIcon(FontAwesomeIcons.angleDown),
      ),
      value: widget.value,
      validator: widget.validator,
      borderRadius: BorderRadius.circular(10.0),
      decoration: InputDecoration(
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
      items: widget.optionList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}
