import 'package:donor_darah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppTitle),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Home Screen'),
            ElevatedButton(
              onPressed: () => context.go('/auth'),
              child: Text('back to auth'),
            ),
          ],
        ),
      ),
    );
  }
}
