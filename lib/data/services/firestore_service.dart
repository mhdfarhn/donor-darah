import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/data/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toDocument());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
