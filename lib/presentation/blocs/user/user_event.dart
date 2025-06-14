part of 'user_bloc.dart';

abstract class UserEvent {}

class SignInUser extends UserEvent {
  final SignInParams params;
  SignInUser(this.params);
}

class SignOutUser extends UserEvent {}


