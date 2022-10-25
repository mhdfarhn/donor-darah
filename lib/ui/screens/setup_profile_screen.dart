import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SetupProfile extends StatelessWidget {
  const SetupProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Setup your profile here.'),
            ElevatedButton(
              onPressed: () => context.go('/auth/register'),
              child: const Text('back to register'),
            ),
          ],
        ),
      ),
    );
  }
}
