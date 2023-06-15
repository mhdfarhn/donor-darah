import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/blocs/auth/auth_bloc.dart';
import '../../../../core/blocs/marker/marker_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/data/models/models.dart';
import '../../../../core/widgets/buttons/buttons.dart';
import '../../../../core/widgets/input_fields/input_fields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool? status;
  DateTime? pickedDate;
  Timestamp? dateOfBirth;
  GeoPoint? location;
  String? gender;
  String? bloodType;
  Set<Marker> markers = <Marker>{};

  Future<void> getCurrentLocation() async {
    Position position = await AppFunction.getCurrentPosition();
    location = GeoPoint(position.latitude, position.longitude);
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateOfBirthController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              context.goNamed('home');
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.0.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Daftar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppFontSize.heading,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.goNamed('auth'),
                        child: const FaIcon(
                          FontAwesomeIcons.xmark,
                          color: AppColor.brown,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0.h),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        SizedBox(height: 16.0.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                          child: StatusField(
                            onChanged: (String? value) {
                              setState(() {
                                status = AppMap.statuses.keys.firstWhere(
                                  (key) => AppMap.statuses[key] == value,
                                );
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16.0.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                          child: NameField(
                            controller: _nameController,
                          ),
                        ),
                        SizedBox(height: 16.0.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                          child: EmailField(
                            controller: _emailController,
                          ),
                        ),
                        SizedBox(height: 16.0.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                          child: PasswordField(
                            controller: _passwordController,
                          ),
                        ),
                        SizedBox(height: 16.0.h),
                        status == true
                            ? Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 24.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DateField(
                                      controller: _dateOfBirthController,
                                      labelText: 'Tanggal Lahir',
                                      onTap: () async {
                                        pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate:
                                              pickedDate ?? DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null) {
                                          String formattedDate =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(pickedDate!);
                                          _dateOfBirthController.text =
                                              formattedDate;
                                          dateOfBirth =
                                              Timestamp.fromDate(pickedDate!);
                                        }
                                      },
                                    ),
                                    SizedBox(height: 16.0.h),
                                    GenderField(
                                      onChanged: (String? value) {
                                        gender = value;
                                      },
                                    ),
                                    SizedBox(height: 16.0.h),
                                    BloodTypeField(
                                      onChanged: (String? value) {
                                        bloodType = value;
                                      },
                                    ),
                                    SizedBox(height: 16.0.h),
                                    PhoneNumberField(
                                      controller: _phoneNumberController,
                                    ),
                                    SizedBox(height: 16.0.h),
                                    BlocBuilder<MarkerBloc, MarkerState>(
                                      builder: (context, state) {
                                        Completer<GoogleMapController>
                                            controller = Completer();
                                        return MapField(
                                          controller: controller,
                                          location: location!,
                                          markers: state is MarkerLoaded
                                              ? state.markers
                                              : markers,
                                          onLongPress: (LatLng position) async {
                                            location = GeoPoint(
                                              position.latitude,
                                              position.longitude,
                                            );

                                            context.read<MarkerBloc>().add(
                                                  UpdateMarkers(position),
                                                );

                                            CameraPosition cameraPosition =
                                                CameraPosition(
                                              target: position,
                                              zoom: 15,
                                            );

                                            final GoogleMapController
                                                googleMapController =
                                                await controller.future;

                                            googleMapController.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                  cameraPosition),
                                            );
                                            setState(() {});
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(height: 16.0.h),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: state is AuthLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.red,
                                  ),
                                )
                              : PrimaryButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                            SignUpRequest(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                              user: UserModel(
                                                status: status ?? false,
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                dateOfBirth: dateOfBirth,
                                                gender: gender,
                                                bloodType: bloodType,
                                                phoneNumber:
                                                    _phoneNumberController
                                                            .text.isNotEmpty
                                                        ? _phoneNumberController
                                                            .text
                                                        : null,
                                                location: location,
                                              ),
                                            ),
                                          );
                                    }
                                  },
                                  title: 'Daftar',
                                ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
