part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  final dynamic data;

  const AuthState({this.data});

  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterLoaded extends AuthState {
  @override
  final dynamic dataSuccess;

  const RegisterLoaded({this.dataSuccess}) : super(data: dataSuccess);
}

class RegisterError extends AuthState {
  @override
  final dynamic data;

  const RegisterError({this.data}) : super(data: data);
}

class LoginLoading extends AuthState {}

class LoginLoaded extends AuthState {
  final dynamic data;

  LoginLoaded({this.data}) : super(data: data);
}

class LoginError extends AuthState {
  @override
  final dynamic data;

  const LoginError({this.data}) : super(data: data);
}

class ForgotLoading extends AuthState {}

class ForgotLoaded extends AuthState {}

class ForgotError extends AuthState {
  @override
  final dynamic data;

  const ForgotError({this.data}) : super(data: data);
}

class ConfirmLoading extends AuthState {}

class ConfirmLoaded extends AuthState {}

class ConfirmError extends AuthState {
  @override
  final dynamic data;

  const ConfirmError({this.data}) : super(data: data);
}
