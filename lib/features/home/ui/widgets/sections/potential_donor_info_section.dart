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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              map.length,
              (index) => Text(
                  '${index + 1}. Golongan Darah ${keys[index]} : ${map[keys[index]]} orang'),
            ),
          );
          // return Wrap(
          //   spacing: 4.w,
          //   runSpacing: 4.h,
          //   children: List.generate(
          //     map.length,
          //     (index) => Card(
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Column(
          //           children: [
          //             Text(keys[index]),
          //             Text(map[keys[index]].toString()),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
