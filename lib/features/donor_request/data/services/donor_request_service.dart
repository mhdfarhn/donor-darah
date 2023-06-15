import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/donor_request_model.dart';

class DonorRequestService {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('donorRequests');

  Future<void> createDonorRequest(DonorRequestModel requestDonor) async {
    try {
      String uid = _collectionReference.id;
      _collectionReference.doc(uid).set(
            requestDonor
                .copyWith(
                  uid: uid,
                  bloodType: requestDonor.bloodType,
                  location: requestDonor.location,
                  active: requestDonor.active,
                  createdAt: requestDonor.createdAt,
                  updatedAt: requestDonor.updatedAt,
                )
                .toMap(),
          );
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DonorRequestModel>> getActiveDonorRequests(bool active) async {
    try {
      QuerySnapshot snapshot = await _collectionReference
          .where('active', isEqualTo: true)
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
