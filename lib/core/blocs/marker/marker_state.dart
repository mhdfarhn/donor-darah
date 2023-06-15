part of 'marker_bloc.dart';

abstract class MarkerState extends Equatable {
  const MarkerState();

  @override
  List<Object> get props => [];
}

class MarkerLoading extends MarkerState {}

class MarkerLoaded extends MarkerState {
  final Set<Marker> markers;

  const MarkerLoaded(this.markers);

  @override
  List<Object> get props => [markers];
}

class MarkerError extends MarkerState {
  final String error;

  const MarkerError(this.error);

  @override
  List<Object> get props => [error];
}
