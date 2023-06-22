import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/blocs/auth/auth_bloc.dart';
import '../../../core/constants/constants.dart';

Future<dynamic> showSignOutDialog(BuildContext context) {
  final User? user = FirebaseAuth.instance.currentUser;

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
                context.read<AuthBloc>().add(SignOut(user!.email!));
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
