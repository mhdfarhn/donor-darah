import 'package:google_maps_flutter/google_maps_flutter.dart';

class StepModel {
  final String distanceText;
  final int distanceValue;
  final String durationText;
  final int durationValue;
  final LatLng startLocation;
  final LatLng endLocation;

  const StepModel({
    required this.distanceText,
    required this.distanceValue,
    required this.durationText,
    required this.durationValue,
    required this.startLocation,
    required this.endLocation,
  });
}
