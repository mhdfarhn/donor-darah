import 'package:donor_darah/features/profile/blocs/current_user_donor/current_user_donor_request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../donor_request/data/models/donor_request_model.dart';
import '../../home/blocs/active_donor_requests/active_donor_requests_bloc.dart';

Future<dynamic> showDonorRequestCompletedDialog(
  BuildContext context,
  DonorRequestModel donorRequest,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Donor Selesai'),
          content: const Text('Apakah Anda telah mendapatkan donor?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Tidak',
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: AppFontSize.body,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                debugPrint('Yes');
                Navigator.pop(context);
                context
                    .read<CurrentUserDonorRequestBloc>()
                    .add(UpdateCurrentUserDonorReequest(donorRequest));
                context
                    .read<ActiveDonorRequestsBloc>()
                    .add(LoadActiveDonorRequests());
              },
              child: Text(
                'Ya',
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: AppFontSize.body,
                ),
              ),
            ),
          ],
        );
      });
}
