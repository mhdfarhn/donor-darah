import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constants.dart';

class GenderField extends StatelessWidget {
  final void Function(String?) onChanged;
  final String? value;

  const GenderField({
    Key? key,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      borderRadius: BorderRadius.circular(10.0),
      dropdownColor: AppColor.grey,
      iconEnabledColor: AppColor.brown,
      onChanged: onChanged,
      validator: AppValidator.gender,
      value: value,
      icon: Padding(
        padding: EdgeInsets.only(right: 8.0.w),
        child: const FaIcon(FontAwesomeIcons.angleDown),
      ),
      items: AppList.genders.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      decoration: InputDecoration(
        labelText: 'Jenis Kelamin',
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
