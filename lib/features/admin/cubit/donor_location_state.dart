part of 'donor_location_cubit.dart';

abstract class DonorLocationState extends Equatable {
  const DonorLocationState();

  @override
  List<Object> get props => [];
}

class DonorLocationInitial extends DonorLocationState {}

class DonorLocationLoading extends DonorLocationState {}

class DonorLocationsLoaded extends DonorLocationState {
  final List<DonorLocationModel> locations;

  const DonorLocationsLoaded(this.locations);

  @override
  List<Object> get props => [locations];
}

class DonorLocationCreated extends DonorLocationState {}

class DonorLocationError extends DonorLocationState {
  final String error;

  const DonorLocationError(this.error);

  @override
  List<Object> get props => [error];
}
