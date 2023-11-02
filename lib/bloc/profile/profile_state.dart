part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {
  final ProfileResponse? profileResponse;

  ProfileState({this.profileResponse});
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}
class ProfileUpdateLoaded extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileResponse? profileResponse;

  ProfileLoaded({this.profileResponse}):super(profileResponse: profileResponse);
}

class ProfileError extends ProfileState {}
