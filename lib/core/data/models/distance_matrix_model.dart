class DistanceMatrixModel {
  final String destinationAddress;
  final String originAddress;
  final String distanceInKilometers;
  final int distanceInMeters;
  final String durationInMinutes;
  final int durationInSeconds;

  const DistanceMatrixModel({
    required this.destinationAddress,
    required this.originAddress,
    required this.distanceInKilometers,
    required this.distanceInMeters,
    required this.durationInMinutes,
    required this.durationInSeconds,
  });
}
