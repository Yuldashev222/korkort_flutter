part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent extends Emittable {
  final String? email;
  final String? code;
  final String? newPassword;

  ForgotPasswordEvent({this.email, this.newPassword, this.code});
}

class ForgotPasswordResetCodeEvent extends ForgotPasswordEvent {
  final String? email;

  ForgotPasswordResetCodeEvent({this.email}) : super(email: email);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

class ForgotPasswordResetCheckCodeEvent extends ForgotPasswordEvent {
  final String? email;
  final String? newPassword;
  final String? code;

  ForgotPasswordResetCheckCodeEvent({this.email, this.code, this.newPassword}) : super(email: email, newPassword: newPassword, code: code);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}class ForgotPasswordResetNewPasswordEvent extends ForgotPasswordEvent {
  final String? email;
  final String? newPassword;
  final String? code;

  ForgotPasswordResetNewPasswordEvent({this.email, this.code, this.newPassword}) : super(email: email, newPassword: newPassword, code: code);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
