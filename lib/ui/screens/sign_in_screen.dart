import 'package:donor_darah/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '/ui/widgets/primary_button.dart';
import '/ui/widgets/text_input_widget.dart';
import '/utils/constants.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  kAppLogo,
                  width: screenWidth / 4,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  kAppTitle,
                  style: kAppTitleTextStyle,
                ),
                const SizedBox(height: 64.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextInputWidget(
                          labelText: 'Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                        const SizedBox(height: 16.0),
                        TextInputWidget(
                          labelText: 'Kata Sandi',
                          controller: _passwordController,
                          obsecureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: passwordValidator,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                title: 'Masuk',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.go('/home');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                              child: Divider(
                                thickness: 1.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 16.0,
                              ),
                              child: Text(
                                'ATAU',
                                style: TextStyle(
                                  fontSize: kCaptionFontSize,
                                  color: kBrownColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(thickness: 1.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => context.go('/sign-up'),
                                style: ElevatedButton.styleFrom(
                                  primary: kWhiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                ),
                                child: const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color: kBrownColor,
                                    fontSize: kButtonFontSize,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
  }
}
