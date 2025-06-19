import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/network/network_info.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/cart_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:flutter_ecommerce_app/data/models/cart/cart_item_model.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart/cart_item.dart';
import 'package:flutter_ecommerce_app/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  CartRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource, required this.userLocalDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, CartItem>> addCartItem(CartItem params) async {
    final token = await userLocalDataSource.getToken();
    if (token.isEmpty || !await networkInfo.isConnected) {
      // Check if the token is empty or if the network is not connected.
      // If so, save the cart item locally and return it
      // Otherwise, proceed with the remote data source
      await localDataSource.saveCartItem(CartItemModel.fromParent(params));
      return Right(params);
    }

    // Proceed with the remote data source and save the cart item locally after receiving the response
    final cartItemModel = CartItemModel.fromParent(params);
    final remoteResponse = await remoteDataSource.addToCart(cartItemModel, token);
    await localDataSource.saveCartItem(remoteResponse);
    return Right(remoteResponse);
  }

  @override
  Future<Either<Failure, NoParams>> deleteCart() async {
    final token = await userLocalDataSource.getToken();
    if (token.isEmpty || !await networkInfo.isConnected) {
      localDataSource.deleteCart();
      return Right(NoParams());
    }

    final remoteResponse = await remoteDataSource.deleteCart(token);
    await localDataSource.deleteCart();
    return Right(remoteResponse);
  }

  @override
  Future<Either<Failure, CartItem>> deleteCartItem(CartItem params) async {
    final token = await userLocalDataSource.getToken();
    final cartItem = CartItemModel.fromParent(params);

    if (token.isEmpty || !await networkInfo.isConnected) {
      localDataSource.deleteCartItem(cartItem);
      return Right(cartItem);
    }

    final remoteResponse = await remoteDataSource.deleteCartItem(cartItem, token);
    await localDataSource.deleteCartItem(remoteResponse);
    return Right(remoteResponse);
  }

  @override
  Future<Either<Failure, List<CartItem>>> getLocalCartItems() async {
    try {
      final localProducts = await localDataSource.getCart();
      return Right(localProducts);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getRemoteCartItems() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    if (!await userLocalDataSource.isTokenAvailable()) {
      return Left(AuthenticationFailure());
    }

    List<CartItemModel> localCartItems = [];
    try {
      final String token = await userLocalDataSource.getToken();
      final syncedResult = await remoteDataSource.syncCart(localCartItems, token);
      await localDataSource.saveCart(syncedResult);
      return Right(syncedResult);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}