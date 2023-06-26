import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/blocs/marker/marker_bloc.dart';
import '../../../../core/blocs/position/position_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/buttons/buttons.dart';
import '../../../../core/widgets/input_fields/input_fields.dart';
import '../../../donor_request/blocs/donor_request/donor_request_bloc.dart';
import '../../../donor_request/data/models/donor_request_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Set<Marker> markers = <Marker>{};
  String? _bloodType;
  GeoPoint? _location;
  Position? _position;

  @override
  void initState() {
    context.read<PositionBloc>().add(LoadCurrentPosition());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Donor'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: 16.0.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: OptionInputField(
                labelText: 'Golongan Darah',
                optionList: AppList.bloodTypes,
                validator: AppValidator.bloodType,
                onChanged: (String? value) {
                  _bloodType = value!;
                },
              ),
            ),
            SizedBox(height: 24.0.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: BlocBuilder<PositionBloc, PositionState>(
                builder: (context, state) {
                  if (state is PositionLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.red,
                      ),
                    );
                  } else if (state is PositionError) {
                    return Text(
                      state.error,
                      style: TextStyle(
                        fontSize: AppFontSize.body,
                      ),
                    );
                  } else if (state is PositionLoaded) {
                    _position = state.position;
                    _location =
                        GeoPoint(_position!.latitude, _position!.longitude);

                    return BlocBuilder<MarkerBloc, MarkerState>(
                      builder: (context, state) {
                        return MapField(
                          controller: _controller,
                          location: _location!,
                          markers:
                              state is MarkerLoaded ? state.markers : markers,
                          onLongPress: (LatLng position) async {
                            _location = GeoPoint(
                              position.latitude,
                              position.longitude,
                            );

                            context.read<MarkerBloc>().add(
                                  UpdateMarkers(position),
                                );

                            CameraPosition cameraPosition = CameraPosition(
                              target: position,
                              zoom: 15,
                            );

                            final GoogleMapController googleMapController =
                                await _controller.future;

                            googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            SizedBox(height: 24.0.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Row(
                children: [
                  Expanded(
                    child: BlocConsumer<DonorRequestBloc, DonorRequestState>(
                      listener: (context, state) {
                        if (state is DonorRequestSuccess) {
                          Map<String, dynamic> extra = {
                            'results': state.results,
                            'donorRequestId': state.donorRequestId,
                            'requestLocation': state.requestLocation,
                          };
                          context.goNamed(
                            'result',
                            extra: extra,
                          );
                        } else if (state is DonorRequestError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is DonorRequestLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColor.red,
                            ),
                          );
                        } else {
                          return PrimaryButton(
                            title: 'Cari',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<DonorRequestBloc>().add(
                                      RequestDonor(
                                        DonorRequestModel(
                                          bloodType: _bloodType!,
                                          location: _location!,
                                          active: true,
                                          createdAt: Timestamp.now(),
                                          updatedAt: Timestamp.now(),
                                        ),
                                      ),
                                    );
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0.h),
          ],
        ),
      ),
    );
  }
}
