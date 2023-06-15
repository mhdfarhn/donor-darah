import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/data/models/models.dart';
import '../../../../core/data/services/firebase/firebases.dart';
import '../../../result/data/models/result_model.dart';
import '../../../donor_request/data/models/donor_request_model.dart';

part 'donor_request_event.dart';
part 'donor_request_state.dart';

class DonorRequestBloc extends Bloc<RequestDonorEvent, DonorRequestState> {
  final DonorRequestService _donorRequest = DonorRequestService();
  final FirestoreService _firestore = FirestoreService();

  DonorRequestBloc() : super(DonorRequestInitial()) {
    on<LoadDonorRequests>((event, emit) async {
      emit(DonorRequestLoading());
      try {
        List<DonorRequestModel> donorRequests =
            await _donorRequest.getActiveDonorRequests(true);

        Position position = await AppFunction.getCurrentPosition();

        List<double> distances = <double>[];
        for (DonorRequestModel donorRequest in donorRequests) {
          distances.add(
            AppFunction.sloc(
              startLatitude: donorRequest.location.latitude,
              startLongitude: donorRequest.location.longitude,
              endLatitude: position.latitude,
              endLongitude: position.longitude,
            ),
          );
        }

        emit(DonorRequestLoaded(donorRequests, distances));
      } catch (e) {
        emit(DonorRequestError(e.toString()));
      }
    });

    on<RequestDonor>((event, emit) async {
      emit(DonorRequestLoading());
      try {
        final User? firebaseUser = FirebaseAuth.instance.currentUser;

        final UserModel user = await _firestore.getUser(firebaseUser!.email!);

        _donorRequest.createDonorRequest(
          event.requestDonor.copyWith(
            email: user.email,
            name: user.name,
            bloodType: event.requestDonor.bloodType,
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
        emit(DonorRequestSuccess(results, event.requestDonor.location));
      } catch (e) {
        emit(DonorRequestError(e.toString()));
      }
    });
  }
}