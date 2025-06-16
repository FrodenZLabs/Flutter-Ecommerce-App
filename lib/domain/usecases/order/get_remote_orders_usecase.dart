import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/order/order_details.dart';
import 'package:flutter_ecommerce_app/domain/repositories/order_repository.dart';

class GetRemoteOrdersUsecase implements Usecase<List<OrderDetails>, NoParams> {
  final OrderRepository repository;

  GetRemoteOrdersUsecase(this.repository);

  @override
  Future<Either<Failure, List<OrderDetails>>> call(NoParams params) async {
    return await repository.getRemoteOrders();
  }
}