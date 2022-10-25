import 'package:bloc/bloc.dart';
import 'package:donor_darah/data/models/models.dart';
import 'package:donor_darah/data/services/auth_service.dart';
import 'package:donor_darah/data/services/firestore_service.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  AuthBloc() : super(AuthInitial()) {
    on<SignUpRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.signUp(email: event.email, password: event.password);
        await _firestoreService.createUser(event.user);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(Unauthenticated());
      }
    });

    on<SignInRequest>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.signIn(email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(Unauthenticated());
      }
    });

    on<SignOut>((event, emit) async {
      emit(AuthLoading());
      await _authService.signOut();
      emit(Unauthenticated());
    });
  }
}
