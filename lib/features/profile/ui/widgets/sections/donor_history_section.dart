import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/data/models/models.dart';
import '../../../blocs/donor_history/donor_history_bloc.dart';

class DonorHistorySection extends StatefulWidget {
  const DonorHistorySection({
    super.key,
  });

  @override
  State<DonorHistorySection> createState() => _DonorHistorySectionState();
}

class _DonorHistorySectionState extends State<DonorHistorySection> {
  @override
  void initState() {
    context.read<DonorHistoryBloc>().add(LoadDonorHistories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Text(
            'Riwayat Donor',
            style: TextStyle(
              fontSize: AppFontSize.heading,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BlocBuilder<DonorHistoryBloc, DonorHistoryState>(
          builder: (context, state) {
            if (state is DonorHistoryLoading) {
              return const CircularProgressIndicator(
                color: AppColor.red,
              );
            } else if (state is DonorHistoryError) {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  24.0.w,
                  8.0.h,
                  24.0.w,
                  24.0.h,
                ),
                child: Text(
                  state.error,
                  style: TextStyle(
                    fontSize: AppFontSize.body,
                  ),
                ),
              );
            } else if (state is DonorHistoryLoaded) {
              List<DonorHistoryModel> donorHistories = state.donorHistories;

              return donorHistories.isNotEmpty
                  ? Column(
                      children: List.generate(donorHistories.length, (index) {
                        String day = DateFormat.d()
                            .format(donorHistories[index].date.toDate());
                        String month = DateFormat.MMMM()
                            .format(donorHistories[index].date.toDate());
                        String year = DateFormat.y()
                            .format(donorHistories[index].date.toDate());
                        return Card(
                          margin: EdgeInsets.fromLTRB(
                            24.0.w,
                            8.0.h,
                            24.0.w,
                            index != donorHistories.length - 1 ? 8.0.h : 24.0.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0.w,
                            ),
                            minVerticalPadding: 16.0.h,
                            title: Text(
                              '$day $month $year',
                              style: TextStyle(
                                color: AppColor.brown,
                                fontSize: AppFontSize.button,
                              ),
                            ),
                            subtitle: Text(
                              donorHistories[index].location,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: AppFontSize.body,
                                color: AppColor.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(
                        24.0.w,
                        8.0.h,
                        24.0.w,
                        24.0.h,
                      ),
                      child: Text(
                        'Belum ada riwayat donor.',
                        style: TextStyle(
                          fontSize: AppFontSize.body,
                        ),
                      ),
                    );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
