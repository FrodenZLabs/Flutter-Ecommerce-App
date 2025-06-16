import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/order/order_details.dart';
import 'package:flutter_ecommerce_app/domain/repositories/order_repository.dart';

class AddOrderUsecase implements Usecase<OrderDetails, OrderDetails> {
  final OrderRepository repository;

  AddOrderUsecase(this.repository);

  @override
  Future<Either<Failure, OrderDetails>> call(OrderDetails params) async {
    return await repository.addOrder(params);
  }
}