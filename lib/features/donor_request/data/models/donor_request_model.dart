import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DonorRequestModel extends Equatable {
  final String? uid;
  final String? email;
  final String? name;
  final String bloodType;
  final String phoneNumber;
  final GeoPoint location;
  final bool active;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const DonorRequestModel({
    this.uid,
    this.email,
    this.name,
    required this.bloodType,
    required this.phoneNumber,
    required this.location,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  DonorRequestModel copyWith({
    String? uid,
    String? email,
    String? name,
    required String bloodType,
    required String phoneNumber,
    required GeoPoint location,
    required bool active,
    required Timestamp createdAt,
    required Timestamp updatedAt,
  }) {
    return DonorRequestModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bloodType: bloodType,
      phoneNumber: phoneNumber,
      location: location,
      active: active,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory DonorRequestModel.fromSnapshot(DocumentSnapshot doc) {
    return DonorRequestModel(
      uid: doc['uid'],
      email: doc['email'],
      name: doc['name'],
      bloodType: doc['bloodType'],
      phoneNumber: doc['phoneNumber'],
      location: doc['location'],
      active: doc['active'],
      createdAt: doc['createdAt'],
      updatedAt: doc['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'bloodType': bloodType,
      'phoneNumber': phoneNumber,
      'location': location,
      'active': active,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        name,
        bloodType,
        phoneNumber,
        location,
        active,
        createdAt,
        updatedAt,
      ];
}
