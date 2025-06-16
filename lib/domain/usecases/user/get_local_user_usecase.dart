import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/user.dart';
import 'package:flutter_ecommerce_app/domain/repositories/user_repository.dart';

class GetLocalUserUsecase implements Usecase<User, NoParams> {
  final UserRepository repository;
  GetLocalUserUsecase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getLocalUser();
  }
}