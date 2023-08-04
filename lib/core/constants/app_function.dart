import 'dart:math';

import 'package:age_calculator/age_calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_math/vector_math.dart';

import '../utils/enums.dart';

class AppFunction {
  static String date(Timestamp date) {
    final String year = DateFormat.y().format(
        DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch));
    final String month = DateFormat.M().format(
        DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch));
    final String day = DateFormat.d().format(
        DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch));
    return '$day/$month/$year';
  }

  static int getAge(Timestamp dateOfBirth) {
    DateTime birthDate =
        DateTime.fromMicrosecondsSinceEpoch(dateOfBirth.microsecondsSinceEpoch);
    DateDuration duration = AgeCalculator.age(birthDate);

    int age = duration.years;
    return age;
  }

  static Future<Position> getCurrentPosition() async {
    // bool serviceEnabled;
    // LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }

    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Future.error('Location permissions are denied');
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }
    await getLocationPermission();

    return await Geolocator.getCurrentPosition();
  }

  static Future<void> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  static bool isLatestTimestamp(Timestamp newTime, Timestamp lastTime) {
    final DateTime after =
        DateTime.fromMicrosecondsSinceEpoch(newTime.microsecondsSinceEpoch);
    final DateTime before =
        DateTime.fromMicrosecondsSinceEpoch(lastTime.microsecondsSinceEpoch);
    return after.isAfter(before);
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static String notificationCategory(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.donorRequest:
        return 'donor-request';
      case NotificationCategory.requestAccepted:
        return 'request-accepted';
      case NotificationCategory.requestRejected:
        return 'request-rejected';
      default:
        return 'default';
    }
  }

  static double sloc({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    double rStartLatitude = radians(startLatitude);
    double rStartLongitude = radians(startLongitude);
    double rEndLatitude = radians(endLatitude);
    double rEndLongitude = radians(endLongitude);
    double radius = 6371000;

    double distance = acos(sin(rStartLatitude) * sin(rEndLatitude) +
            cos(rStartLatitude) *
                cos(rEndLatitude) *
                cos(rEndLongitude - rStartLongitude)) *
        radius;

    return distance;
  }
}
