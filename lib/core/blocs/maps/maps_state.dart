part of 'maps_bloc.dart';

abstract class MapsState extends Equatable {
  const MapsState();

  @override
  List<Object> get props => [];
}

class MapsInitial extends MapsState {}

class MapsLoading extends MapsState {}

class MapsLoaded extends MapsState {
  final Set<Marker> markers;
  final Set<Circle> circles;
  final LatLng target;

  const MapsLoaded({
    required this.markers,
    required this.circles,
    required this.target,
  });

  @override
  List<Object> get props => [markers, circles, target];
}

class MapsError extends MapsState {
  final String error;

  const MapsError(this.error);

  @override
  List<Object> get props => [error];
}
