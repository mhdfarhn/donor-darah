import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String role;
  final String name;
  final String email;
  final bool status;
  final String bloodType;
  final DateTime dateOfBirth;
  // final GeoPoint location;

  UserModel({
    this.id = '',
    this.role = '',
    this.name = '',
    this.email = '',
    this.status = false,
    this.bloodType = '',
    DateTime? dateOfBirth,
  }) : dateOfBirth = dateOfBirth ?? DateTime.now();

  UserModel copyWith({
    String? id,
    String? role,
    String? name,
    String? email,
    bool? status,
    String? bloodType,
    DateTime? dateOfBirth,
    // GeoPoint? location,
  }) {
    return UserModel(
      id: id ?? this.id,
      role: role ?? this.role,
      name: name ?? this.name,
      email: email ?? this.email,
      status: status ?? this.status,
      bloodType: bloodType ?? this.bloodType,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      // location: location ?? this.location,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      role: doc['role'],
      name: doc['name'],
      email: doc['email'],
      status: doc['status'],
      bloodType: doc['bloodType'],
      dateOfBirth: doc['dateOfBirth'],
      // location: doc['location'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'role': role,
      'name': name,
      'email': email,
      'status': status,
      'bloodType': bloodType,
      'birthOfDate': dateOfBirth,
      // 'location': location,
    };
  }

  @override
  List<Object?> get props => [
        id,
        role,
        name,
        email,
        status,
        bloodType,
        dateOfBirth,
        // location,
      ];
}
