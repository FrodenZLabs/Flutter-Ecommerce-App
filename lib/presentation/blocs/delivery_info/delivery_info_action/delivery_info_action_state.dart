part of 'delivery_info_action_cubit.dart';

@immutable
sealed class DeliveryInfoActionState {}

final class DeliveryInfoActionInitial extends DeliveryInfoActionState {}

final class DeliveryInfoActionLoading extends DeliveryInfoActionState {}

final class DeliveryInfoAddActionSuccess extends DeliveryInfoActionState {
  final DeliveryInfo deliveryInfo;
  DeliveryInfoAddActionSuccess(this.deliveryInfo);
}

final class DeliveryInfoEditActionSuccess extends DeliveryInfoActionState {
  final DeliveryInfo deliveryInfo;
  DeliveryInfoEditActionSuccess(this.deliveryInfo);
}

final class DeliveryInfoSelectActionSuccess extends DeliveryInfoActionState {
  final DeliveryInfo deliveryInfo;
  DeliveryInfoSelectActionSuccess(this.deliveryInfo);
}

final class DeliveryInfoActionFail extends DeliveryInfoActionState {}
