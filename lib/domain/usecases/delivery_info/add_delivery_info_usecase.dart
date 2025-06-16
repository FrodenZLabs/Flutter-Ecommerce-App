import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/data/models/user/delivery_info_model.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/delivery-info.dart';
import 'package:flutter_ecommerce_app/domain/repositories/delivery_info_repository.dart';

class AddDeliveryInfoUsecase implements Usecase<DeliveryInfo, DeliveryInfoModel> {
  final DeliveryInfoRepository repository;

  AddDeliveryInfoUsecase(this.repository);

  @override
  Future<Either<Failure, DeliveryInfo>> call(DeliveryInfoModel params) async {
    return await repository.addDeliveryInfo(params);
  }
}