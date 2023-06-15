import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../donor_request/blocs/donor_request/donor_request_bloc.dart';
import '../../../../donor_request/data/models/donor_request_model.dart';
import '../../../../donor_request/ui/widgets/donor_request_active_card.dart';

class DonorRequestActiveSection extends StatefulWidget {
  const DonorRequestActiveSection({
    super.key,
  });

  @override
  State<DonorRequestActiveSection> createState() =>
      _DonorRequestActiveSectionState();
}

class _DonorRequestActiveSectionState extends State<DonorRequestActiveSection> {
  @override
  void initState() {
    context.read<DonorRequestBloc>().add(LoadDonorRequests());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonorRequestBloc, DonorRequestState>(
      builder: (context, state) {
        if (state is DonorRequestLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.red,
            ),
          );
        } else if (state is DonorRequestError) {
          return Text(
            state.error,
            style: TextStyle(
              fontSize: AppFontSize.body,
            ),
          );
        } else if (state is DonorRequestLoaded) {
          List<DonorRequestModel> donorRequests = state.donorRequests;
          List<double> distances = state.distances;

          if (donorRequests.isNotEmpty) {
            return Column(
              children: List.generate(
                donorRequests.length <= 3 ? donorRequests.length : 3,
                (index) {
                  final DonorRequestModel donorRequest = donorRequests[index];
                  final double distance = distances[index];
                  final String distanceInKilometer =
                      (distance / 1000).toStringAsFixed(2);
                  final String distanceInMeter = distance.toStringAsFixed(2);

                  return DonorRequestActiveCard(
                    donorRequest: donorRequest,
                    distanceInKilometer: distanceInKilometer,
                    distanceInMeter: distanceInMeter,
                    index: index,
                  );
                },
              ),
            );
          } else {
            return Text(
              'Tidak ada yang membutuhkan donor untuk saat ini.',
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
