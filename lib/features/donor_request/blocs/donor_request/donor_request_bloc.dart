import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/data/models/models.dart';
import '../../../../core/data/services/firebase/firebases.dart';
import '../../../donor_request/data/models/donor_request_model.dart';
import '../../../result/data/models/result_model.dart';

part 'donor_request_event.dart';
part 'donor_request_state.dart';

class DonorRequestBloc extends Bloc<RequestDonorEvent, DonorRequestState> {
  final DonorRequestService _donorRequest = DonorRequestService();
  final FirestoreService _firestore = FirestoreService();

  DonorRequestBloc() : super(DonorRequestInitial()) {
    on<RequestDonor>((event, emit) async {
      emit(DonorRequestLoading());
      try {
        final User? firebaseUser = FirebaseAuth.instance.currentUser;

        final UserModel user = await _firestore.getUser(firebaseUser!.email!);

        final String uid = await _donorRequest.createDonorRequest(
          event.requestDonor.copyWith(
            email: user.email,
            name: user.name,
            bloodType: event.requestDonor.bloodType,
            phoneNumber: event.requestDonor.phoneNumber,
            location: event.requestDonor.location,
            active: event.requestDonor.active,
            createdAt: event.requestDonor.createdAt,
            updatedAt: event.requestDonor.updatedAt,
          ),
        );

        List<UserModel> donors =
            await _firestore.getDonorsByBloodType(event.requestDonor.bloodType);

        List<ResultModel> results = <ResultModel>[];
        if (donors.isNotEmpty) {
          for (UserModel donor in donors) {
            double sloc = AppFunction.sloc(
              startLatitude: event.requestDonor.location.latitude,
              startLongitude: event.requestDonor.location.longitude,
              endLatitude: donor.location!.latitude,
              endLongitude: donor.location!.longitude,
            );
            if (sloc <= 10000) {
              final String gender = donor.gender!;
              final int age = AppFunction.getAge(donor.dateOfBirth!);
              final String distanceInKilometer =
                  (sloc / 1000).toStringAsFixed(2);
              final String distanceInMeter = sloc.toStringAsFixed(2);
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
                        title: '${donor.name} ($gender, $age tahun)',
                        snippet: '$distanceInKilometer km ($distanceInMeter m)'
                        // title: '${(sloc / 1000).toStringAsFixed(2)} km',
                        // snippet: '${sloc.toStringAsFixed(2)} m',
                        ),
                  ),
                  slocDistance: sloc,
                ),
              );
            }
          }
        }
        // Sort results
        results.sort((a, b) => a.slocDistance.compareTo(b.slocDistance));

        emit(DonorRequestSuccess(
          donorRequestId: uid,
          results: results,
          requestLocation: event.requestDonor.location,
        ));
      } catch (e) {
        emit(DonorRequestError(e.toString()));
      }
    });
  }
}
