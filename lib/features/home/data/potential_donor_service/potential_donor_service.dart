import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/data/models/user_model.dart';

class PotentialDonorService {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<Map<String, int>> getPotentialDonorInfo() async {
    try {
      final snapshot =
          await _collectionReference.where('status', isEqualTo: true).get();
      final docs = snapshot.docs;
      final results = <String, int>{};
      if (docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in docs) {
          final user = UserModel.fromSnapshot(doc);
          if (results.containsKey(user.bloodType)) {
            results[user.bloodType!] = results[user.bloodType]! + 1;
          } else {
            results[user.bloodType!] = 1;
          }
        }
      }

      return results;
    } catch (e) {
      throw e.toString();
    }
  }
}
