part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordState {
  final Map? dataError;
  ForgotPasswordState({this.dataError});
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordLoaded extends ForgotPasswordState {}

class ForgotPasswordError extends ForgotPasswordState {}
class ForgotTimePasswordError extends ForgotPasswordState {}

class ForgotPasswordCheckLoading extends ForgotPasswordState {}

class ForgotPasswordCheckLoaded extends ForgotPasswordState {}

class ForgotPasswordCheckError extends ForgotPasswordState {}
class ForgotPasswordNewPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordNewPasswordLoaded extends ForgotPasswordState {}

class ForgotPasswordNewPasswordError extends ForgotPasswordState {
  final Map? dataError;
  ForgotPasswordNewPasswordError({this.dataError}):super(dataError:dataError);
}
