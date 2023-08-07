import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../functions/functions.dart';
import '../widgets/sections/sections.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
            onPressed: () {
              showSignOutDialog(context);
            },
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const ProfileSection(),
          Divider(thickness: 1.0.h),
          const DonorRequestSection(),
          Divider(thickness: 1.0.h),
          const DonorHistorySection(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.red,
        child: const FaIcon(FontAwesomeIcons.plus),
        onPressed: () {
          showDonorHistoryForm(context);
        },
      ),
    );
  }
}
