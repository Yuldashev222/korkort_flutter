part of 'language_bloc.dart';

@immutable
abstract class LanguageState {
  final List<LanguageResponse>?languageResponse;
  LanguageState({this.languageResponse});
}

class LanguageInitial extends LanguageState {}
class LanguageError extends LanguageState {}
class LanguageLoaded extends LanguageState {
  final List<LanguageResponse>?languageResponse;
LanguageLoaded({this.languageResponse}):super(languageResponse: languageResponse);
}
