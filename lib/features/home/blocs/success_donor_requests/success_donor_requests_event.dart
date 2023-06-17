part of 'success_donor_requests_bloc.dart';

abstract class SuccessDonorRequestsEvent extends Equatable {
  const SuccessDonorRequestsEvent();

  @override
  List<Object> get props => [];
}

class LoadSuccessDonorRequests extends SuccessDonorRequestsEvent {}
