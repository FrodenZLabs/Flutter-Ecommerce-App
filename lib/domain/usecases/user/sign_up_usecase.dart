import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/user.dart';
import 'package:flutter_ecommerce_app/domain/repositories/user_repository.dart';

class SignUpUsecase implements Usecase<User, SignUpParams> {
  final UserRepository repository;

  SignUpUsecase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signUp(params);
  }
}

class SignUpParams extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const SignUpParams({required this.firstName, required this.lastName, required this.email, required this.password});

  @override
  List<Object?> get props => [firstName, lastName, email, password];

}