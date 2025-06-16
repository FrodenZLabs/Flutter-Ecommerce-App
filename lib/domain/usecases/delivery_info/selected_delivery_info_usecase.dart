import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/delivery-info.dart';
import 'package:flutter_ecommerce_app/domain/repositories/delivery_info_repository.dart';

class SelectedDeliveryInfoUsecase implements Usecase<DeliveryInfo, DeliveryInfo> {
  final DeliveryInfoRepository repository;

  SelectedDeliveryInfoUsecase(this.repository);

  @override
  Future<Either<Failure, DeliveryInfo>> call(DeliveryInfo params) async {
    return await repository.selectDeliveryInfo(params);
  }
}