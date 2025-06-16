import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart/cart_item.dart';
import 'package:flutter_ecommerce_app/domain/repositories/cart_repository.dart';

class GetRemoteCartItemsUsecase implements Usecase<List<CartItem>, NoParams> {
  final CartRepository repository;

  GetRemoteCartItemsUsecase(this.repository);

  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams params) async {
    return await repository.getRemoteCartItems();
  }
}