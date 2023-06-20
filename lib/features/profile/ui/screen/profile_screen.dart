import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/blocs/auth/auth_bloc.dart';
import '../../../../core/blocs/donor_history/donor_history_bloc.dart';
import '../../../../core/blocs/profile/profile_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/data/models/models.dart';
import '../../../../core/widgets/buttons/buttons.dart';
import '../../../../core/widgets/input_fields/input_fields.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    context.read<ProfileBloc>().add(LoadCurrentUserProfile(_user!.email!));
    context.read<DonorHistoryBloc>().add(LoadDonorHistories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
            onPressed: () {
              showSignOutDialog(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                UserModel user = state.user;

                return Column(
                  children: [
                    SizedBox(height: 24.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 32.0.w,
                              backgroundColor: AppColor.grey,
                              child: const FaIcon(
                                FontAwesomeIcons.user,
                                color: AppColor.brown,
                              ),
                            ),
                            user.status != true
                                ? const SizedBox()
                                : Positioned(
                                    bottom: 0.0,
                                    right: 0.0,
                                    child: FaIcon(
                                      FontAwesomeIcons.solidCircleCheck,
                                      color: AppColor.brown,
                                      size: 20.0.w,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: Text(
                        user.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppFontSize.heading,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: Text(
                        user.email,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppFontSize.body,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0.h),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                            child: PrimaryButton(
                              title: 'Edit Profile',
                              onPressed: () async {
                                context.goNamed('edit_profile');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0.h),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
          Divider(thickness: 1.0.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Text(
                  'Riwayat Donor',
                  style: TextStyle(
                    fontSize: AppFontSize.heading,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0.h),
              BlocBuilder<DonorHistoryBloc, DonorHistoryState>(
                builder: (context, state) {
                  if (state is DonorHistoryError) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: Text(
                        state.error,
                        style: TextStyle(
                          fontSize: AppFontSize.body,
                        ),
                      ),
                    );
                  } else if (state is DonorHistoryLoaded) {
                    List<DonorHistoryModel> donorHistories =
                        state.donorHistories;

                    return donorHistories.isNotEmpty
                        ? Column(
                            children:
                                List.generate(donorHistories.length, (index) {
                              String day = DateFormat.d()
                                  .format(donorHistories[index].date.toDate());
                              String month = DateFormat.MMMM()
                                  .format(donorHistories[index].date.toDate());
                              String year = DateFormat.y()
                                  .format(donorHistories[index].date.toDate());
                              return Card(
                                margin: EdgeInsets.fromLTRB(
                                  24.0.w,
                                  8.0.h,
                                  24.0.w,
                                  index != donorHistories.length - 1
                                      ? 8.0.h
                                      : 24.0.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0.w,
                                  ),
                                  minVerticalPadding: 16.0.h,
                                  title: Text(
                                    '$day $month $year',
                                    style: TextStyle(
                                      color: AppColor.brown,
                                      fontSize: AppFontSize.button,
                                    ),
                                  ),
                                  subtitle: Text(
                                    donorHistories[index].location,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: AppFontSize.body,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                            child: Text(
                              'Belum ada riwayat donor.',
                              style: TextStyle(
                                fontSize: AppFontSize.body,
                              ),
                            ),
                          );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.red,
        child: const FaIcon(FontAwesomeIcons.plus),
        onPressed: () {
          showDonorHistoryForm(context);
        },
      ),
    );
  }

  Future<dynamic> showSignOutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Anda yakin ingin keluar dari aplikasi?'),
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
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthUnauthenticated) {
                  context.goNamed('auth');
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                }
              },
              child: TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(SignOut(_user!.email!));
                },
                child: Text(
                  'Ya',
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: AppFontSize.body,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future showDonorHistoryForm(BuildContext context) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    Timestamp? date;
    DateTime? pickedDate;

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocConsumer<DonorHistoryBloc, DonorHistoryState>(
          listener: (context, state) {
            if (state is DonorHistoryLoaded) {
              Navigator.pop(context);
              dateController.clear();
              locationController.clear();
              pickedDate = DateTime.now();
            } else if (state is DonorHistoryError) {
              Navigator.pop(context);
              dateController.clear();
              locationController.clear();
              pickedDate = DateTime.now();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: Text(
                        'Tambah Riwayat Donor',
                        style: TextStyle(
                          fontSize: AppFontSize.heading,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: DateField(
                        controller: dateController,
                        labelText: 'Tanggal Donor',
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
                            dateController.text = formattedDate;
                            date = Timestamp.fromDate(pickedDate!);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 16.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: TextInputField(
                        labelText: 'Lokasi Donor',
                        controller: locationController,
                      ),
                    ),
                    SizedBox(height: 16.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: state is DonorHistoryLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColor.red,
                                    ),
                                  )
                                : PrimaryButton(
                                    title: 'Tambah',
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<DonorHistoryBloc>().add(
                                              CreateDonorHistory(
                                                email: _user!.email!,
                                                date: date!,
                                                location:
                                                    locationController.text,
                                              ),
                                            );
                                      }
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.0.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
