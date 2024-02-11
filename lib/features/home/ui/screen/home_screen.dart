import 'package:donor_darah/core/blocs/maps/maps_bloc.dart';
import 'package:donor_darah/features/home/blocs/active_donor_requests/active_donor_requests_bloc.dart';
import 'package:donor_darah/features/home/blocs/potential_donor/potential_donor_cubit.dart';
import 'package:donor_darah/features/home/blocs/recomendation/recomendation_cubit.dart';
import 'package:donor_darah/features/home/blocs/success_donor_requests/success_donor_requests_bloc.dart';
import 'package:donor_darah/features/home/ui/widgets/sections/donor_location_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../admin/cubit/donor_location_cubit.dart';
import '../widgets/buttons/title_button.dart';
import '../widgets/sections/sections.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<MapsBloc>().add(LoadMaps());
    context.read<DonorLocationCubit>().getActiveDonorLocations();
    context.read<RecomendationCubit>().getRecomendation();
    context.read<ActiveDonorRequestsBloc>().add(LoadActiveDonorRequests());
    context.read<SuccessDonorRequestsBloc>().add(LoadSuccessDonorRequests());
    context.read<PotentialDonorCubit>().loadPotentialDonor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.appTitle),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const TitleText(
              title: 'Peta',
            ),
          ),
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const MapSection(),
          ),
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const TitleText(
              title: 'User Bersedia Donor',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const PotentialDonorInfoSection(),
          ),
          SizedBox(height: 24.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const TitleText(
              title: 'Lokasi Donor Darah',
            ),
          ),
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const DonorLocationSection(),
          ),
          SizedBox(height: 24.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const TitleText(
              title: 'Rekomendasi Pendonor Terdekat',
            ),
          ),
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const RecomendationSection(),
          ),
          SizedBox(height: 24.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const TitleText(
              title: 'Butuh Donor',
            ),
          ),
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const ActiveDonorRequestSection(),
          ),
          SizedBox(height: 24.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const TitleText(
              title: 'Donor Selesai',
            ),
          ),
          SizedBox(height: 16.0.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const SuccessDonorRequestSection(),
          ),
          SizedBox(height: 24.0.h),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.red,
        child: const FaIcon(FontAwesomeIcons.magnifyingGlass),
        onPressed: () {
          context.goNamed('search');
        },
      ),
    );
  }
}
