part of 'position_bloc.dart';

abstract class PositionState extends Equatable {
  const PositionState();

  @override
  List<Object> get props => [];
}

class PositionInitial extends PositionState {}

class PositionLoading extends PositionState {}

class PositionLoaded extends PositionState {
  final Position position;

  const PositionLoaded(this.position);

  @override
  List<Object> get props => [position];
}

class PositionError extends PositionState {
  final String error;

  const PositionError(this.error);

  @override
  List<Object> get props => [error];
}
