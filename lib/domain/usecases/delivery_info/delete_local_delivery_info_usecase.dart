import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/repositories/delivery_info_repository.dart';

class DeleteLocalDeliveryInfoUsecase implements Usecase<NoParams, NoParams> {
  final DeliveryInfoRepository repository;

  DeleteLocalDeliveryInfoUsecase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.deleteLocalDeliveryInfo();
  }
}