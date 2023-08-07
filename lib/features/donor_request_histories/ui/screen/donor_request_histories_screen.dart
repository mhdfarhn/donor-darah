import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../donor_request/data/models/donor_request_model.dart';
import '../../../profile/functions/functions.dart';

class DonorRequestHistoriesScreen extends StatelessWidget {
  final List<DonorRequestModel> requests;

  const DonorRequestHistoriesScreen({
    super.key,
    required this.requests,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Cari Donor'),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: List.generate(
          requests.length,
          (index) {
            DonorRequestModel request = requests[index];
            bool active = request.active;
            return Card(
              margin: EdgeInsets.fromLTRB(
                24.0.w,
                8.0.h,
                24.0.w,
                index != requests.length - 1 ? 0.0.h : 24.0.h,
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
                    backgroundColor: active ? AppColor.grey : AppColor.red,
                    child: FaIcon(
                      active ? FontAwesomeIcons.xmark : FontAwesomeIcons.check,
                      color: active ? AppColor.brown : AppColor.grey,
                    ),
                  ),
                ),
              ),
            );
          },
        )..insert(
            0,
            Padding(
              padding: EdgeInsets.fromLTRB(
                24.0.w,
                16.0.h,
                24.0.w,
                8.0.h,
              ),
              child: const Text(
                  'Tekan tanda silang jika Anda telah mendapatkan donor yang dibutuhkan.'),
            ),
          ),
      ),
    );
  }
}
