import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../donor_request/data/models/donor_request_model.dart';
import '../../../../donor_request/ui/widgets/donor_request_active_card.dart';
import '../../../blocs/success_donor_requests/success_donor_requests_bloc.dart';

class SuccessDonorRequestSection extends StatefulWidget {
  const SuccessDonorRequestSection({super.key});

  @override
  State<SuccessDonorRequestSection> createState() =>
      _SuccessDonorRequestSectionState();
}

class _SuccessDonorRequestSectionState
    extends State<SuccessDonorRequestSection> {
  @override
  void initState() {
    context.read<SuccessDonorRequestsBloc>().add(LoadSuccessDonorRequests());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuccessDonorRequestsBloc, SuccessDonorRequestsState>(
      builder: (context, state) {
        if (state is SuccessDonorRequestsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.red,
            ),
          );
        } else if (state is SuccessDonorRequestsError) {
          return Text(
            state.error,
            style: TextStyle(
              fontSize: AppFontSize.body,
            ),
          );
        } else if (state is SuccessDonorRequestsLoaded) {
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
                    active: false,
                    donorRequest: donorRequest,
                    distanceInKilometer: distanceInKilometer,
                    distanceInMeter: distanceInMeter,
                    index: index,
                    maxIndex: 2,
                  );
                },
              )..insert(
                  donorRequests.length <= 3 ? donorRequests.length : 3,
                  donorRequests.length == 3
                      ? Text(
                          '+${donorRequests.length - 3} donor selesai lainnya.',
                          style: TextStyle(
                            fontSize: AppFontSize.body,
                          ),
                        )
                      : Container(),
                ),
            );
          } else {
            return Text(
              'Belum ada donor selesai.',
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
