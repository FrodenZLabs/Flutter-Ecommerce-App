import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product_response.dart';
import 'package:flutter_ecommerce_app/domain/usecases/product/get_product_usecase.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductResponse>> getRemoteProducts(FilterProductParams params);
  Future<Either<Failure, ProductResponse>> getLocalProducts(FilterProductParams params);
}