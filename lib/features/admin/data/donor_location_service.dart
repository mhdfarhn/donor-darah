import 'package:cloud_firestore/cloud_firestore.dart';

import 'donor_location_model.dart';

class DonorLocationService {
  final _donorLocationsCollection =
      FirebaseFirestore.instance.collection('donorLocations');

  Future<void> createDonorLocation(DonorLocationModel donorLocation) async {
    try {
      final uid = _donorLocationsCollection.doc().id;
      _donorLocationsCollection
          .doc(uid)
          .set(donorLocation.copyWith(uid: uid).toMap());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DonorLocationModel>> getDonorLocations() async {
    try {
      final donorLocationsQuerySnapshot = await _donorLocationsCollection.get();
      List<QueryDocumentSnapshot> docs = donorLocationsQuerySnapshot.docs;

      final donorLocations = <DonorLocationModel>[];
      if (docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in docs) {
          donorLocations.add(DonorLocationModel.fromSnaphsot(doc));
        }
      }
      return donorLocations;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<DonorLocationModel> getDonorLocation(String uid) async {
    try {
      final doc = await _donorLocationsCollection.doc(uid).get();
      final location = DonorLocationModel.fromSnaphsot(doc);

      return location;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<DonorLocationModel>> getActiveDonorLocations() async {
    try {
      final donorLocationsQuerySnapshot = await _donorLocationsCollection
          .where(
            'status',
            isEqualTo: true,
          )
          .get();
      List<QueryDocumentSnapshot> docs = donorLocationsQuerySnapshot.docs;

      final donorLocations = <DonorLocationModel>[];
      if (docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in docs) {
          donorLocations.add(DonorLocationModel.fromSnaphsot(doc));
        }
      }
      return donorLocations;
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateDonorLocation(DonorLocationModel donorLocation) async {
    try {
      _donorLocationsCollection
          .doc(donorLocation.uid)
          .update(donorLocation.toMap());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteDonorLocation(String uid) async {
    try {
      _donorLocationsCollection.doc(uid).delete();
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
