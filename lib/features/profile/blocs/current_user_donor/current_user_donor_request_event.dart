part of 'current_user_donor_request_bloc.dart';

abstract class CurrentUserDonorRequestEvent extends Equatable {
  const CurrentUserDonorRequestEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentUserDonorRequest extends CurrentUserDonorRequestEvent {}

class UpdateCurrentUserDonorReequest extends CurrentUserDonorRequestEvent {
  final DonorRequestModel donorRequest;

  const UpdateCurrentUserDonorReequest(this.donorRequest);

  @override
  List<Object> get props => [donorRequest];
}
