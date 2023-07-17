part of 'logout_cubit.dart';

@immutable
abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutSuccessState extends LogoutState {}

class LogoutLoadingState extends LogoutState {}
