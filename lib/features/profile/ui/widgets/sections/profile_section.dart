import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/blocs/profile/profile_bloc.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/data/models/models.dart';
import '../../../../../core/widgets/buttons/primary_button.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({
    super.key,
  });

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    context.read<ProfileBloc>().add(LoadCurrentUserProfile(_user!.email!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
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
                          FontAwesomeIcons.solidUser,
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
    );
  }
}
