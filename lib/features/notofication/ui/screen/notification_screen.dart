import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../bloc/notification_bloc.dart';
import '../../data/models/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    context.read<NotificationBloc>().add(LoadNotifications());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.red,
              ),
            );
          } else if (state is NotificationError) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0.w,
              ),
              child: Center(
                child: Text(
                  state.error,
                  style: TextStyle(
                    fontSize: AppFontSize.body,
                  ),
                ),
              ),
            );
          } else if (state is NotificationLoaded) {
            List<NotificationModel> notifications = state.notifications;

            return notifications.isNotEmpty
                ? ListView(
                    children: List.generate(
                      notifications.length,
                      (index) {
                        NotificationModel notification = notifications[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: EdgeInsets.fromLTRB(
                            16.0.w,
                            index != 0 ? 8.0.h : 16.0.h,
                            16.0.w,
                            8.0.h,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w,
                              vertical: 8.0.h,
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notification.title,
                                        style: TextStyle(
                                          fontSize: AppFontSize.body,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4.0.h),
                                      Text(
                                        notification.text,
                                        style: TextStyle(
                                          fontSize: AppFontSize.body,
                                        ),
                                      ),
                                      SizedBox(height: 4.0.h),
                                      Text(
                                        AppFunction.date(
                                            notification.createdAt),
                                        style: TextStyle(
                                          fontSize: AppFontSize.caption,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  splashRadius: 20.0,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    color: AppColor.red,
                                    size: 28.0,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                    ),
                    child: Center(
                      child: Text(
                        'Tidak ada notifikasi.',
                        style: TextStyle(
                          fontSize: AppFontSize.body,
                        ),
                      ),
                    ),
                  );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
