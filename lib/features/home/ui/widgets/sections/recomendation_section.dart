import 'package:donor_darah/features/home/blocs/recomendation/recomendation_cubit.dart';
import 'package:donor_darah/features/result/data/models/result_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/constants.dart';

class RecomendationSection extends StatefulWidget {
  const RecomendationSection({
    super.key,
  });

  @override
  State<RecomendationSection> createState() => _RecomendationSectionState();
}

class _RecomendationSectionState extends State<RecomendationSection> {
  bool _hasCallSupport = false;

  @override
  void initState() {
    // context.read<RecomendationCubit>().getRecomendation();
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
    return BlocBuilder<RecomendationCubit, RecomendationState>(
      builder: (context, state) {
        if (state is RecomendationLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.red,
            ),
          );
        } else if (state is RecomendationError) {
          return Text(
            state.error,
            style: TextStyle(
              fontSize: AppFontSize.body,
            ),
          );
        } else if (state is RecomendationLoaded) {
          List<ResultModel> results = state.results;

          if (results.isNotEmpty) {
            return Column(
              children: List.generate(
                results.length,
                (index) {
                  final ResultModel result = results[index];
                  final String gender = result.donor.gender!;
                  final int age = AppFunction.getAge(result.donor.dateOfBirth!);
                  final String distanceInKilometer =
                      (result.slocDistance / 1000).toStringAsFixed(2);
                  final String distanceInMeter =
                      result.slocDistance.toStringAsFixed(2);

                  return Card(
                    margin: EdgeInsets.only(
                      top: 8.0.h,
                      bottom: index != results.length - 1 ? 8.0.h : 16.0.h,
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
                                  Text('Nama: ${result.donor.name}'),
                                  Text(
                                      'Golongan Darah: ${result.donor.bloodType}'),
                                  Text('Jenis Kelamin: $gender'),
                                  Text('Umur: $age'),
                                  Text(
                                      'Jarak: $distanceInKilometer km ($distanceInMeter m)'),
                                ],
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: _hasCallSupport
                                ? () => setState(() {
                                      AppFunction.makePhoneCall(
                                          result.donor.phoneNumber!);
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
                },
              ),
            );
          } else {
            return Text(
              'Tidak ada rekomendasi untuk saat ini.',
              style: TextStyle(
                fontSize: AppFontSize.body,
              ),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
