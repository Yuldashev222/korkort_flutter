import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

import '../../repository/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<Register>((event, emit) async {
      emit(RegisterLoading());
      await repository.postRegister(firstName: event.firstName, lastName: event.lastName, email: event.email, password: event.password,language: getStorage.read("language")).then((value)async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(RegisterError(data: value?.data));
          if(value?.statusCode==401){
           await getStorage.remove("token");
          }
        } else {
          emit(RegisterLoaded(dataSuccess: value));
        }
      }).onError((error, stackTrace) {});
    });
    on<GoogleSignInEvent>((event, emit) async {
      emit(LoginLoading());
      await repository.googleSignIn(idToken: event.idToken,language: getStorage.read("language")).then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(LoginError(data: value?.data));
        } else {
          await getStorage.write('token', value?.data['token']);
          emit(LoginLoaded(data: value?.data));
        }
      }).onError((error, stackTrace) {});
    });
    on<Login>((event, emit) async {
      emit(LoginLoading());
      await repository.postSignIn(email: event.email, password: event.password,language: getStorage.read("language")).then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(LoginError(data: value?.data));
        } else {
          await getStorage.write("token", value?.data["token"]);
          print("jsjsjs jj "+ getStorage.read("token"));
          emit(LoginLoaded(data: value?.data));
        }
      }).onError((error, stackTrace) {});
    });
    on<ResetPassword>((event, emit) async {
      emit(ForgotLoading());
      await repository.sendEmailReset(email: event.email, linkType: event.linkType,language: getStorage.read("language")).then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(ForgotError(data: value?.data));
        } else {
          emit(ForgotLoaded());
        }
      }).onError((error, stackTrace) {});
    });
    on<ResetPasswordConfirm>((event, emit) async {
      emit(ConfirmLoading());
      await repository.sendEmailResetConfirm(uid: event.uid, token: event.token, newPassword: event.newPassword,language: getStorage.read("language")).then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(ConfirmError(data: value?.data));
        } else {
          emit(ConfirmLoaded());
        }
      }).onError((error, stackTrace) {});
    });
  }
}
