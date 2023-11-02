import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/model/profile_response.dart';
import 'package:korkort/repository/repository.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    Repository repository = Repository();
    GetStorage getStorage = GetStorage();
    on<ProfileUpdateEvent>((event, emit) async {
      String token = await getStorage.read("token");
      await repository
          .profileUpdate(firstName: event.firstName, lastName: event.lastName, avatar: event.avatar, password: event.password, token: token, language: getStorage.read("language"))
          .then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(ProfileError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          emit(ProfileUpdateLoaded());
        }
      });
    });
    on<ProfileUpdateNoPasswordEvent>((event, emit) async {
      String token = await getStorage.read("token");
      await repository
          .profileUpdateNoPassword(firstName: event.firstName, lastName: event.lastName, avatar: event.avatar,  token: token, language: getStorage.read("language"))
          .then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(ProfileError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          emit(ProfileUpdateLoaded());
        }
      });
    });
    on<ProfileGetEvent>((event, emit) async {
      String token = await getStorage.read("token");
      await repository.profileGet(token: token, language: getStorage.read("language")).then((value) async {
        if (value?.statusCode != null && value?.statusCode as int > 299) {
          emit(ProfileError());
          if (value?.statusCode == 401) {
            await getStorage.remove("token");
          }
        } else {
          emit(ProfileLoaded(profileResponse: ProfileResponse.fromJson(value?.data)));
        }
      });
    });
  }
}
