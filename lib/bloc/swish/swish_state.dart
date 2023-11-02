part of 'swish_bloc.dart';

@immutable
abstract class SwishState {}

class SwishInitial extends SwishState {}
class SwishLoading extends SwishState {}
class SwishLoaded extends SwishState {}
class SwishError extends SwishState {}
