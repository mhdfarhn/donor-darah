part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;

  const ProfileLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileError extends ProfileState {
  final String error;

  const ProfileError(this.error);

  @override
  List<Object> get props => [error];
}
