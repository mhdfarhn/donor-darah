import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/blocs/auth/auth_bloc.dart';
import '../../../../core/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(CheckAuthStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Timer(
            const Duration(seconds: 1),
            () => context.goNamed('auth'),
          );
        } else if (state is AuthAdminAuthenticated) {
          Timer(
            const Duration(seconds: 1),
            () => context.goNamed('admin'),
          );
        } else if (state is AuthAuthenticated) {
          Timer(
            const Duration(seconds: 1),
            () => context.goNamed('home'),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.appLogo,
                  width: 80.0.w,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 8.0.h),
                Text(
                  AppString.appTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.heading,
                    color: AppColor.brown,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
