import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/order/order_details.dart';
import 'package:flutter_ecommerce_app/domain/usecases/order/delete_local_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/order/get_remote_orders_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/get_local_user_usecase.dart';

part 'order_fetch_state.dart';

class OrderFetchCubit extends Cubit<OrderFetchState> {
  final GetRemoteOrdersUsecase _getOrdersUsecase;
  final GetLocalUserUsecase _getCachedUserUsecase;
  final DeleteLocalUsecase _clearLocalOrderUsecase;
  
  OrderFetchCubit(this._getOrdersUsecase, this._getCachedUserUsecase, this._clearLocalOrderUsecase) : super(OrderFetchInitial([]));
  
  void getOrders() async {
    try {
      emit(OrderFetchLoading(state.orders));
      final cachedResult = await _getCachedUserUsecase(NoParams());
      cachedResult.fold(
              (failure) => emit(OrderFetchFail(state.orders)),
              (orders) => emit(OrderFetchSuccess(orders as List<OrderDetails>))
      );

      final remoteResult = await _getOrdersUsecase(NoParams());
      remoteResult.fold(
              (failure) => emit(OrderFetchFail(state.orders)),
              (orders) => emit(OrderFetchSuccess(orders))
      );
    } catch (e) {
      emit(OrderFetchFail(state.orders));
    }
  }

  void clearLocalOrders() async {
    try {
      emit(OrderFetchLoading(state.orders));
      final cachedResult = await _clearLocalOrderUsecase(NoParams());
      cachedResult.fold(
              (failure) => {},
              (result) => emit(OrderFetchInitial([]))
      );
    } catch (e) {
      emit(OrderFetchFail(state.orders));
    }
  }
}
