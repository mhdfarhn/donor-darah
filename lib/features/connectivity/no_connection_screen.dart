import 'package:donor_darah/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.close_rounded,
                size: 64.sp,
                color: AppColor.red,
              ),
              SizedBox(height: 16.h),
              Text(
                'Tidak ada koneksi internet',
                style: TextStyle(fontSize: AppFontSize.heading),
              ),
              SizedBox(height: 8.h),
              Text(
                'Sambungkan koneksi internet Anda',
                style: TextStyle(fontSize: AppFontSize.body),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
