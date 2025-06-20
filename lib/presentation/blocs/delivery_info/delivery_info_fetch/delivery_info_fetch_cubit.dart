import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/delivery-info.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/delete_local_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/get_local_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/get_remote_delivery_info_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/delivery_info/get_selected_delivery_info_usecase.dart';

part 'delivery_info_fetch_state.dart';

class DeliveryInfoFetchCubit extends Cubit<DeliveryInfoFetchState> {
  final GetRemoteDeliveryInfoUsecase _getRemoteDeliveryInfoUsecase;
  final GetLocalDeliveryInfoUsecase _getLocalDeliveryInfoUsecase;
  final GetSelectedDeliveryInfoUsecase _getSelectedDeliveryInfoUsecase;
  final DeleteLocalDeliveryInfoUsecase _deleteLocalDeliveryInfoUsecase;

  DeliveryInfoFetchCubit(this._getRemoteDeliveryInfoUsecase, this._getLocalDeliveryInfoUsecase, this._getSelectedDeliveryInfoUsecase, this._deleteLocalDeliveryInfoUsecase) : super(const DeliveryInfoFetchInitial(deliveryInformation: []));

  void fetchDeliveryInfo() async {
    try {
      emit(DeliveryInfoFetchLoading(deliveryInformation: const [], selectedDeliveryInformation: state.selectedDeliveryInformation));
      final cachedResult = await _getLocalDeliveryInfoUsecase(NoParams());
      cachedResult.fold(
          (failure) => (),
          (deliveryInfo) => emit(DeliveryInfoFetchSuccess(deliveryInformation: deliveryInfo, selectedDeliveryInformation: state.selectedDeliveryInformation))
      );

      final selectedDeliveryInfo = await _getSelectedDeliveryInfoUsecase(NoParams());
      selectedDeliveryInfo.fold(
          (failure) => (),
          (deliveryInfo) => emit(DeliveryInfoFetchSuccess(deliveryInformation: state.deliveryInformation, selectedDeliveryInformation: deliveryInfo))
      );

      final result = await _getRemoteDeliveryInfoUsecase(NoParams());
      result.fold(
              (failure) => emit(DeliveryInfoFetchFail(deliveryInformation: state.deliveryInformation)),
              (deliveryInfo) => emit(DeliveryInfoFetchSuccess(deliveryInformation: deliveryInfo, selectedDeliveryInformation: state.selectedDeliveryInformation))
      );
    } catch (e) {
      emit(DeliveryInfoFetchFail(deliveryInformation: state.deliveryInformation, selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }

  void addDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(DeliveryInfoFetchLoading(deliveryInformation: state.deliveryInformation, selectedDeliveryInformation: state.selectedDeliveryInformation));
      final value = state.deliveryInformation;
      value.add(deliveryInfo);
      emit(DeliveryInfoFetchSuccess(deliveryInformation: value, selectedDeliveryInformation: state.selectedDeliveryInformation));
    } catch (e) {
      emit(DeliveryInfoFetchFail(deliveryInformation: state.deliveryInformation, selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }

  void editDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(DeliveryInfoFetchLoading(deliveryInformation: state.deliveryInformation, selectedDeliveryInformation: state.selectedDeliveryInformation));
      final value = state.deliveryInformation;
      value[value.indexWhere((element) => element == deliveryInfo)];
      emit(DeliveryInfoFetchSuccess(deliveryInformation: value, selectedDeliveryInformation: state.selectedDeliveryInformation));
    } catch (e) {
      emit(DeliveryInfoFetchFail(deliveryInformation: state.deliveryInformation, selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }

  void selectDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(DeliveryInfoFetchLoading(deliveryInformation: state.deliveryInformation, selectedDeliveryInformation: state.selectedDeliveryInformation));
      emit(DeliveryInfoFetchSuccess(deliveryInformation: state.deliveryInformation, selectedDeliveryInformation: deliveryInfo));
    } catch (e) {
      emit(DeliveryInfoFetchFail(deliveryInformation: state.deliveryInformation, selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }

  void clearLocalDeliveryInfo(DeliveryInfo deliveryInfo) async {
    try {
      emit(DeliveryInfoFetchLoading(deliveryInformation: state.deliveryInformation, selectedDeliveryInformation: state.selectedDeliveryInformation));
      final cachedResult = await _deleteLocalDeliveryInfoUsecase(NoParams());
      cachedResult.fold(
              (failure) => (),
              (deliveryInfo) => emit(DeliveryInfoFetchSuccess(deliveryInformation: [], selectedDeliveryInformation: null))
      );
    } catch (e) {
      emit(DeliveryInfoFetchFail(deliveryInformation: state.deliveryInformation, selectedDeliveryInformation: state.selectedDeliveryInformation));
    }
  }
}
