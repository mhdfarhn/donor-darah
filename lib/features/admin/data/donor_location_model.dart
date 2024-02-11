import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DonorLocationModel extends Equatable {
  final String? uid;
  final bool status;
  final String name;
  final String? description;
  final GeoPoint location;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const DonorLocationModel({
    this.uid,
    required this.status,
    required this.name,
    this.description,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  DonorLocationModel copyWith({
    String? uid,
    bool? status,
    String? name,
    String? description,
    GeoPoint? location,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return DonorLocationModel(
      uid: uid ?? this.uid,
      status: status ?? this.status,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory DonorLocationModel.fromSnaphsot(DocumentSnapshot doc) {
    return DonorLocationModel(
      uid: doc['uid'],
      status: doc['status'],
      name: doc['name'],
      description: doc['description'],
      location: doc['location'],
      createdAt: doc['createdAt'],
      updatedAt: doc['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'status': status,
      'name': name,
      'description': description ?? '',
      'location': location,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        uid,
        status,
        name,
        description,
        location,
        createdAt,
        updatedAt,
      ];
}
