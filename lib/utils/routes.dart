import 'package:donor_darah/ui/screens/auth_screen.dart';
import 'package:donor_darah/ui/screens/home_screen.dart';
import 'package:donor_darah/ui/screens/register_screen.dart';
import 'package:donor_darah/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (BuildContext context, GoRouterState state) =>
          const AuthScreen(),
      routes: <GoRoute>[
        GoRoute(
          path: 'register',
          builder: (BuildContext context, GoRouterState state) =>
              const RegisterScreen(),
        ),
      ],
    ),
  ],
);
