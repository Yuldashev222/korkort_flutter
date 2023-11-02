import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    Repository repository = Repository();
    GetStorage getStorage=GetStorage();
    on<ForgotPasswordResetCodeEvent>((event, emit) async {
      await repository.passwordResetCode(email: event.email,language: getStorage.read("language")).then((value)async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(ForgotPasswordError());
          if (value?.statusCode == 403) {
            emit(ForgotTimePasswordError());
          }else if(value?.statusCode == 400){
            emit(ForgotPasswordError());
          }
        } else {
          emit(ForgotPasswordLoaded());
        }
      });
    });
    on<ForgotPasswordResetCheckCodeEvent>((event, emit) async {
      await repository.passwordResetCheckCode(email: event.email, newPassword: event.newPassword, code: event.code,language: getStorage.read("language")).then((value) {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(ForgotPasswordCheckError());
        } else {
          emit(ForgotPasswordCheckLoaded());
        }
      });
    });
    on<ForgotPasswordResetNewPasswordEvent>((event, emit) async {
      await repository.passwordResetCheckCode(email: event.email, newPassword: event.newPassword, code: event.code,language: getStorage.read("language")).then((value) {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(ForgotPasswordNewPasswordError(dataError: value?.data));
        } else {
          emit(ForgotPasswordNewPasswordLoaded());
        }
      });
    });
  }
}
