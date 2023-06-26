import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String? uid;
  final String donorRequestId;
  final bool accepted;
  final String senderEmail;
  final String senderName;
  final String receiverEmail;
  final String receiverName;
  final String title;
  final String text;
  final String category;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const NotificationModel({
    this.uid,
    required this.donorRequestId,
    required this.senderEmail,
    required this.senderName,
    required this.receiverEmail,
    required this.receiverName,
    required this.accepted,
    required this.title,
    required this.text,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  NotificationModel copyWith({
    String? uid,
    String? donorRequestId,
    String? senderEmail,
    String? senderName,
    String? receiverEmail,
    String? receiverName,
    bool? accepted,
    String? title,
    String? text,
    String? category,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return NotificationModel(
      uid: uid ?? this.uid,
      donorRequestId: donorRequestId ?? this.donorRequestId,
      senderEmail: senderEmail ?? this.senderEmail,
      senderName: senderName ?? this.senderEmail,
      receiverEmail: receiverEmail ?? this.receiverEmail,
      receiverName: receiverName ?? this.receiverEmail,
      accepted: accepted ?? this.accepted,
      title: title ?? this.title,
      text: text ?? this.text,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory NotificationModel.fromSnapshot(DocumentSnapshot doc) {
    return NotificationModel(
      uid: doc['uid'],
      donorRequestId: doc['donorRequestId'],
      senderEmail: doc['senderEmail'],
      senderName: doc['senderName'],
      receiverEmail: doc['receiverEmail'],
      receiverName: doc['receiverName'],
      accepted: doc['accepted'],
      title: doc['title'],
      text: doc['text'],
      category: doc['category'],
      createdAt: doc['createdAt'],
      updatedAt: doc['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'donorRequestId': donorRequestId,
      'senderEmail': senderEmail,
      'senderName': senderName,
      'receiverEmail': receiverEmail,
      'receiverName': receiverName,
      'accepted': accepted,
      'title': title,
      'text': text,
      'category': category,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        uid,
        donorRequestId,
        senderEmail,
        senderName,
        receiverEmail,
        receiverName,
        accepted,
        title,
        text,
        category,
        createdAt,
        updatedAt,
      ];
}
