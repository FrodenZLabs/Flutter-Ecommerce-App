import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/network/network_info.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/data/data_sources/local/user_local_data_source.dart';
import 'package:flutter_ecommerce_app/data/data_sources/remote/user_remote_data_source.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/user.dart';
import 'package:flutter_ecommerce_app/domain/repositories/user_repository.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_in_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_up_usecase.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({required this.remoteDataSource, required this.networkInfo, required this.localDataSource,});

  @override
  Future<Either<Failure, User>> getLocalUser() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signIn(SignInParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signIn(params);
      await localDataSource.saveToken(remoteResponse.token);
      await localDataSource.saveUser(remoteResponse.user);
      return Right(remoteResponse.user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, User>> signUp(SignUpParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signUp(params);
      await localDataSource.saveToken(remoteResponse.token);
      await localDataSource.saveUser(remoteResponse.user);
      return Right(remoteResponse.user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> signOut() async {
    try {
      await localDataSource.clearCache();
      return Right(NoParams());
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }
}