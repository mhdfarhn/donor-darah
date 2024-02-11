import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/donor_location_model.dart';
import '../data/donor_location_service.dart';

part 'donor_location_state.dart';

class DonorLocationCubit extends Cubit<DonorLocationState> {
  final DonorLocationService _service;

  DonorLocationCubit(this._service) : super(DonorLocationInitial());

  Future<void> createDonorLocation(DonorLocationModel location) async {
    emit(DonorLocationLoading());
    try {
      await _service.createDonorLocation(location);
      emit(DonorLocationCreated());
    } catch (e) {
      emit(DonorLocationError(e.toString()));
    }
  }

  Future<void> getDonorLocations() async {
    emit(DonorLocationLoading());
    try {
      final locations = await _service.getDonorLocations();

      emit(DonorLocationsLoaded(locations));
    } catch (e) {
      emit(DonorLocationError(e.toString()));
    }
  }

  Future<void> getActiveDonorLocations() async {
    emit(DonorLocationLoading());
    try {
      final locations = await _service.getActiveDonorLocations();
      emit(DonorLocationsLoaded(locations));
    } catch (e) {
      emit(DonorLocationError(e.toString()));
    }
  }
}
