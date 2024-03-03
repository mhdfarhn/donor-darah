import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/features/admin/ui/widgets/show_delete_location_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/blocs/marker/marker_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/input_fields/map_field.dart';
import '../../../../core/widgets/input_fields/option_input_field.dart';
import '../../cubit/donor_location_cubit.dart';
import '../../cubit/edit_donor_location/edit_donor_location_cubit.dart';
import '../../data/donor_location_model.dart';
import 'add_donor_location_screen.dart';

class EditDonorLocationScreen extends StatefulWidget {
  final String uid;
  final DonorLocationModel location;

  const EditDonorLocationScreen({
    required this.uid,
    required this.location,
    super.key,
  });

  @override
  State<EditDonorLocationScreen> createState() =>
      _EditDonorLocationScreenState();
}

class _EditDonorLocationScreenState extends State<EditDonorLocationScreen> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool? _status;
  Set<Marker>? _markers;
  GeoPoint? _location;
  late DonorLocationModel _donorLocation;

  @override
  void initState() {
    // context.read<EditDonorLocationCubit>().getDonorLocation(widget.uid);
    _donorLocation = widget.location;
    _status = _donorLocation.status;
    _nameController.text = _donorLocation.name;
    _descriptionController.text = _donorLocation.description!;

    _location = _donorLocation.location;
    _markers = <Marker>{
      Marker(
        markerId: const MarkerId('location'),
        position: LatLng(_donorLocation.location.latitude,
            _donorLocation.location.longitude),
        infoWindow: InfoWindow(
          title: _donorLocation.name,
          snippet:
              'Lat: ${_donorLocation.location.latitude}, Long: ${_donorLocation.location.longitude}',
        ),
      ),
    };
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
        title: const Text('Edit Lokasi Donor'),
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => showDeleteLocationDialog(context, widget.uid),
          ),
        ],
      ),
      body: Form(
        key: _key,
        // child: BlocBuilder<EditDonorLocationCubit, EditDonorLocationState>(
        //   builder: (context, state) {
        // if (state is EditDonorLocationLoading) {
        //   return const Center(
        //     child: CircularProgressIndicator(color: AppColor.red),
        //   );
        // } else if (state is EditDonorLocationError) {
        //   return Center(
        //     child: Text(state.error),
        //   );
        // } else if (state is EditDonorLocationLoaded) {
        //   final location = state.location;
        //   _status = location.status;
        //   _nameController.text = location.name;
        //   _descriptionController.text = location.description!;
        //
        //   _location = location.location;
        //   _markers = <Marker>{
        //     Marker(
        //       markerId: const MarkerId('location'),
        //       position: LatLng(
        //           location.location.latitude, location.location.longitude),
        //       infoWindow: InfoWindow(
        //         title: location.name,
        //         snippet:
        //             'Lat: ${location.location.latitude}, Long: ${location.location.longitude}',
        //       ),
        //     ),
        //   };

        // return ListView(
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
                value: _status == true ? 'Ya' : 'Tidak',
                onChanged: (String? value) {
                  _status = value == 'Ya' ? true : false;
                },
              ),
            ),
            SizedBox(height: 16.0.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: TextFormField(
                controller: _nameController,
                cursorColor: AppColor.brown,
                decoration: InputDecoration(
                  labelText: 'Lokasi Donor',
                  labelStyle: const TextStyle(color: AppColor.brown),
                  filled: true,
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
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
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: TextFormField(
                controller: _descriptionController,
                cursorColor: AppColor.brown,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  labelStyle: const TextStyle(color: AppColor.brown),
                  filled: true,
                  hintText: 'Contoh: Prioritas Gol. Darah A',
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: BlocBuilder<MarkerBloc, MarkerState>(
                builder: (context, state) {
                  return MapField(
                    controller: _controller,
                    location: _location!,
                    markers: state is MarkerLoaded ? state.markers : _markers!,
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
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child:
                  BlocConsumer<EditDonorLocationCubit, EditDonorLocationState>(
                listener: (context, state) {
                  if (state is EditDonorLocationUpdated) {
                    context.read<DonorLocationCubit>().getDonorLocations();
                    context.goNamed('admin');
                  }
                  if (state is EditDonorLocationError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is EditDonorLocationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.red),
                    );
                  } else {
                    return PrimaryButton(
                      title: 'Simpan',
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          if (_status != null && _location != null) {
                            context
                                .read<EditDonorLocationCubit>()
                                .updateDonorLocation(
                                  _donorLocation.copyWith(
                                    status: _status,
                                    name: _nameController.text,
                                    description: _descriptionController.text,
                                    location: _location,
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
        // } else {
        //   return Container();
        // }
        // },
        // ),
      ),
    );
  }
}
