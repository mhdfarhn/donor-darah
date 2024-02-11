import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../profile/functions/show_sign_out_dialog.dart';
import '../../cubit/donor_location_cubit.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    context.read<DonorLocationCubit>().getDonorLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
            onPressed: () {
              showSignOutDialog(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<DonorLocationCubit, DonorLocationState>(
        builder: (context, state) {
          if (state is DonorLocationLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.red),
            );
          } else if (state is DonorLocationError) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              child: Text(state.error),
            );
          }
          if (state is DonorLocationsLoaded) {
            final locations = state.locations;
            if (locations.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                child: const Text('Tidak ada lokasi donor.'),
              );
            } else {
              return ListView(
                children: List.generate(locations.length, (index) {
                  return Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
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
                            onTap: () => context.goNamed(
                              'edit_donor_location',
                              pathParameters: {'uid': locations[index].uid!},
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.pen,
                              size: 20.sp,
                              color: AppColor.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.red,
        onPressed: () => context.goNamed('add_donor_location'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
