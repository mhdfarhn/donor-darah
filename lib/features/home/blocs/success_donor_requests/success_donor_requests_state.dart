part of 'success_donor_requests_bloc.dart';

abstract class SuccessDonorRequestsState extends Equatable {
  const SuccessDonorRequestsState();

  @override
  List<Object> get props => [];
}

class SuccessDonorRequestsInitial extends SuccessDonorRequestsState {}

class SuccessDonorRequestsError extends SuccessDonorRequestsState {
  final String error;

  const SuccessDonorRequestsError(this.error);

  @override
  List<Object> get props => [error];
}

class SuccessDonorRequestsLoading extends SuccessDonorRequestsState {}

class SuccessDonorRequestsLoaded extends SuccessDonorRequestsState {
  final List<DonorRequestModel> donorRequests;
  final List<double> distances;

  const SuccessDonorRequestsLoaded(this.donorRequests, this.distances);

  @override
  List<Object> get props => [donorRequests, distances];
}
