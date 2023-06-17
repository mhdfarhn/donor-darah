part of 'active_donor_requests_bloc.dart';

abstract class ActiveDonorRequestsState extends Equatable {
  const ActiveDonorRequestsState();

  @override
  List<Object> get props => [];
}

class ActiveDonorRequestsInitial extends ActiveDonorRequestsState {}

class ActiveDonorRequestsError extends ActiveDonorRequestsState {
  final String error;

  const ActiveDonorRequestsError(this.error);

  @override
  List<Object> get props => [error];
}

class ActiveDonorRequestsLoading extends ActiveDonorRequestsState {}

class ActiveDonorRequestsLoaded extends ActiveDonorRequestsState {
  final List<DonorRequestModel> donorRequests;
  final List<double> distances;

  const ActiveDonorRequestsLoaded(this.donorRequests, this.distances);

  @override
  List<Object> get props => [donorRequests, distances];
}
