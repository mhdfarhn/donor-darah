part of 'maps_bloc.dart';

abstract class MapsEvent extends Equatable {
  const MapsEvent();

  @override
  List<Object> get props => [];
}

class LoadMaps extends MapsEvent {}
