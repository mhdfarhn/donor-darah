import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/donor_request/ui/screen/donor_request_screen.dart';
import '../../features/edit_profile/ui/screen/edit_profile_screen.dart';
import '../../features/home/ui/screen/home_screen.dart';
// Notification
// import '../../features/notification/ui/screen/notification_screen.dart';
import '../../features/profile/ui/screen/profile_screen.dart';
import '../../features/result/ui/screen/result_screen.dart';
import '../../features/search/ui/screen/search_screen.dart';
import '../../features/sign_in/ui/screen/sign_in_screen.dart';
import '../../features/sign_up/ui/screen/sign_up_screen.dart';
import '../../features/splash/ui/screen/splash_screen.dart';
import '../widgets/scaffold_with_navbar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _profileNavigatorKey =
    GlobalKey<NavigatorState>();
// Notification
// final GlobalKey<NavigatorState> _notificationNavigatorKey =
//     GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const SignInScreen(),
      routes: [
        GoRoute(
          path: 'sign-up',
          name: 'sign_up',
          builder: (context, state) => const SignUpScreen(),
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavbar(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: <GoRoute>[
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
              routes: <GoRoute>[
                GoRoute(
                  path: 'donor-request',
                  name: 'donor_request',
                  builder: (context, state) {
                    Map<String, dynamic> extra =
                        state.extra as Map<String, dynamic>;
                    return DonorRequestScreen(
                      extra: extra,
                    );
                  },
                ),
                GoRoute(
                  path: 'search',
                  name: 'search',
                  builder: (context, state) => const SearchScreen(),
                ),
              ],
            ),
          ],
        ),
        // StatefulShellBranch(
        //   navigatorKey: _notificationNavigatorKey,
        //   routes: <GoRoute>[
        //     GoRoute(
        //       path: '/notification',
        //       name: 'notification',
        //       builder: (context, state) => const NotificationScreen(),
        //     ),
        //   ],
        // ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfileScreen(),
              routes: <GoRoute>[
                GoRoute(
                  path: 'edit-profile',
                  name: 'edit_profile',
                  builder: (context, state) => const EditProfileScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/result',
      name: 'result',
      builder: (context, state) {
        // List<ResultModel> results = state.extra as List<ResultModel>;
        Map<String, dynamic> results = state.extra as Map<String, dynamic>;
        return ResultScreen(extra: results);
      },
    ),
  ],
);
