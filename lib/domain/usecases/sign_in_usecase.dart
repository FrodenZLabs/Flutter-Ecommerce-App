import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/user.dart';
import 'package:flutter_ecommerce_app/domain/repositories/user_repository.dart';

class SignInUsecase implements Usecase<User, SignInParams>{
  final UserRepository repository;

  SignInUsecase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await repository.signIn(params);
  }
}

class SignInParams {
  final String username;
  final String password;

  const SignInParams({required this.username, required this.password});
}