import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/core/data/models/directions_model.dart';
import 'package:donor_darah/core/data/models/step_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api_key.dart';

class DirectionsApi {
  final String endpointUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  Future<DirectionsModel> request(GeoPoint destination, GeoPoint origin) async {
    Uri endpointUri = Uri.parse(
        '${endpointUrl}destination=${destination.latitude},${destination.longitude}&origin=${origin.latitude},${origin.longitude}&key=${ApiKey.googleMaps}');

    DirectionsModel result = const DirectionsModel(
      startLocation: LatLng(0, 0),
      endLocation: LatLng(0, 0),
      directions: <StepModel>[],
    );
    try {
      final http.Response response = await http.get(endpointUri);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        List<StepModel> steps = <StepModel>[];
        for (var step in responseBody['routes'][0]['legs'][0]['steps']) {
          steps.add(
            StepModel(
              distanceText: step['distance']['text'],
              distanceValue: step['distance']['value'],
              durationText: step['duration']['text'],
              durationValue: step['duration']['value'],
              startLocation: LatLng(
                step['start_location']['lat'],
                step['start_location']['lng'],
              ),
              endLocation: LatLng(
                step['end_location']['lat'],
                step['end_location']['lng'],
              ),
            ),
          );
        }

        result = DirectionsModel(
          startLocation: LatLng(
            responseBody['routes'][0]['legs'][0]['start_location']['lat'],
            responseBody['routes'][0]['legs'][0]['start_location']['lng'],
          ),
          endLocation: LatLng(
            responseBody['routes'][0]['legs'][0]['end_location']['lat'],
            responseBody['routes'][0]['legs'][0]['end_location']['lng'],
          ),
          directions: steps,
        );
      }
      return result;
    } catch (e) {
      throw e.toString();
    }
  }
}
