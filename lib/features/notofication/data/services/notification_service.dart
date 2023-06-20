import 'dart:convert';

import 'package:http/http.dart' as http;

class NotificationService {
  final String _url = 'https://fcm.googleapis.com/fcm/send';
  final Map<String, String> _headers = {
    'Authorization':
        'Bearer AAAAhsMeQbE:APA91bFPxHIVANKdnuVxX1X_N8x7LdpqyutaQaeXexOZDY6Kp6dNd8kZNYVtGS2LqyyBFtyeEiOQaBXlq-IYHd-q3pHyx9AfZKb2s4D8HdM1SIDon4xzde9ylB7Fm4h6czZnhZjMjs9l',
    'Content-Type': 'application/json',
  };

  sendNotification({
    required String token,
    required String title,
    required String text,
  }) async {
    Map<String, dynamic> body = {
      'to': token,
      'notification': {
        'title': title,
        'body': text,
      },
    };

    try {
      await http.post(
        Uri.parse(_url),
        headers: _headers,
        body: jsonEncode(body),
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
