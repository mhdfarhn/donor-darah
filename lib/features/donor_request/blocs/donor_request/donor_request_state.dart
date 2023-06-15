part of 'donor_request_bloc.dart';

abstract class DonorRequestState extends Equatable {
  const DonorRequestState();

  @override
  List<Object> get props => [];
}

class DonorRequestInitial extends DonorRequestState {}

class DonorRequestLoading extends DonorRequestState {}

class DonorRequestLoaded extends DonorRequestState {
  final List<DonorRequestModel> donorRequests;
  final List<double> distances;

  const DonorRequestLoaded(this.donorRequests, this.distances);

  @override
  List<Object> get props => [donorRequests, distances];
}

class DonorRequestSuccess extends DonorRequestState {
  final List<ResultModel> results;
  final GeoPoint requestLocation;

  const DonorRequestSuccess(this.results, this.requestLocation);

  @override
  List<Object> get props => [results, requestLocation];
}

class DonorRequestError extends DonorRequestState {
  final String error;

  const DonorRequestError(this.error);

  @override
  List<Object> get props => [error];
}
