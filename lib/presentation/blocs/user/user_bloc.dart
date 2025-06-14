import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/user.dart';
import 'package:flutter_ecommerce_app/domain/usecases/sign_in_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignInUsecase _signInUsecase;


  UserBloc(this._signInUsecase) : super(UserInitial()) {
    on<SignInUser>(_onSignIn);
  }

  void _onSignIn (SignInUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signInUsecase(event.params);
      result.fold(
              (failure) => emit(UserLoggedFail(failure)),
              (user) => emit(UserLogged(user))
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }
}
