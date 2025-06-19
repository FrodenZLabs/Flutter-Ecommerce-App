import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/data/models/cart/cart_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CartLocalDataSource{
  Future<List<CartItemModel>> getCart();
  Future<void> saveCart(List<CartItemModel> cart);
  Future<void> saveCartItem(CartItemModel cartItem);
  Future<bool> deleteCartItem(CartItemModel cartItem);
  Future<bool> deleteCart();
}

const cachedCart = 'CACHED_CART';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final SharedPreferences sharedPreferences;

  CartLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> deleteCart() async {
    return sharedPreferences.remove(cachedCart);
  }

  @override
  Future<bool> deleteCartItem(CartItemModel cartItem) async {
    final jsonString = sharedPreferences.getString(cachedCart);
    if (jsonString != null) {
      final List<CartItemModel> cart = cartItemModelListFromLocalJson(jsonString);
      cart.removeWhere((element) => element.product.id == cartItem.product.id && element.priceTag.id == cartItem.priceTag.id);
      return sharedPreferences.setString(cachedCart, cartItemModelToJson(cart));
    }  else {
      throw CacheFailure();
    }
  }

  @override
  Future<List<CartItemModel>> getCart() {
    final jsonString = sharedPreferences.getString(cachedCart);
    if (jsonString != null) {
      return Future.value(cartItemModelListFromLocalJson(jsonString));
    }  else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> saveCart(List<CartItemModel> cart) {
    return sharedPreferences.setString(cachedCart, cartItemModelToJson(cart));
  }

  @override
  Future<void> saveCartItem(CartItemModel cartItem) {
    final jsonString = sharedPreferences.getString(cachedCart);
    final List<CartItemModel> cart = [];
    if (jsonString != null) {
      cart.addAll(cartItemModelListFromLocalJson(jsonString));
    }
    if (!cart.any((element) =>
      element.product.id == cartItem.product.id &&
        element.priceTag.id == cartItem.priceTag.id
    )) {
      cart.add(cartItem);
    }

    return sharedPreferences.setString(cachedCart, cartItemModelToJson(cart));
  }
}