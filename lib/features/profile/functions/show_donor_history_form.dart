import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../../core/widgets/input_fields/input_fields.dart';
import '../blocs/donor_history/donor_history_bloc.dart';

Future showDonorHistoryForm(BuildContext context) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
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
                                              email: user!.email!,
                                              date: date!,
                                              location: locationController.text,
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
