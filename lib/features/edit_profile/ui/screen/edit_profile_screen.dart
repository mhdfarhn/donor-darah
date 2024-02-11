import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/blocs/marker/marker_bloc.dart';
import '../../../../core/blocs/profile/profile_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/data/models/models.dart';
import '../../../../core/widgets/buttons/buttons.dart';
import '../../../../core/widgets/input_fields/input_fields.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool? status;
  Timestamp? dateOfBirth;
  DateTime? pickedDate;
  String? gender;
  String? bloodType;
  GeoPoint? location;
  Set<Marker>? markers;

  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    context.read<ProfileBloc>().add(LoadCurrentUserProfile(_user!.email!));
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileError) {
              return Text(
                state.error,
                style: TextStyle(
                  fontSize: AppFontSize.body,
                ),
              );
            }
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.red,
                ),
              );
            } else if (state is ProfileLoaded) {
              final Completer<GoogleMapController> controller = Completer();
              UserModel user = state.user;

              status = user.status;
              _nameController.text = user.name;
              _emailController.text = user.email;
              dateOfBirth = user.dateOfBirth;
              pickedDate = dateOfBirth != null ? dateOfBirth!.toDate() : null;
              _dateOfBirthController.text = pickedDate != null
                  ? DateFormat('dd/MM/yyyy').format(pickedDate!)
                  : '';
              gender = user.gender;
              bloodType = user.bloodType;
              _phoneNumberController.text = user.phoneNumber ?? '';
              location = user.location;
              markers = <Marker>{
                Marker(
                  markerId: const MarkerId('location'),
                  position: LatLng(location!.latitude, location!.longitude),
                  infoWindow: InfoWindow(
                    title: 'Lokasi Anda',
                    snippet:
                        'Lat: ${location!.latitude}, Long: ${location!.longitude}',
                  ),
                ),
              };
              return ListView(
                children: [
                  SizedBox(height: 24.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: StatusField(
                      onChanged: (String? value) {
                        status = AppMap.statuses.keys.firstWhere(
                          (key) => AppMap.statuses[key] == value,
                        );
                      },
                      value: AppMap.statuses[status],
                    ),
                  ),
                  SizedBox(height: 16.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: NameField(controller: _nameController),
                  ),
                  SizedBox(height: 16.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: EmailField(
                      controller: _emailController,
                      readOnly: true,
                    ),
                  ),
                  SizedBox(height: 16.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: DateField(
                      controller: _dateOfBirthController,
                      labelText: 'Tanggal Lahir',
                      onTap: () async {
                        pickedDate = await showDatePicker(
                          context: context,
                          initialDate: pickedDate ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate!);
                          _dateOfBirthController.text = formattedDate;
                          dateOfBirth = Timestamp.fromDate(pickedDate!);
                        } else {
                          pickedDate = null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: GenderField(
                      onChanged: (String? value) {
                        gender = value;
                      },
                      value: gender,
                    ),
                  ),
                  SizedBox(height: 16.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: BloodTypeField(
                      onChanged: (String? value) {
                        bloodType = value;
                      },
                      value: bloodType,
                    ),
                  ),
                  SizedBox(height: 16.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: PhoneNumberField(controller: _phoneNumberController),
                  ),
                  SizedBox(height: 16.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: BlocBuilder<MarkerBloc, MarkerState>(
                      builder: (context, state) {
                        return MapField(
                          controller: controller,
                          location: location!,
                          markers:
                              state is MarkerLoaded ? state.markers : markers!,
                          onLongPress: (LatLng position) async {
                            location = GeoPoint(
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
                                await controller.future;

                            googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(cameraPosition),
                            );
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.0.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: PrimaryButton(
                      title: 'Simpan',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Simpan'),
                                  content: const Text(
                                      'Anda yakin ingin menyimpan perubahan?'),
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
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        context.read<ProfileBloc>().add(
                                              UpdateProfile(
                                                UserModel(
                                                  // role: user.role,
                                                  status: status!,
                                                  name: _nameController.text,
                                                  email: _emailController.text,
                                                  dateOfBirth: dateOfBirth,
                                                  gender: gender,
                                                  bloodType: bloodType,
                                                  phoneNumber:
                                                      _phoneNumberController
                                                          .text,
                                                  location: location,
                                                ),
                                              ),
                                            );
                                      },
                                      child: Text(
                                        'Ya',
                                        style: TextStyle(
                                          color: AppColor.black,
                                          fontSize: AppFontSize.body,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 24.0.h),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
