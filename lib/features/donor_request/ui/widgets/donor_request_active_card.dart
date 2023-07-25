import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/constants.dart';
import '../../data/models/donor_request_model.dart';

class DonorRequestCard extends StatelessWidget {
  final bool active;
  final DonorRequestModel donorRequest;
  final String distanceInKilometer;
  final String distanceInMeter;
  final int index;
  final int maxIndex;

  const DonorRequestCard({
    super.key,
    required this.active,
    required this.donorRequest,
    required this.distanceInKilometer,
    required this.distanceInMeter,
    required this.index,
    required this.maxIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        bottom: maxIndex == 2
            ? index != 2
                ? 8.0.h
                : 0.0
            : 8.0.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.0.h,
          horizontal: 16.0.w,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColor.grey,
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                  fontSize: AppFontSize.body,
                  color: AppColor.red,
                ),
              ),
            ),
            SizedBox(width: 16.0.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama: ${donorRequest.name!}'),
                Text('Darah dibutuhkan: ${donorRequest.bloodType}'),
                Text('Jarak: $distanceInKilometer km ($distanceInMeter m)'),
                Text(
                  AppFunction.date(
                      active ? donorRequest.createdAt : donorRequest.updatedAt),
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
