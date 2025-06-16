import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/repositories/order_repository.dart';

class DeleteLocalUsecase implements Usecase<NoParams, NoParams> {
  final OrderRepository repository;

  DeleteLocalUsecase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.deleteLocalOrders();
  }
}