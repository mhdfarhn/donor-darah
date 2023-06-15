import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/constants.dart';

class MapField extends StatelessWidget {
  final Completer<GoogleMapController> controller;
  final GeoPoint location;
  final Set<Marker> markers;
  final Function(LatLng) onLongPress;

  const MapField({
    Key? key,
    required this.controller,
    required this.location,
    required this.markers,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lokasi',
          style: TextStyle(
            color: AppColor.brown,
            fontSize: AppFontSize.body,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Tekan dan tahan pada peta untuk memperbarui lokasi',
          style: TextStyle(
            fontSize: AppFontSize.caption,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8.0.h),
        AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  location.latitude,
                  location.longitude,
                ),
                zoom: 13,
              ),
              myLocationEnabled: true,
              markers: markers,
              gestureRecognizers: <Factory<PanGestureRecognizer>>{}..add(
                  Factory<PanGestureRecognizer>(
                    () => PanGestureRecognizer(),
                  ),
                ),
              onLongPress: onLongPress,
              onMapCreated: (GoogleMapController googleMapController) {
                controller.complete(googleMapController);
              },
            ),
          ),
        ),
      ],
    );
  }
}
