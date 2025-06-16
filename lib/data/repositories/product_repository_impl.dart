import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/exceptions.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/network/network_info.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/product_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/product_remote_data_source.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product_response.dart';
import 'package:flutter_ecommerce_app/domain/repositories/product_repository.dart';
import 'package:flutter_ecommerce_app/domain/usecases/product/get_product_usecase.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, ProductResponse>> getLocalProducts(FilterProductParams params) async {
    try {
      final localProducts = await localDataSource.getLastProducts();
      return Right(localProducts);
    } on CacheException {
      return Left(CacheException() as Failure);
    }
  }

  @override
  Future<Either<Failure, ProductResponse>> getRemoteProducts(FilterProductParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteProducts = await remoteDataSource.getProducts(params);
      localDataSource.saveProducts(remoteProducts);
      return Right(remoteProducts);
    } on ServerExceptions {
      return Left(ServerFailure());
    }
  }

}