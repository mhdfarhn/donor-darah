import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/donor_request_model.dart';
import '../widgets/donor_request_active_card.dart';

class DonorRequestScreen extends StatelessWidget {
  final Map<String, dynamic> extra;

  const DonorRequestScreen({
    super.key,
    required this.extra,
  });

  @override
  Widget build(BuildContext context) {
    final List<DonorRequestModel> donorRequests = extra['donor_requests'];
    final List<double> distances = extra['distances'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Butuh Donor'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0.w,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: List.generate(
            donorRequests.length,
            (index) {
              final DonorRequestModel donorRequest = donorRequests[index];
              final double distance = distances[index];
              final String distanceInKilometer =
                  (distance / 1000).toStringAsFixed(2);
              final String distanceInMeter = distance.toStringAsFixed(2);

              return DonorRequestCard(
                active: true,
                donorRequest: donorRequest,
                distanceInKilometer: distanceInKilometer,
                distanceInMeter: distanceInMeter,
                index: index,
                maxIndex: donorRequests.length - 1,
              );
            },
          )..insert(
              0,
              SizedBox(
                height: 8.0.h,
              ),
            ),
        ),
      ),
    );
  }
}
