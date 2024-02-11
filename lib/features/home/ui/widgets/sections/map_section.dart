import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/blocs/maps/maps_bloc.dart';
import '../../../../../core/constants/constants.dart';

class MapSection extends StatefulWidget {
  const MapSection({
    super.key,
  });

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  // @override
  // void initState() {
  //   context.read<MapsBloc>().add(LoadMaps());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapsBloc, MapsState>(
      builder: (context, state) {
        if (state is MapsError) {
          return Text(
            state.error,
            style: TextStyle(
              fontSize: AppFontSize.body,
            ),
          );
        } else if (state is MapsLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.red),
          );
        } else if (state is MapsLoaded) {
          return AspectRatio(
            aspectRatio: 1 / 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: state.target,
                  zoom: 11.0,
                ),
                circles: state.circles,
                markers: state.markers,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}
                  ..add(
                    Factory<EagerGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
