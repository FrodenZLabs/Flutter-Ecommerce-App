import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/user.dart';
import 'package:flutter_ecommerce_app/domain/usecases/sign_in_usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> signIn(SignInParams params);
}