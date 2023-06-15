import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final bool status;
  final String name;
  final String email;
  final String? token;
  final Timestamp? dateOfBirth;
  final String? gender;
  final String? bloodType;
  final String? phoneNumber;
  final GeoPoint? location;
  final Timestamp? lastDonation;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const UserModel({
    required this.status,
    required this.name,
    required this.email,
    this.token,
    this.dateOfBirth,
    this.gender,
    this.bloodType,
    this.phoneNumber,
    this.location,
    this.lastDonation,
    this.createdAt,
    this.updatedAt,
  });

  UserModel copyWith({
    required bool status,
    required String name,
    required String email,
    String? token,
    Timestamp? dateOfBirth,
    String? gender,
    String? bloodType,
    String? phoneNumber,
    GeoPoint? location,
    Timestamp? lastDonation,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return UserModel(
      status: status,
      name: name,
      email: email,
      token: token ?? this.token,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      bloodType: bloodType ?? this.bloodType,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      lastDonation: lastDonation ?? this.lastDonation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    return UserModel(
      status: doc['status'],
      name: doc['name'],
      email: doc['email'],
      token: doc['token'],
      dateOfBirth: doc['dateOfBirth'],
      gender: doc['gender'],
      bloodType: doc['bloodType'],
      phoneNumber: doc['phoneNumber'],
      location: doc['location'],
      lastDonation: doc['lastDonation'],
      createdAt: doc['createdAt'],
      updatedAt: doc['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'name': name,
      'email': email,
      'token': token,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'bloodType': bloodType,
      'phoneNumber': phoneNumber,
      'location': location,
      'lastDonation': lastDonation,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        status,
        name,
        email,
        token,
        dateOfBirth,
        gender,
        bloodType,
        phoneNumber,
        location,
        lastDonation,
        createdAt,
        updatedAt,
      ];
}
