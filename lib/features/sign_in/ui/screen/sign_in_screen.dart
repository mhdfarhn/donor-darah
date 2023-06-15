import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/blocs/auth/auth_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/buttons/buttons.dart';
import '../../../../core/widgets/input_fields/input_fields.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.goNamed('home');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 16.0.h),
                    Image.asset(
                      AppImage.appLogo,
                      width: 80.0.w,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(height: 16.0.h),
                    Text(
                      AppString.appTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSize.heading,
                        color: AppColor.brown,
                      ),
                    ),
                    SizedBox(height: 64.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            EmailField(
                              controller: _emailController,
                            ),
                            SizedBox(height: 16.0.h),
                            PasswordField(
                              controller: _passwordController,
                            ),
                            SizedBox(height: 16.0.h),
                            Row(
                              children: [
                                Expanded(
                                  child: state is AuthLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColor.red,
                                          ),
                                        )
                                      : PrimaryButton(
                                          title: 'Masuk',
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context.read<AuthBloc>().add(
                                                    SignInRequest(
                                                      _emailController.text,
                                                      _passwordController.text,
                                                    ),
                                                  );
                                            }
                                          },
                                        ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1.0.h,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.0.w,
                                    vertical: 16.0.h,
                                  ),
                                  child: Text(
                                    'ATAU',
                                    style: TextStyle(
                                      fontSize: AppFontSize.caption,
                                      color: AppColor.brown,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(thickness: 1.0.h),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: SecondaryButton(
                                    title: 'Daftar',
                                    onPressed: () {
                                      context.goNamed('sign_up');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
