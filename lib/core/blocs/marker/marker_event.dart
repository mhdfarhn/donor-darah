part of 'marker_bloc.dart';

abstract class MarkerEvent extends Equatable {
  const MarkerEvent();

  @override
  List<Object> get props => [];
}

class LoadMarkers extends MarkerEvent {}

class UpdateMarkers extends MarkerEvent {
  final LatLng position;

  const UpdateMarkers(this.position);

  @override
  List<Object> get props => [position];
}
