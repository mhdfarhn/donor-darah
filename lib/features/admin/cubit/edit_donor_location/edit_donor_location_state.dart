part of 'edit_donor_location_cubit.dart';

abstract class EditDonorLocationState extends Equatable {
  const EditDonorLocationState();

  @override
  List<Object> get props => [];
}

class EditDonorLocationInitial extends EditDonorLocationState {}

class EditDonorLocationLoading extends EditDonorLocationState {}

class EditDonorLocationLoaded extends EditDonorLocationState {
  final DonorLocationModel location;

  const EditDonorLocationLoaded(this.location);

  @override
  List<Object> get props => [location];
}

class EditDonorLocationUpdated extends EditDonorLocationState {}

class EditDonorLocationDeleted extends EditDonorLocationState {}

class EditDonorLocationError extends EditDonorLocationState {
  final String error;

  const EditDonorLocationError(this.error);

  @override
  List<Object> get props => [error];
}
