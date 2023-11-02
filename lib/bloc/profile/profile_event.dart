part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Emittable {
  final String? firstName;
  final String? lastName;
  final num? avatar;
  final String? password;

  ProfileEvent({this.firstName, this.lastName, this.avatar, this.password});
}

class ProfileUpdateEvent extends ProfileEvent {
  final String? firstName;
  final String? lastName;
  final num? avatar;
  final String? password;

  ProfileUpdateEvent({this.avatar, this.lastName, this.firstName, this.password}) : super(firstName: firstName, lastName: lastName, avatar: avatar, password: password);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
class ProfileUpdateNoPasswordEvent extends ProfileEvent {
  final String? firstName;
  final String? lastName;
  final num? avatar;

  ProfileUpdateNoPasswordEvent({this.avatar, this.lastName, this.firstName}) : super(firstName: firstName, lastName: lastName, avatar: avatar);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

class ProfileGetEvent extends ProfileEvent {
  ProfileGetEvent() : super();

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
