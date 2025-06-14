part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

final class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

final class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

final class UserLogged extends UserState {
  final User user;
  UserLogged(this.user);

  @override
  List<Object> get props => [user];
}

final class UserLoggedFail extends UserState {
  final Failure failure;
  UserLoggedFail(this.failure);

  @override
  List<Object> get props => [];
}

final class UserLoggedOut extends UserState {
  @override
  List<Object> get props => [];
}