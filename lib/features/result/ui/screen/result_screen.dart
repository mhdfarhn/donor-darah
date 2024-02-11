import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/constants.dart';
import '../../data/models/result_model.dart';

// // Notification Imports
// import 'package:donor_darah/core/utils/enums.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../notification/bloc/notification_bloc.dart';
class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> extra;

  const ResultScreen({
    Key? key,
    required this.extra,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _hasCallSupport = false;
  bool _isMap = true;
  final Set<Marker> _markers = <Marker>{};
  final Set<Circle> _circles = <Circle>{};
  Map<String, dynamic> _extra = <String, dynamic>{};
  GeoPoint _requestLocation = const GeoPoint(4.4708759, 97.964298);

  @override
  void initState() {
    super.initState();
    _extra = widget.extra;
    for (var element in _extra['results']) {
      _markers.add(element.marker);
    }
    _requestLocation = _extra['requestLocation'];
    _circles.add(
      Circle(
        circleId: const CircleId('request-location'),
        center: LatLng(_requestLocation.latitude, _requestLocation.longitude),
        fillColor: AppColor.red.withOpacity(0.1),
        strokeColor: AppColor.red.withOpacity(0.5),
        strokeWidth: 1,
        radius: 10000,
      ),
    );
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            context.goNamed('home');
          },
        ),
        title: const Text('Hasil'),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 16.0.w),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: _isMap ? AppColor.brown : AppColor.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isMap = true;
                    });
                  },
                  child: Text(
                    'Peta',
                    style: TextStyle(
                      fontSize: AppFontSize.body,
                      fontWeight: FontWeight.bold,
                      color: _isMap ? AppColor.grey : AppColor.brown,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0.w),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: _isMap ? AppColor.grey : AppColor.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _isMap = false;
                    });
                  },
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: AppFontSize.body,
                      fontWeight: FontWeight.bold,
                      color: _isMap ? AppColor.brown : AppColor.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0.w),
            ],
          ),
          Expanded(
            child: _isMap
                ? GoogleMap(
                    circles: _circles,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _requestLocation.latitude,
                        _requestLocation.longitude,
                      ),
                      zoom: 11.0,
                    ),
                    myLocationEnabled: true,
                    markers: _markers,
                  )
                : ListView(
                    children: List.generate(
                      _extra['results'].length,
                      (index) {
                        final ResultModel result = _extra['results'][index];
                        final String gender = result.donor.gender!;
                        final int age =
                            AppFunction.getAge(result.donor.dateOfBirth!);
                        final String distanceInKilometer =
                            (result.slocDistance / 1000).toStringAsFixed(2);
                        final String distanceInMeter =
                            result.slocDistance.toStringAsFixed(2);

                        // Notification
                        // return BlocListener<NotificationBloc,
                        //     NotificationState>(
                        //   listener: (context, state) {
                        //     if (state is NotificationSending) {
                        //       debugPrint('Mengirim permintaan donor.');
                        //       // showRequestSnackBar(
                        //       //   context,
                        //       //   'Permintaan donor sedang dikirimkan.',
                        //       // );
                        //     } else if (state is NotificationSent) {
                        //       showRequestSnackBar(
                        //         context,
                        //         'Permintaan donor terkirim.',
                        //       );
                        //     } else if (state is NotificationNotSent) {
                        //       showRequestSnackBar(
                        //         context,
                        //         state.message,
                        //       );
                        //     } else if (state is NotificationError) {
                        //       showRequestSnackBar(
                        //         context,
                        //         state.error,
                        //       );
                        //     }
                        //   },
                        return Card(
                          margin: EdgeInsets.only(
                            left: 16.0.w,
                            top: 8.0.h,
                            right: 16.0.w,
                            bottom: index != _extra['results'].length - 1
                                ? 8.0.h
                                : 16.0.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12.0.h,
                              horizontal: 16.0.w,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColor.grey,
                                  child: FaIcon(
                                    FontAwesomeIcons.solidUser,
                                    color: gender != 'Laki-laki'
                                        ? Colors.pink
                                        : Colors.blue,
                                  ),
                                ),
                                SizedBox(width: 16.0.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${result.donor.name} ${index == 0 ? ' (PENDONOR TERDEKAT)' : ''}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('$gender, $age tahun'),
                                      Text(
                                          'Jarak: $distanceInKilometer km ($distanceInMeter m)'),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16.0.w),
                                InkWell(
                                  // onTap: () async {
                                  //   makePhoneCall(result.donor.phoneNumber!);
                                  // },
                                  onTap: _hasCallSupport
                                      ? () => setState(() {
                                            AppFunction.makePhoneCall(
                                                result.donor.phoneNumber!);
                                          })
                                      : null,
                                  child: const FaIcon(
                                    FontAwesomeIcons.phone,
                                  ),
                                  // Notifiction
                                  // onTap: () {
                                  //   context.read<NotificationBloc>().add(
                                  //         SendDonorRequestNotification(
                                  //           donorRequestId:
                                  //               extra['donorRequestId'],
                                  //           receiverEmail: result.donor.email,
                                  //           receiverName: result.donor.name,
                                  //           title: 'Butuh Donor',
                                  //           distance: distanceInKilometer,
                                  //           isAccepted: false,
                                  //           category: NotificationCategory
                                  //               .donorRequest,
                                  //         ),
                                  //       );
                                  // },
                                  //   child: const FaIcon(
                                  //       FontAwesomeIcons.solidPaperPlane),
                                ),
                              ],
                            ),
                          ),
                          // ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

showRequestSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
