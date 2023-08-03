import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../widgets/buttons/title_button.dart';
import '../widgets/sections/sections.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appTitle),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const TitleText(
              title: 'Peta',
            ),
          ),
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const MapSection(),
          ),
          SizedBox(height: 24.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const TitleText(
              title: 'Butuh Donor',
            ),
          ),
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const ActiveDonorRequestSection(),
          ),
          SizedBox(height: 24.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const TitleText(
              title: 'Donor Selesai',
            ),
          ),
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const SuccessDonorRequestSection(),
          ),
          SizedBox(height: 16.0.h),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.red,
        child: const FaIcon(FontAwesomeIcons.magnifyingGlass),
        onPressed: () async {
          context.goNamed('search');
        },
      ),
    );
  }
}
