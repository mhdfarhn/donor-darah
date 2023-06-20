import 'package:flutter/material.dart';

import '../../../../core/widgets/buttons/primary_button.dart';
import '../../data/services/notification_service.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        centerTitle: true,
      ),
      body: Center(
        child: PrimaryButton(
          title: 'Test Notification',
          onPressed: () {
            NotificationService().sendNotification(
              token:
                  'fi1Xqn0RTpuVMHp8EB__nI:APA91bFj46LMynFxKSgHYWzrATDzLYAh9_Y0iHClDZQ-32ab0OfjTceISKTF7Dwj1XwfSg4J1pA2-ZVG6PSLNgjoI3DaG7ElWmnyJFAvMTRgNMum1k5IcqMwX-jPI4-KcLXHuDOyfpIb',
              title: 'Title',
              text: 'Body',
            );
          },
        ),
      ),
    );
  }
}
