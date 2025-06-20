import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/network/network_info.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/order_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/order_remote_data_source.dart';
import 'package:flutter_ecommerce_app/data/models/order/order_details_model.dart';
import 'package:flutter_ecommerce_app/domain/entities/order/order_details.dart';
import 'package:flutter_ecommerce_app/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final OrderLocalDataSource localDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource, required this.userLocalDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, OrderDetails>> addOrder(OrderDetails params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }

    try {
      final result = await remoteDataSource.addOrder(OrderDetailsModel.fromEntity(params), token);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> deleteLocalOrders() async {
    try {
      await localDataSource.clearOrder();
      return Right(NoParams());
    } on Failure catch(failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getLocalOrders() async {
    try {
      final result = await localDataSource.getOrders();
      return Right(result);
    } on Failure catch(failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getRemoteOrders() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    final token = await userLocalDataSource.getToken();
    if (token.isEmpty) {
      return Left(AuthenticationFailure());
    }

    try {
      final result = await remoteDataSource.getOrders(token);
      await localDataSource.saveOrders(result);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

}