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
  bool isMap = true;
  Set<Marker> markers = <Marker>{};
  Map<String, dynamic> extra = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    extra = widget.extra;
    for (var element in extra['results']) {
      markers.add(element.marker);
    }
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
                    backgroundColor: isMap ? AppColor.brown : AppColor.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isMap = true;
                    });
                  },
                  child: Text(
                    'Peta',
                    style: TextStyle(
                      fontSize: AppFontSize.body,
                      fontWeight: FontWeight.bold,
                      color: isMap ? AppColor.grey : AppColor.brown,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0.w),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: isMap ? AppColor.grey : AppColor.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isMap = false;
                    });
                  },
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      fontSize: AppFontSize.body,
                      fontWeight: FontWeight.bold,
                      color: isMap ? AppColor.brown : AppColor.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.0.w),
            ],
          ),
          Expanded(
            child: isMap
                ? GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(
                        4.4708759,
                        97.964298,
                      ),
                      zoom: 13.0,
                    ),
                    myLocationEnabled: true,
                    markers: markers,
                  )
                : ListView(
                    children: List.generate(
                      extra['results'].length,
                      (index) {
                        final ResultModel result = extra['results'][index];
                        final String gender = result.donor.gender!;
                        final int age =
                            AppFunction.getAge(result.donor.dateOfBirth!);
                        final String distanceInKilometer =
                            markers.toList()[index].infoWindow.title!;
                        final String distanceInMeter =
                            markers.toList()[index].infoWindow.snippet!;

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
                            bottom: index != extra['results'].length - 1
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
                                      Text(result.donor.name),
                                      Text('$gender, $age tahun'),
                                      Text(
                                          'Jarak: $distanceInKilometer ($distanceInMeter)'),
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
