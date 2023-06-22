part of 'current_user_donor_request_bloc.dart';

abstract class CurrentUserDonorRequestState extends Equatable {
  const CurrentUserDonorRequestState();

  @override
  List<Object> get props => [];
}

class CurrentUserDonorRequestInitial extends CurrentUserDonorRequestState {}

class CurrentUserDonorRequestLoding extends CurrentUserDonorRequestState {}

class CurrentUserDonorRequestLoaded extends CurrentUserDonorRequestState {
  final List<DonorRequestModel> donorRequests;

  const CurrentUserDonorRequestLoaded(this.donorRequests);

  @override
  List<Object> get props => [donorRequests];
}

class CurrentUserDonorRequestError extends CurrentUserDonorRequestState {
  final String error;

  const CurrentUserDonorRequestError(this.error);

  @override
  List<Object> get props => [error];
}
