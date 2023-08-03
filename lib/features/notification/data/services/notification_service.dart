import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../models/notification_model.dart';

class NotificationService {
  final String _url = 'https://fcm.googleapis.com/fcm/send';
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('notifications');

  final Map<String, String> _headers = {
    'Authorization':
        'Bearer AAAAhsMeQbE:APA91bFPxHIVANKdnuVxX1X_N8x7LdpqyutaQaeXexOZDY6Kp6dNd8kZNYVtGS2LqyyBFtyeEiOQaBXlq-IYHd-q3pHyx9AfZKb2s4D8HdM1SIDon4xzde9ylB7Fm4h6czZnhZjMjs9l',
    'Content-Type': 'application/json',
  };

  Future<List<NotificationModel>> loadNotifications() async {
    final User? user = FirebaseAuth.instance.currentUser;

    try {
      final QuerySnapshot query = await _collectionReference
          .where('receiverEmail', isEqualTo: user!.email!)
          .orderBy('createdAt', descending: true)
          .get();
      List<QueryDocumentSnapshot> docs = query.docs;

      List<NotificationModel> notifications = <NotificationModel>[];
      if (docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in docs) {
          notifications.add(NotificationModel.fromSnapshot(doc));
        }
      }

      return notifications;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> sendNotification({
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
      final http.Response response = await http.post(
        Uri.parse(_url),
        headers: _headers,
        body: jsonEncode(body),
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['success'] != 1) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> storeNotificationToFirestore(
      NotificationModel notification) async {
    try {
      String uid = _collectionReference.doc().id;
      _collectionReference.doc(uid).set(
            notification
                .copyWith(
                  uid: uid,
                )
                .toMap(),
          );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
