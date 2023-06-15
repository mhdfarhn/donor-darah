import 'package:donor_darah/core/data/models/models.dart';
import 'package:donor_darah/core/data/services/firebase/firestore_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirestoreService _firestore = FirestoreService();

  ProfileBloc() : super(ProfileLoading()) {
    on<LoadCurrentUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        UserModel user = await _firestore.getUser(event.email);
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        _firestore.updateUser(event.user);

        UserModel user = await _firestore.getUser(event.user.email);
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
