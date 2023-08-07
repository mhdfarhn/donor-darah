import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../donor_request/data/models/donor_request_model.dart';
import '../../../donor_request/data/services/donor_request_service.dart';

part 'current_user_donor_request_event.dart';
part 'current_user_donor_request_state.dart';

class CurrentUserDonorRequestBloc
    extends Bloc<CurrentUserDonorRequestEvent, CurrentUserDonorRequestState> {
  final DonorRequestService _donorRequest = DonorRequestService();

  CurrentUserDonorRequestBloc() : super(CurrentUserDonorRequestInitial()) {
    on<LoadCurrentUserDonorRequest>((event, emit) async {
      emit(CurrentUserDonorRequestLoding());
      try {
        List<DonorRequestModel> requests =
            await _donorRequest.getCurrentUserDonorRequests();

        emit(CurrentUserDonorRequestLoaded(requests));
      } catch (e) {
        emit(CurrentUserDonorRequestError(e.toString()));
      }
    });

    on<UpdateCurrentUserDonorReequest>((event, emit) async {
      emit(CurrentUserDonorRequestLoding());
      try {
        await _donorRequest.updateDonorRequestActive(event.donorRequest);

        List<DonorRequestModel> requests =
            await _donorRequest.getCurrentUserDonorRequests();

        emit(CurrentUserDonorRequestLoaded(requests));
      } catch (e) {
        emit(CurrentUserDonorRequestError(e.toString()));
      }
    });
  }
}
