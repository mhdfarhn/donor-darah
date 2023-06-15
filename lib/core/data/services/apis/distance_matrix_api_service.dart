import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../../../constants/api_key.dart';
import '../../models/models.dart';

class DistanceMatrixApi {
  final String endpointUrl =
      'https://maps.googleapis.com/maps/api/distancematrix/json?';

  Future<List<DistanceMatrixModel>> request(
      GeoPoint origin, List<GeoPoint> destinations) async {
    List<DistanceMatrixModel> results = <DistanceMatrixModel>[];

    String sDestinations = '';
    for (GeoPoint destination in destinations) {
      sDestinations += destination.latitude.toString();
      sDestinations += ',';
      sDestinations += destination.longitude.toString();
      sDestinations += '|';
    }

    Uri endpointUri = Uri.parse(
        '${endpointUrl}destinations=$sDestinations&origins=${origin.latitude},${origin.longitude}&key=${ApiKey.googleMaps}');

    try {
      final http.Response response = await http.get(endpointUri);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        for (int i = 0; i < destinations.length; i++) {
          results.add(
            DistanceMatrixModel(
              destinationAddress: responseBody['destination_addresses'][i],
              originAddress: responseBody['origin_addresses'][0],
              distanceInKilometers: responseBody['rows'][0]['elements'][i]
                  ['distance']['text'],
              distanceInMeters: responseBody['rows'][0]['elements'][i]
                  ['distance']['value'],
              durationInMinutes: responseBody['rows'][0]['elements'][i]
                  ['duration']['text'],
              durationInSeconds: responseBody['rows'][0]['elements'][i]
                  ['duration']['value'],
            ),
          );
        }
      }

      return results;
    } catch (e) {
      throw e.toString();
    }
  }
}
