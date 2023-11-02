part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Emittable {
  AuthEvent({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.linkType,
    this.uid,
    this.token,
    this.newPassword,
    this.idToken
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? linkType;
  final String? newPassword;
  final String? uid;
  final String? token;
  final String? idToken;
}

class Register extends AuthEvent {
  Register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) : super(firstName: firstName, lastName: lastName, email: email, password: password);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

class Login extends AuthEvent {
  Login({
    required String email,
    required String password,
  }) : super(email: email, password: password);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}class GoogleSignInEvent extends AuthEvent {
  GoogleSignInEvent({
    required String idToken,
  }) : super(idToken: idToken);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

class ResetPassword extends AuthEvent {
  ResetPassword({
    required String email,
    required String linkType,
  }) : super(email: email, linkType: linkType);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}

class ResetPasswordConfirm extends AuthEvent {
  ResetPasswordConfirm({
    required String uid,
    required String token,
    required String newPassword,
  }) : super(uid: uid, token: token,newPassword: newPassword);

  @override
  void emit(Object? state) {
    // TODO: implement emit
  }
}
