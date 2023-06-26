part of 'donor_request_bloc.dart';

abstract class DonorRequestState extends Equatable {
  const DonorRequestState();

  @override
  List<Object> get props => [];
}

class DonorRequestInitial extends DonorRequestState {}

class DonorRequestLoading extends DonorRequestState {}

class DonorRequestSuccess extends DonorRequestState {
  final String donorRequestId;
  final List<ResultModel> results;
  final GeoPoint requestLocation;

  const DonorRequestSuccess({
    required this.donorRequestId,
    required this.results,
    required this.requestLocation,
  });

  @override
  List<Object> get props => [donorRequestId, results, requestLocation];
}

class DonorRequestError extends DonorRequestState {
  final String error;

  const DonorRequestError(this.error);

  @override
  List<Object> get props => [error];
}
