import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/constants.dart';
import '../../data/models/donor_request_model.dart';

class DonorRequestCard extends StatefulWidget {
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
  State<DonorRequestCard> createState() => _DonorRequestCardState();
}

class _DonorRequestCardState extends State<DonorRequestCard> {
  bool _hasCallSupport = false;

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        bottom: widget.maxIndex == 2
            ? widget.index != 2
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.grey,
                  child: Text(
                    (widget.index + 1).toString(),
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
                    Text('Nama: ${widget.donorRequest.name!}'),
                    Text('Darah dibutuhkan: ${widget.donorRequest.bloodType}'),
                    Text(
                        'Jarak: ${widget.distanceInKilometer} km (${widget.distanceInMeter} m)'),
                    Text(
                      AppFunction.date(widget.active
                          ? widget.donorRequest.createdAt
                          : widget.donorRequest.updatedAt),
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: _hasCallSupport
                  ? () => setState(() {
                        AppFunction.makePhoneCall(
                            widget.donorRequest.phoneNumber);
                      })
                  : null,
              child: const CircleAvatar(
                backgroundColor: AppColor.grey,
                child: FaIcon(
                  FontAwesomeIcons.phone,
                  color: AppColor.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
