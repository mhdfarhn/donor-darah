import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/potential_donor_service/potential_donor_service.dart';

part 'potential_donor_state.dart';

class PotentialDonorCubit extends Cubit<PotentialDonorState> {
  final PotentialDonorService _service;

  PotentialDonorCubit(this._service) : super(PotentialDonorInitial());

  Future<void> loadPotentialDonor() async {
    emit(PotentialDonorLoading());
    try {
      final results = await _service.getPotentialDonorInfo();
      emit(PotentialDonorLoaded(results));
    } catch (e) {
      emit(PotentialDonorError(e.toString()));
    }
  }
}
