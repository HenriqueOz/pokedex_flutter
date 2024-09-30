part of 'splash_bloc.dart';

abstract class SplashState {}

class SplashLoading extends SplashState {}
class SplashError extends SplashState {
  final String message;
  SplashError({required this.message});
}
class SplashSuccess extends SplashState {}