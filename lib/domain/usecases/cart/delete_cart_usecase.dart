import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/repositories/cart_repository.dart';

class DeleteCartUsecase implements Usecase<NoParams, NoParams> {
  final CartRepository repository;

  DeleteCartUsecase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.deleteCart();
  }
}