import 'package:donor_darah/core/constants/app_function.dart';
import 'package:donor_darah/core/data/models/user_model.dart';
import 'package:donor_darah/core/data/services/firebase/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:donor_darah/features/result/data/models/result_model.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'recomendation_state.dart';

class RecomendationCubit extends Cubit<RecomendationState> {
  final FirestoreService _firestore;
  RecomendationCubit(this._firestore) : super(RecomendationInitial());

  Future<void> getRecomendation() async {
    emit(RecomendationLoading());
    try {
      Position position = await AppFunction.getCurrentPosition();

      final User? firebaseUser = FirebaseAuth.instance.currentUser;

      final UserModel user = await _firestore.getUser(firebaseUser!.email!);

      List<UserModel> donors = <UserModel>[];
      if (user.bloodType != null) {
        donors = await _firestore.getDonorsByBloodType(user.bloodType!);
      } else {
        donors = await _firestore.getDonors();
      }

      List<ResultModel> results = <ResultModel>[];
      if (donors.isNotEmpty) {
        for (UserModel donor in donors) {
          double sloc = AppFunction.sloc(
            startLatitude: position.latitude,
            startLongitude: position.longitude,
            endLatitude: donor.location!.latitude,
            endLongitude: donor.location!.longitude,
          );
          results.add(
            ResultModel(
              donor: donor,
              marker: Marker(
                markerId: MarkerId(donor.email),
                position: LatLng(
                  donor.location!.latitude,
                  donor.location!.longitude,
                ),
                infoWindow: InfoWindow(
                  title: '${(sloc / 1000).toStringAsFixed(2)} km',
                  snippet: '${sloc.toStringAsFixed(2)} m',
                ),
              ),
              slocDistance: sloc,
            ),
          );
        }
      }
      results.sort((a, b) => a.slocDistance.compareTo(b.slocDistance));
      results.removeRange(3, results.length);
      emit(RecomendationLoaded(results));
    } catch (e) {
      emit(RecomendationError(e.toString()));
    }
  }
}
