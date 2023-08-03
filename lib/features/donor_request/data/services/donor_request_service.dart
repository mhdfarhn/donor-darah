import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/donor_request_model.dart';

class DonorRequestService {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('donorRequests');

  Future<String> createDonorRequest(DonorRequestModel requestDonor) async {
    try {
      String uid = _collectionReference.doc().id;
      await _collectionReference.doc(uid).set(
            requestDonor
                .copyWith(
                  uid: uid,
                  bloodType: requestDonor.bloodType,
                  phoneNumber: requestDonor.phoneNumber,
                  location: requestDonor.location,
                  active: requestDonor.active,
                  createdAt: requestDonor.createdAt,
                  updatedAt: requestDonor.updatedAt,
                )
                .toMap(),
          );

      return uid;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DonorRequestModel>> getCurrentUserDonorRequests() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String email = user!.email!;

    try {
      QuerySnapshot snapshot = await _collectionReference
          .where('email', isEqualTo: email)
          .orderBy('createdAt', descending: true)
          .get();
      List<QueryDocumentSnapshot> docs = snapshot.docs;

      List<DonorRequestModel> donorRequests = <DonorRequestModel>[];
      if (docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in docs) {
          donorRequests.add(DonorRequestModel.fromSnapshot(doc));
        }
      }

      return donorRequests;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DonorRequestModel>> getDonorRequests(bool active) async {
    try {
      QuerySnapshot snapshot = await _collectionReference
          .where('active', isEqualTo: active)
          .orderBy('createdAt', descending: true)
          .get();
      List<QueryDocumentSnapshot> docs = snapshot.docs;

      List<DonorRequestModel> donorRequests = <DonorRequestModel>[];
      if (docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in docs) {
          donorRequests.add(DonorRequestModel.fromSnapshot(doc));
        }
      }

      return donorRequests;
    } catch (e) {
      throw e.toString();
    }
  }
}
