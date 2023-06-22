part of 'active_donor_requests_bloc.dart';

abstract class ActiveDonorRequestsEvent extends Equatable {
  const ActiveDonorRequestsEvent();

  @override
  List<Object> get props => [];
}

class LoadActiveDonorRequests extends ActiveDonorRequestsEvent {}
