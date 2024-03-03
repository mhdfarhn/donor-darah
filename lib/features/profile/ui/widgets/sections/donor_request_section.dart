import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../donor_request/data/models/donor_request_model.dart';
import '../../../blocs/current_user_donor/current_user_donor_request_bloc.dart';
import '../../../functions/functions.dart';

class DonorRequestSection extends StatefulWidget {
  const DonorRequestSection({
    super.key,
  });

  @override
  State<DonorRequestSection> createState() => _DonorRequestSectionState();
}

class _DonorRequestSectionState extends State<DonorRequestSection> {
  @override
  void initState() {
    context
        .read<CurrentUserDonorRequestBloc>()
        .add(LoadCurrentUserDonorRequest());
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
            'Riwayat Cari Donor',
            style: TextStyle(
              fontSize: AppFontSize.heading,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BlocBuilder<CurrentUserDonorRequestBloc, CurrentUserDonorRequestState>(
          builder: (context, state) {
            if (state is CurrentUserDonorRequestLoding) {
              return const CircularProgressIndicator(
                color: AppColor.red,
              );
            } else if (state is CurrentUserDonorRequestError) {
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
            } else if (state is CurrentUserDonorRequestLoaded) {
              List<DonorRequestModel> requests = state.donorRequests;

              return requests.isNotEmpty
                  ? Column(
                      children: List.generate(
                        requests.length <= 3 ? requests.length : 3,
                        (index) {
                          DonorRequestModel request = requests[index];
                          bool active = request.active;
                          return Card(
                            margin: EdgeInsets.fromLTRB(
                              24.0.w,
                              8.0.h,
                              24.0.w,
                              index != requests.length - 1 ? 8.0.h : 24.0.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0.w,
                              ),
                              minVerticalPadding: 16.0.h,
                              leading: CircleAvatar(
                                backgroundColor: AppColor.grey,
                                child: Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(
                                    color: AppColor.brown,
                                  ),
                                ),
                              ),
                              title: Text(
                                request.bloodType,
                                style: const TextStyle(
                                  color: AppColor.brown,
                                ),
                              ),
                              subtitle: Text(
                                AppFunction.date(request.createdAt),
                                style: TextStyle(
                                  fontSize: AppFontSize.caption,
                                  color: AppColor.black.withOpacity(0.8),
                                ),
                              ),
                              trailing: InkWell(
                                onTap: active
                                    ? () => showDonorRequestCompletedDialog(
                                          context,
                                          request,
                                        )
                                    : null,
                                child: CircleAvatar(
                                  backgroundColor:
                                      active ? AppColor.grey : AppColor.red,
                                  child: FaIcon(
                                    active
                                        ? FontAwesomeIcons.xmark
                                        : FontAwesomeIcons.check,
                                    color:
                                        active ? AppColor.brown : AppColor.grey,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                        ..insert(
                          0,
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              24.0.w,
                              8.0.h,
                              24.0.w,
                              0.0.h,
                            ),
                            child: const Text(
                                'Tekan tanda silang jika Anda telah mendapatkan donor yang dibutuhkan.'),
                          ),
                        )
                        ..insert(
                          requests.length <= 3 ? requests.length + 1 : 4,
                          TextButton(
                            onPressed: () {
                              context.goNamed(
                                'donor_request_histories',
                                extra: requests,
                              );
                            },
                            child: const Text(
                              'Lihat lebih banyak',
                              style: TextStyle(
                                color: AppColor.brown,
                              ),
                            ),
                          ),
                        ),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(
                        24.0.w,
                        8.0.h,
                        24.0.w,
                        16.0.h,
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
