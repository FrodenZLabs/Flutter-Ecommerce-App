import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/delivery-info.dart';
import 'package:flutter_ecommerce_app/domain/repositories/delivery_info_repository.dart';

class GetSelectedDeliveryInfoUsecase implements Usecase<DeliveryInfo, NoParams> {
  final DeliveryInfoRepository repository;

  GetSelectedDeliveryInfoUsecase(this.repository);

  @override
  Future<Either<Failure, DeliveryInfo>> call(NoParams params) async {
    return await repository.getSelectedDeliveryInfo();
  }
}