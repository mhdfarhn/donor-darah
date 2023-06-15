part of 'donor_history_bloc.dart';

abstract class DonorHistoryEvent extends Equatable {
  const DonorHistoryEvent();

  @override
  List<Object> get props => [];
}

class CreateDonorHistory extends DonorHistoryEvent {
  final Timestamp date;
  final String location;

  const CreateDonorHistory({
    required this.date,
    required this.location,
  });

  @override
  List<Object> get props => [date, location];
}

class LoadDonorHistories extends DonorHistoryEvent {}
