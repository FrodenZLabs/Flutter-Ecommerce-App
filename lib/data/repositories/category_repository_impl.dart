import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/exceptions.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/network/network_info.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/category_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/category_remote_data_source.dart';
import 'package:flutter_ecommerce_app/domain/entities/category/category.dart';
import 'package:flutter_ecommerce_app/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Category>>> filterCachedCategories(params) async {
    try {
      final cachedCategories = await localDataSource.getCategories();
      final categories = cachedCategories;
      final filteredCategories = categories.where((element) => element.name.toLowerCase().contains(params.toLowerCase())).toList();
      return Right(filteredCategories);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getLocalCategories() async {
    try {
      final localProducts = await localDataSource.getCategories();
      return Right(localProducts);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getRemoteCategories() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final remoteProducts = await remoteDataSource.getCategories();
      localDataSource.saveCategories(remoteProducts);
      return Right(remoteProducts);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}