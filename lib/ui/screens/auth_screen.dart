import 'package:donor_darah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
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
                  style: TextStyle(
                    fontSize: kHeadingFontSize,
                    fontWeight: FontWeight.bold,
                    color: kBrownColor,
                  ),
                ),
                const SizedBox(height: 64.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        EmailInputWidget(
                          emailController: _emailController,
                        ),
                        const SizedBox(height: 16.0),
                        PasswordInputWidget(
                          passwordController: _passwordController,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  context.go('/home');
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  primary: kRedColor,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                ),
                                child: const Text(
                                  'Masuk',
                                  style: TextStyle(fontSize: kButtonFontSize),
                                ),
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
                                'Atau',
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
                                onPressed: () => context.go('/auth/register'),
                                style: ElevatedButton.styleFrom(
                                  primary: kWhiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
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

class PasswordInputWidget extends StatelessWidget {
  const PasswordInputWidget({
    Key? key,
    required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      cursorColor: kBrownColor,
      decoration: InputDecoration(
        labelText: 'Kata Sandi',
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan kata sandi anda.';
        }
        return null;
      },
    );
  }
}

class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget({
    Key? key,
    required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      cursorColor: kBrownColor,
      decoration: InputDecoration(
        labelText: 'Email',
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan alamat email anda.';
        }
        return null;
      },
    );
  }
}
