import 'package:donor_darah/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../../admin/cubit/donor_location_cubit.dart';

class DonorLocationSection extends StatelessWidget {
  const DonorLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonorLocationCubit, DonorLocationState>(
      builder: (context, state) {
        if (state is DonorLocationLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.red),
          );
        } else if (state is DonorLocationError) {
          return Center(child: Text(state.error));
        } else if (state is DonorLocationsLoaded) {
          final locations = state.locations;
          if (locations.isEmpty) {
            return const Text('Tidak ada lokasi donor hari ini.');
          } else {
            return Column(
              children: List.generate(
                locations.length,
                (index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 16.w,
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
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  locations[index].name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                locations[index].description != null
                                    ? Text(
                                        locations[index].description!,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          GestureDetector(
                            onTap: () => MapsLauncher.launchCoordinates(
                              locations[index].location.latitude,
                              locations[index].location.longitude,
                              locations[index].name,
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.map,
                              color: AppColor.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
