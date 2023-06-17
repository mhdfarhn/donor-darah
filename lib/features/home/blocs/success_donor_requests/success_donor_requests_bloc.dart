import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/constants/constants.dart';
import '../../../donor_request/data/models/donor_request_model.dart';
import '../../../donor_request/data/services/donor_request_service.dart';

part 'success_donor_requests_event.dart';
part 'success_donor_requests_state.dart';

class SuccessDonorRequestsBloc
    extends Bloc<SuccessDonorRequestsEvent, SuccessDonorRequestsState> {
  final DonorRequestService _donorRequest = DonorRequestService();

  SuccessDonorRequestsBloc() : super(SuccessDonorRequestsInitial()) {
    on<LoadSuccessDonorRequests>((event, emit) async {
      emit(SuccessDonorRequestsLoading());
      try {
        List<DonorRequestModel> donorRequests =
            await _donorRequest.getDonorRequests(false);

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

        emit(SuccessDonorRequestsLoaded(donorRequests, distances));
      } catch (e) {
        emit(SuccessDonorRequestsError(e.toString()));
      }
    });
  }
}
