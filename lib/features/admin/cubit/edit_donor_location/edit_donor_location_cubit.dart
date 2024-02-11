import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/donor_location_model.dart';
import '../../data/donor_location_service.dart';

part 'edit_donor_location_state.dart';

class EditDonorLocationCubit extends Cubit<EditDonorLocationState> {
  final DonorLocationService _service;
  EditDonorLocationCubit(this._service) : super(EditDonorLocationInitial());

  Future<void> getDonorLocation(String uid) async {
    emit(EditDonorLocationLoading());
    try {
      final location = await _service.getDonorLocation(uid);
      emit(EditDonorLocationLoaded(location));
    } catch (e) {
      emit(EditDonorLocationError(e.toString()));
    }
  }

  Future<void> updateDonorLocation(DonorLocationModel location) async {
    emit(EditDonorLocationLoading());
    try {
      await _service.updateDonorLocation(location);
      emit(EditDonorLocationUpdated());
    } catch (e) {
      emit(EditDonorLocationError(e.toString()));
    }
  }

  Future<void> deleteDonorLocation(String uid) async {
    emit(EditDonorLocationLoading());
    try {
      await _service.deleteDonorLocation(uid);
      emit(EditDonorLocationDeleted());
    } catch (e) {
      emit(EditDonorLocationError(e.toString()));
    }
  }
}
