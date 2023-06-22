import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/constants/app_function.dart';
import '../../../donor_request/data/models/donor_request_model.dart';
import '../../../donor_request/data/services/donor_request_service.dart';

part 'active_donor_requests_event.dart';
part 'active_donor_requests_state.dart';

class ActiveDonorRequestsBloc
    extends Bloc<ActiveDonorRequestsEvent, ActiveDonorRequestsState> {
  final DonorRequestService _donorRequest = DonorRequestService();

  ActiveDonorRequestsBloc() : super(ActiveDonorRequestsInitial()) {
    on<LoadActiveDonorRequests>((event, emit) async {
      emit(ActiveDonorRequestsLoading());
      try {
        List<DonorRequestModel> donorRequests =
            await _donorRequest.getDonorRequests(true);

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

        emit(ActiveDonorRequestsLoaded(donorRequests, distances));
      } catch (e) {
        emit(ActiveDonorRequestsError(e.toString()));
      }
    });
  }
}
