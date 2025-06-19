import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart/cart_item.dart';
import 'package:flutter_ecommerce_app/domain/usecases/cart/add_cart_item_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/cart/delete_cart_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/cart/get_local_cart_items_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/cart/get_remote_cart_items_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetLocalCartItemsUsecase _getCachedItemsUsecase;
  final AddCartItemUsecase _addCartItemUsecase;
  final GetRemoteCartItemsUsecase _syncCartUsecase;
  final DeleteCartUsecase _clearCartUsecase;

  CartBloc(this._getCachedItemsUsecase, this._addCartItemUsecase, this._syncCartUsecase, this._clearCartUsecase) : super(CartInitial(cart: [])) {
    on<GetCart>(_onGetCart);
    on<AddProduct>(_onAddToCart);
    on<ClearCart>(_onClearCart);
  }

  void _onGetCart(GetCart event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading(cart: state.cart));
      final result = await _getCachedItemsUsecase(NoParams());
      result.fold(
              (failure) => emit(CartError(failure: failure, cart: state.cart)),
              (cart) => emit(CartLoaded(cart: cart))
      );
      final syncResult = await _syncCartUsecase(NoParams());
      emit(CartLoading(cart: state.cart));
      syncResult.fold(
          (failure) => emit(CartError(failure: failure, cart: state.cart)),
          (cart) => emit(CartLoaded(cart: cart))
      );
    } catch (e) {
      emit(CartError(failure: ExceptionFailure(), cart: state.cart));
    }
  }

  void _onAddToCart(AddProduct event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading(cart: state.cart));
      List<CartItem> cart = [];
      cart.addAll(state.cart);
      cart.add(event.cartItem);
      final result = await _addCartItemUsecase(event.cartItem);
      result.fold(
              (failure) => emit(CartError(failure: failure, cart: state.cart)),
              (_) => emit(CartLoaded(cart: cart))
      );
    } catch (e) {
      emit(CartError(failure: ExceptionFailure(), cart: state.cart));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading(cart: []));
      emit(CartLoaded(cart: []));
      await _clearCartUsecase(NoParams());
    } catch (e) {
      emit(CartError(failure: ExceptionFailure(), cart: const []));
    }
  }
}
