import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DonorHistoryModel extends Equatable {
  final String email;
  final Timestamp date;
  final String location;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const DonorHistoryModel({
    required this.email,
    required this.date,
    required this.location,
    this.createdAt,
    this.updatedAt,
  });

  factory DonorHistoryModel.fromSnaphsot(DocumentSnapshot doc) {
    return DonorHistoryModel(
      email: doc['email'],
      date: doc['date'],
      location: doc['location'],
      createdAt: doc['createdAt'],
      updatedAt: doc['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'date': date,
      'location': location,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        email,
        date,
        location,
        createdAt,
        updatedAt,
      ];
}
