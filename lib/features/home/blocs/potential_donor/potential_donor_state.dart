part of 'potential_donor_cubit.dart';

abstract class PotentialDonorState extends Equatable {
  const PotentialDonorState();

  @override
  List<Object?> get props => [];
}

class PotentialDonorInitial extends PotentialDonorState {}

class PotentialDonorLoading extends PotentialDonorState {}

class PotentialDonorLoaded extends PotentialDonorState {
  final Map<String, int> results;

  const PotentialDonorLoaded(this.results);

  @override
  List<Object?> get props => [results];
}

class PotentialDonorError extends PotentialDonorState {
  final String error;

  const PotentialDonorError(this.error);

  @override
  List<Object?> get props => [error];
}
