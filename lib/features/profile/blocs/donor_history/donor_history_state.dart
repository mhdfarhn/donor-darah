part of 'donor_history_bloc.dart';

abstract class DonorHistoryState extends Equatable {
  const DonorHistoryState();

  @override
  List<Object> get props => [];
}

class DonorHistoryInitial extends DonorHistoryState {}

class DonorHistoryLoading extends DonorHistoryState {}

class DonorHistoryLoaded extends DonorHistoryState {
  final List<DonorHistoryModel> donorHistories;

  const DonorHistoryLoaded(this.donorHistories);

  @override
  List<Object> get props => [donorHistories];
}

class DonorHistoryError extends DonorHistoryState {
  final String error;

  const DonorHistoryError(this.error);

  @override
  List<Object> get props => [error];
}
