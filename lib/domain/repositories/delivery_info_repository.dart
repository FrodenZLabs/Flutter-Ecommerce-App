import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/data/models/user/delivery_info_model.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/delivery-info.dart';

abstract class DeliveryInfoRepository {
  Future<Either<Failure, List<DeliveryInfo>>> getRemoteDeliveryInfo();
  Future<Either<Failure, List<DeliveryInfo>>> getLocalDeliveryInfo();
  Future<Either<Failure, DeliveryInfo>> addDeliveryInfo(DeliveryInfoModel params);
  Future<Either<Failure, DeliveryInfo>> editDeliveryInfo(DeliveryInfoModel params);
  Future<Either<Failure, DeliveryInfo>> selectDeliveryInfo(DeliveryInfo params);
  Future<Either<Failure, DeliveryInfo>> getSelectedDeliveryInfo();
  Future<Either<Failure, NoParams>> deleteLocalDeliveryInfo();
}