import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../donor_request/data/models/donor_request_model.dart';
import '../../../../donor_request/ui/widgets/donor_request_active_card.dart';
import '../../../blocs/bloc/active_donor_requests_bloc.dart';

class ActiveDonorRequestSection extends StatefulWidget {
  const ActiveDonorRequestSection({
    super.key,
  });

  @override
  State<ActiveDonorRequestSection> createState() =>
      _ActiveDonorRequestSectionState();
}

class _ActiveDonorRequestSectionState extends State<ActiveDonorRequestSection> {
  @override
  void initState() {
    context.read<ActiveDonorRequestsBloc>().add(LoadActiveDonorRequests());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveDonorRequestsBloc, ActiveDonorRequestsState>(
      builder: (context, state) {
        if (state is ActiveDonorRequestsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.red,
            ),
          );
        } else if (state is ActiveDonorRequestsError) {
          return Text(
            state.error,
            style: TextStyle(
              fontSize: AppFontSize.body,
            ),
          );
        } else if (state is ActiveDonorRequestsLoaded) {
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

                  return DonorRequestCard(
                    active: true,
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
