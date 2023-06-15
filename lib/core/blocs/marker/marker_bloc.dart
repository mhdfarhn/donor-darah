import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'marker_event.dart';
part 'marker_state.dart';

class MarkerBloc extends Bloc<MarkerEvent, MarkerState> {
  MarkerBloc() : super(MarkerLoading()) {
    on<LoadMarkers>((event, emit) async {});
    on<UpdateMarkers>((event, emit) {
      emit(MarkerLoading());

      Set<Marker> markers = <Marker>{
        Marker(
          markerId: const MarkerId('location'),
          position: event.position,
          infoWindow: InfoWindow(
            title: 'Lokasi Anda',
            snippet:
                'Lat: ${event.position.latitude}, Long: ${event.position.longitude}',
          ),
        ),
      };

      emit(MarkerLoaded(markers));
    });
  }
}
