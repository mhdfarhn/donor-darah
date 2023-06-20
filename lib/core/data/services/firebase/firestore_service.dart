import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/core/data/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _donorHistoriesCollectionReference =
      FirebaseFirestore.instance.collection('donorHistories');

  Future<void> createUser(UserModel user, String token) async {
    try {
      _usersCollectionReference.doc(user.email).set(
            user
                .copyWith(
                  status: user.status,
                  name: user.name,
                  email: user.email,
                  token: token,
                  createdAt: Timestamp.now(),
                  updatedAt: Timestamp.now(),
                )
                .toMap(),
          );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserModel> getUser(String email) async {
    try {
      DocumentSnapshot doc = await _usersCollectionReference.doc(email).get();
      UserModel user = UserModel.fromSnapshot(doc);

      return user;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      _usersCollectionReference.doc(user.email).update(
            user
                .copyWith(
                  status: user.status,
                  name: user.name,
                  email: user.email,
                  updatedAt: Timestamp.now(),
                )
                .toMap(),
          );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteToken(UserModel user) async {
    try {
      _usersCollectionReference.doc(user.email).update(
            user
                .copyWith(
                  status: user.status,
                  name: user.name,
                  email: user.email,
                  token: '',
                  updatedAt: Timestamp.now(),
                )
                .toMap(),
          );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateToken(UserModel user, String token) async {
    try {
      _usersCollectionReference.doc(user.email).update(
            user
                .copyWith(
                  status: user.status,
                  name: user.name,
                  email: user.email,
                  token: token,
                  updatedAt: Timestamp.now(),
                )
                .toMap(),
          );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<UserModel>> getDonors() async {
    try {
      QuerySnapshot userQuerySnapshot = await _usersCollectionReference
          .where('status', isEqualTo: true)
          .get();
      List<QueryDocumentSnapshot> docs = userQuerySnapshot.docs;

      List<UserModel> users = <UserModel>[];
      if (docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in docs) {
          users.add(
            UserModel.fromSnapshot(doc),
          );
        }
      }

      return users;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<UserModel>> getDonorsByBloodType(String bloodType) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      QuerySnapshot userQuerySnapshot = await _usersCollectionReference
          .where('email', isNotEqualTo: user!.email!)
          // // Uncomment for active user only.
          // .where('token', isNotEqualTo: '')
          // .where('token', isNotEqualTo: null)
          .where('status', isEqualTo: true)
          .where(
            'bloodType',
            isEqualTo: bloodType,
          )
          .get();
      List<QueryDocumentSnapshot> docs = userQuerySnapshot.docs;

      List<UserModel> users = <UserModel>[];
      if (docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in docs) {
          users.add(
            UserModel.fromSnapshot(doc),
          );
        }
      }

      return users;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateLastDonation(UserModel user, Timestamp time) async {
    try {
      _usersCollectionReference.doc(user.email).update(
            user
                .copyWith(
                  status: user.status,
                  name: user.name,
                  email: user.email,
                  lastDonation: time,
                  updatedAt: Timestamp.now(),
                )
                .toMap(),
          );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> createDonorHistory({
    required Timestamp date,
    required String location,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;

    try {
      _donorHistoriesCollectionReference.add(
        DonorHistoryModel(
          date: date,
          email: user!.email!,
          location: location,
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
        ).toMap(),
      );
    } on FirebaseException catch (e) {
      e.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DonorHistoryModel>> getDonorHistories() async {
    final User? user = FirebaseAuth.instance.currentUser;

    try {
      QuerySnapshot querySnapshot = await _donorHistoriesCollectionReference
          .where('email', isEqualTo: user!.email!)
          .orderBy('date', descending: true)
          .get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      List<DonorHistoryModel> donorHistories = <DonorHistoryModel>[];
      if (docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in docs) {
          donorHistories.add(
            DonorHistoryModel.fromSnaphsot(doc),
          );
        }
      }

      return donorHistories;
    } catch (e) {
      throw e.toString();
    }
  }
}
