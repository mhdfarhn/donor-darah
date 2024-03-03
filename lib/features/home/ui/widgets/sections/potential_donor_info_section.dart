import 'package:donor_darah/core/constants/app_color.dart';
import 'package:donor_darah/core/constants/app_font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/potential_donor/potential_donor_cubit.dart';

class PotentialDonorInfoSection extends StatelessWidget {
  const PotentialDonorInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PotentialDonorCubit, PotentialDonorState>(
      builder: (context, state) {
        if (state is PotentialDonorLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.red),
          );
        } else if (state is PotentialDonorError) {
          return Text(
            state.error,
            style: TextStyle(fontSize: AppFontSize.body),
          );
        } else if (state is PotentialDonorLoaded) {
          final map = state.results;
          final keys = map.keys.toList();
          if (map.isEmpty) {
            return Text(
              'Tidak ada user yang bersedia donor saat ini.',
              style: TextStyle(fontSize: AppFontSize.body),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                map.length,
                (index) => Text(
                    '${index + 1}. Golongan Darah ${keys[index]} : ${map[keys[index]]} orang'),
              ),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
