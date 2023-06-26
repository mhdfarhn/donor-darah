import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'core/blocs/app_bloc_observer.dart';
import 'core/blocs/auth/auth_bloc.dart';
import 'core/blocs/maps/maps_bloc.dart';
import 'core/blocs/marker/marker_bloc.dart';
import 'core/blocs/position/position_bloc.dart';
import 'core/blocs/profile/profile_bloc.dart';
import 'core/constants/constants.dart';
import 'core/utils/router.dart';
import 'features/donor_request/blocs/donor_request/donor_request_bloc.dart';
import 'features/home/blocs/active_donor_requests/active_donor_requests_bloc.dart';
import 'features/home/blocs/success_donor_requests/success_donor_requests_bloc.dart';
import 'features/notofication/bloc/notification_bloc.dart';
import 'features/profile/blocs/current_user_donor/current_user_donor_request_bloc.dart';
import 'features/profile/blocs/donor_history/donor_history_bloc.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  Bloc.observer = AppBlocObserver();

  return runApp(const MainApp());
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    enableLights: true,
    ledColor: AppColor.red,
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          enableLights: true,
          icon: 'notification_icon',
          ledColor: AppColor.red,
          ledOffMs: 1000,
          ledOnMs: 500,
          styleInformation: BigTextStyleInformation(notification.body!),
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupFlutterNotifications();
  showFlutterNotification(message);
}

class MainApp extends StatefulWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? initialMessage;
  bool resolved = false;

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then(
          (value) => setState(() {
            resolved = true;
            initialMessage = value?.data.toString();
          }),
        );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      context.goNamed('notification');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ActiveDonorRequestsBloc(),
            ),
            BlocProvider(
              create: (context) => AuthBloc(),
            ),
            BlocProvider(
              create: (context) => CurrentUserDonorRequestBloc(),
            ),
            BlocProvider(
              create: (context) => DonorHistoryBloc(),
            ),
            BlocProvider(
              create: (context) => DonorRequestBloc(),
            ),
            BlocProvider(
              create: (context) => MarkerBloc(),
            ),
            BlocProvider(
              create: (context) => MapsBloc(),
            ),
            BlocProvider(
              create: (context) => NotificationBloc(),
            ),
            BlocProvider(
              create: (context) => PositionBloc(),
            ),
            BlocProvider(
              create: (context) => ProfileBloc(),
            ),
            BlocProvider(
              create: (context) => SuccessDonorRequestsBloc(),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                color: AppColor.red,
              ),
            ),
            title: AppString.appTitle,
          ),
        );
      },
    );
  }
}
