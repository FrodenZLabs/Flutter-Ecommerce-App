import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/data/models/user/delivery_info_model.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/delivery-info.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/add_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/edit_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/selected_delivery_info_usecase.dart';

part 'delivery_info_action_state.dart';

class DeliveryInfoActionCubit extends Cubit<DeliveryInfoActionState> {
  final AddDeliveryInfoUsecase _deliveryInfoUsecase;
  final EditDeliveryInfoUsecase _editDeliveryInfoUsecase;
  final SelectedDeliveryInfoUsecase _selectedDeliveryInfoUsecase;

  DeliveryInfoActionCubit(
    this._deliveryInfoUsecase,
    this._editDeliveryInfoUsecase,
    this._selectedDeliveryInfoUsecase,
  ) : super(DeliveryInfoActionInitial());

  void addDeliveryInfo(DeliveryInfoModel params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _deliveryInfoUsecase(params);
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoAddActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoActionFail());
    }
  }

  void editDeliveryInfo(DeliveryInfoModel params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _editDeliveryInfoUsecase(params);
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoEditActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoActionFail());
    }
  }

  void selectDeliveryInfo(DeliveryInfo params) async {
    try {
      emit(DeliveryInfoActionLoading());
      final result = await _selectedDeliveryInfoUsecase(params);
      result.fold(
        (failure) => emit(DeliveryInfoActionFail()),
        (deliveryInfo) => emit(DeliveryInfoSelectActionSuccess(deliveryInfo)),
      );
    } catch (e) {
      emit(DeliveryInfoActionFail());
    }
  }
}
