import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/data/models/user_model.dart';

class ResultModel {
  final UserModel donor;
  final Marker marker;
  final double slocDistance;

  const ResultModel({
    required this.donor,
    required this.marker,
    required this.slocDistance,
  });
}
