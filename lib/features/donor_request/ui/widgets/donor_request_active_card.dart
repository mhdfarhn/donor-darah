import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/constants.dart';
import '../../data/models/donor_request_model.dart';

class DonorRequestActiveCard extends StatelessWidget {
  final DonorRequestModel donorRequest;
  final String distanceInKilometer;
  final String distanceInMeter;
  final int index;

  const DonorRequestActiveCard({
    super.key,
    required this.donorRequest,
    required this.distanceInKilometer,
    required this.distanceInMeter,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        bottom: index != 2 ? 8.0.h : 0.0,
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
                  AppFunction.date(donorRequest.createdAt),
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
