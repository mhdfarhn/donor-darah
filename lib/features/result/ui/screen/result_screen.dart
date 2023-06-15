import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../data/models/result_model.dart';

class ResultScreen extends StatefulWidget {
  final List<ResultModel> results;

  const ResultScreen({
    Key? key,
    required this.results,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isMap = true;
  Set<Marker> markers = <Marker>{};

  @override
  void initState() {
    for (var element in widget.results) {
      markers.add(element.marker);
    }
    super.initState();
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
                      widget.results.length,
                      (index) {
                        final String gender =
                            widget.results[index].donor.gender!;
                        final int age = AppFunction.getAge(
                            widget.results[index].donor.dateOfBirth!);
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: EdgeInsets.only(
                            left: 16.0.w,
                            top: 8.0.h,
                            right: 16.0.w,
                            bottom: index != widget.results.length - 1
                                ? 8.0.h
                                : 16.0.h,
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
                                      Text(widget.results[index].donor.name),
                                      Text('$gender, $age tahun'),
                                      Text(
                                          'Jarak: ${markers.toList()[index].infoWindow.title} (${markers.toList()[index].infoWindow.snippet})'),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16.0.w),
                                InkWell(
                                  onTap: () {},
                                  child: const FaIcon(
                                      FontAwesomeIcons.solidPaperPlane),
                                ),
                              ],
                            ),
                          ),
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
