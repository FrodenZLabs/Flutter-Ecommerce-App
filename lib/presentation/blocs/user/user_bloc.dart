import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/user.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/get_local_user_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_in_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_out_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_up_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignInUsecase _signInUsecase;
  final SignUpUsecase _signUpUsecase;
  final GetLocalUserUsecase _getCachedUserUsecase;
  final SignOutUsecase _signOutUsecase;

  UserBloc(this._signInUsecase, this._getCachedUserUsecase, this._signOutUsecase, this._signUpUsecase) : super(UserInitial()) {
    on<SignInUser>(_onSignIn);
    on<SignUpUser>(_onSignUp);
    on<CheckUser>(_onCheckUser);
    on<SignOutUser>(_onSignOut);
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

  FutureOr<void> _onSignUp(SignUpUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signUpUsecase(event.params);
      result.fold(
              (failure) => emit(UserLoggedFail(failure)),
              (user) => emit(UserLogged(user))
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onCheckUser(CheckUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _getCachedUserUsecase(NoParams());
      result.fold(
              (failure) => emit(UserLoggedFail(failure)),
          (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onSignOut(SignOutUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      await _signOutUsecase(NoParams());
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }
}
