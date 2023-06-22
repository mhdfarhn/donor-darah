part of 'donor_history_bloc.dart';

abstract class DonorHistoryEvent extends Equatable {
  const DonorHistoryEvent();

  @override
  List<Object> get props => [];
}

class CreateDonorHistory extends DonorHistoryEvent {
  final String email;
  final Timestamp date;
  final String location;

  const CreateDonorHistory({
    required this.email,
    required this.date,
    required this.location,
  });

  @override
  List<Object> get props => [
        email,
        date,
        location,
      ];
}

class LoadDonorHistories extends DonorHistoryEvent {}
