import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/utils/constants.dart';

class OptionInputWidget extends StatefulWidget {
  final String labelText;
  final List<String> optionList;
  final String? Function(String?) validator;

  const OptionInputWidget({
    super.key,
    required this.labelText,
    required this.optionList,
    required this.validator,
  });

  @override
  State<OptionInputWidget> createState() => _OptionInputWidgetState();
}

class _OptionInputWidgetState extends State<OptionInputWidget> {
  late String optionValue;

  @override
  void initState() {
    optionValue = widget.optionList.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: kGreyColor,
      iconEnabledColor: kBrownColor,
      icon: const Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: FaIcon(FontAwesomeIcons.angleDown),
      ),
      validator: widget.validator,
      borderRadius: BorderRadius.circular(10.0),
      decoration: InputDecoration(
        labelText: widget.labelText,
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
      items: widget.optionList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          optionValue = value!;
        });
      },
    );
  }
}
