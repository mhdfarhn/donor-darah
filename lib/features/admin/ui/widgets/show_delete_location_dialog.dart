import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../cubit/donor_location_cubit.dart';
import '../../cubit/edit_donor_location/edit_donor_location_cubit.dart';

Future<dynamic> showDeleteLocationDialog(BuildContext context, String uid) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Hapus Lokasi Donor'),
        content: const Text('Anda yakin ingin menghapus lokasi donor ini?'),
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
          BlocListener<EditDonorLocationCubit, EditDonorLocationState>(
            listener: (context, state) {
              if (state is EditDonorLocationDeleted) {
                context.read<DonorLocationCubit>().getDonorLocations();
                context.goNamed('admin');
              } else if (state is EditDonorLocationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                  ),
                );
              }
            },
            child: TextButton(
              onPressed: () {
                context.read<EditDonorLocationCubit>().deleteDonorLocation(uid);
              },
              child: Text(
                'Ya',
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: AppFontSize.body,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
