part of 'current_user_donor_request_bloc.dart';

abstract class CurrentUserDonorRequestEvent extends Equatable {
  const CurrentUserDonorRequestEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentUserDonorRequest extends CurrentUserDonorRequestEvent {}
