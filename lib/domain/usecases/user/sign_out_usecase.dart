import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/repositories/user_repository.dart';

class SignOutUsecase implements Usecase<NoParams, NoParams> {
  final UserRepository repository;

  SignOutUsecase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.signOut();
  }
}