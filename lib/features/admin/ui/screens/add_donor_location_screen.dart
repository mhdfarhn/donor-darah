import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/core/blocs/position/position_bloc.dart';
import 'package:donor_darah/core/constants/constants.dart';
import 'package:donor_darah/core/widgets/buttons/buttons.dart';
import 'package:donor_darah/features/admin/data/donor_location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/blocs/marker/marker_bloc.dart';
import '../../../../core/widgets/input_fields/map_field.dart';
import '../../../../core/widgets/input_fields/option_input_field.dart';
import '../../../../core/widgets/input_fields/text_input_field.dart';
import '../../cubit/donor_location_cubit.dart';

class AddDonorLocationScreen extends StatefulWidget {
  const AddDonorLocationScreen({super.key});

  @override
  State<AddDonorLocationScreen> createState() => _AddDonorLocationScreenState();
}

final donorLocationStatuses = <String>['Ya', 'Tidak'];

class _AddDonorLocationScreenState extends State<AddDonorLocationScreen> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool? _status;
  final Set<Marker> _markers = <Marker>{};
  Position? _position;
  GeoPoint? _location;

  @override
  void initState() {
    context.read<PositionBloc>().add(LoadCurrentPosition());
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Lokasi Donor'),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Form(
        key: _key,
        child: ListView(
          children: [
            SizedBox(height: 16.0.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: OptionInputField(
                labelText: 'Aktif',
                optionList: donorLocationStatuses,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Pilih status lokasi donor';
                  }
                  return null;
                },
                onChanged: (String? value) {
                  _status = value == 'Ya' ? true : false;
                },
              ),
            ),
            SizedBox(height: 16.0.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: TextInputField(
                labelText: 'Lokasi Donor',
                controller: _nameController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan lokasi donor';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 16.0.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextInputField(
                labelText: 'Deskripsi',
                controller: _descriptionController,
                hint: 'Contoh: Prioritas Gol. Darah A',
              ),
            ),
            SizedBox(height: 16.0.h),
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
                              state is MarkerLoaded ? state.markers : _markers,
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
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: BlocConsumer<DonorLocationCubit, DonorLocationState>(
                listener: (context, state) {
                  if (state is DonorLocationCreated) {
                    _nameController.clear();
                    _descriptionController.clear();
                    context.read<DonorLocationCubit>().getDonorLocations();
                    context.goNamed('admin');
                  }
                  if (state is DonorLocationError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is DonorLocationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.red),
                    );
                  } else {
                    return PrimaryButton(
                      title: 'Tambah',
                      onPressed: () {
                        if (_status != null && _location != null) {
                          if (_key.currentState!.validate()) {
                            context
                                .read<DonorLocationCubit>()
                                .createDonorLocation(
                                  DonorLocationModel(
                                    status: _status!,
                                    name: _nameController.text.trim(),
                                    description:
                                        _descriptionController.text.trim(),
                                    location: _location!,
                                    createdAt: Timestamp.now(),
                                    updatedAt: Timestamp.now(),
                                  ),
                                );
                          }
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
    );
  }
}
