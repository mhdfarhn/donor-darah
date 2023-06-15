import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/models/models.dart';
import '../../data/services/firebase/firebases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();

  AuthBloc() : super(AuthUnauthenticated()) {
    on<CheckAuthStatus>((event, emit) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? email = sharedPreferences.getString('email');
      String? token = sharedPreferences.getString('token');

      if (email != null && token != null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<SignUpRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        final String? token = await FirebaseMessaging.instance.getToken();

        await _authService
            .signUp(
              email: event.email,
              password: event.password,
              name: event.user.name,
            )
            .then(
              (_) => _firestoreService.createUser(
                event.user,
                token!,
              ),
            );

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('email', event.email);
        sharedPreferences.setString('token', token!);

        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthUnauthenticated());
      }
    });

    on<SignInRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        final String? token = await FirebaseMessaging.instance.getToken();

        await _authService.signIn(email: event.email, password: event.password);

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('email', event.email);
        sharedPreferences.setString('token', token!);

        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthUnauthenticated());
      }
    });

    on<SignOut>((event, emit) async {
      emit(AuthLoading());
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.remove('email');
      sharedPreferences.remove('token');

      await _authService.signOut();
      emit(AuthUnauthenticated());
    });
  }
}
