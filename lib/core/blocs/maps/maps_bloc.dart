import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/constants.dart';
import '../../../core/data/models/user_model.dart';
import '../../../core/data/services/firebase/firestore_service.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  final FirestoreService _firestore = FirestoreService();

  MapsBloc() : super(MapsLoading()) {
    on<LoadMaps>((event, emit) async {
      emit(MapsLoading());
      try {
        List<UserModel> users = await _firestore.getDonors();
        Position position = await AppFunction.getCurrentPosition();

        LatLng target = LatLng(position.latitude, position.longitude);

        Set<Marker> markers = <Marker>{};
        if (users.isNotEmpty) {
          for (UserModel user in users) {
            int age = AppFunction.getAge(user.dateOfBirth!);

            markers.add(
              Marker(
                markerId: MarkerId(user.email),
                position: LatLng(
                  user.location!.latitude,
                  user.location!.longitude,
                ),
                infoWindow: InfoWindow(
                  title: user.bloodType,
                  snippet: '${user.gender}, $age tahun',
                ),
              ),
            );
          }
        }

        Set<Circle> circles = <Circle>{
          Circle(
            circleId: const CircleId('current-position'),
            center: target,
            fillColor: AppColor.red.withOpacity(0.1),
            strokeColor: AppColor.red.withOpacity(0.5),
            strokeWidth: 1,
            radius: 10000,
          ),
        };

        emit(MapsLoaded(
          markers: markers,
          circles: circles,
          target: target,
        ));
      } catch (e) {
        emit(MapsError(e.toString()));
      }
    });
  }
}
