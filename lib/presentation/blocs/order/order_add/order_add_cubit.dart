import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/domain/entities/order/order_details.dart';
import 'package:flutter_ecommerce_app/domain/usecases/order/add_order_usecase.dart';

part 'order_add_state.dart';

class OrderAddCubit extends Cubit<OrderAddState> {
  final AddOrderUsecase _addOrderUsecase;

  OrderAddCubit(this._addOrderUsecase) : super(OrderAddInitial());

  void addOrder(OrderDetails params) async {
    try {
      emit(OrderAddLoading());
      final result = await _addOrderUsecase(params);
      result.fold(
          (failure) => emit(OrderAddFail()),
          (order) => emit(OrderAddSuccess(order))
      );
    } catch (e) {
      emit(OrderAddFail());
    }
  }
}
