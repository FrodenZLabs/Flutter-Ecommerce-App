import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart/cart_item.dart';
import 'package:flutter_ecommerce_app/domain/repositories/cart_repository.dart';

class AddCartItemUsecase implements Usecase<CartItem, CartItem> {
  final CartRepository repository;

  AddCartItemUsecase(this.repository);

  @override
  Future<Either<Failure, CartItem>> call(CartItem params) async {
    return await repository.addCartItem(params);
  }
}