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
                  'ev7aZm5xRPGjk4BtdFNjAd:APA91bETgiSsIAy0oBT6oT-NRfxLKJQumutTpXecgoE4vZVMEq1z2lERxt7ANzqnPHXKsYIFJNzPffLNUrOI4ZJw320wElT7X4deRYMzwQzCqXJQOdxIy6tFNAZ7pefnkgrScRvV3wMG',
              title: 'Title',
              text: 'Body',
            );
          },
        ),
      ),
    );
  }
}
