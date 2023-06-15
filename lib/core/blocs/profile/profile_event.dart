part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentUserProfile extends ProfileEvent {
  final String email;

  const LoadCurrentUserProfile(this.email);

  @override
  List<Object> get props => [email];
}

class UpdateProfile extends ProfileEvent {
  final UserModel user;

  const UpdateProfile(this.user);

  @override
  List<Object> get props => [user];
}
