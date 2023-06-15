import 'package:donor_darah/core/data/models/step_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsModel {
  final LatLng startLocation;
  final LatLng endLocation;
  // final double startLatitude;
  // final double startLongitude;
  // final double endLatitude;
  // final double endLongitude;
  final List<StepModel> directions;

  const DirectionsModel({
    required this.startLocation,
    required this.endLocation,
    // required this.startLatitude,
    // required this.startLongitude,
    // required this.endLatitude,
    // required this.endLongitude,
    required this.directions,
  });
}
