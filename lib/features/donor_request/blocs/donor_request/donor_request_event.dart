part of 'donor_request_bloc.dart';

abstract class RequestDonorEvent extends Equatable {
  const RequestDonorEvent();

  @override
  List<Object> get props => [];
}

class LoadDonorRequests extends RequestDonorEvent {}

class RequestDonor extends RequestDonorEvent {
  final DonorRequestModel requestDonor;

  const RequestDonor(this.requestDonor);

  @override
  List<Object> get props => [requestDonor];
}
