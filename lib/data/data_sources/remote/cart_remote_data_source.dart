import 'dart:convert';

import 'package:flutter_ecommerce_app/core/constant/strings.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/data/models/cart/cart_item_model.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  Future<CartItemModel> addToCart(CartItemModel cartItem, String token);
  Future<List<CartItemModel>> syncCart(List<CartItemModel> cart, String token);
  Future<CartItemModel> deleteCartItem(CartItemModel cart, String token);
  Future<NoParams> deleteCart(String token);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final http.Client client;

  CartRemoteDataSourceImpl({required this.client});

  @override
  Future<CartItemModel> addToCart(CartItemModel cartItem, String token) async {
    final response = await client.post(Uri.parse('$baseUrl/carts'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(cartItem.toBodyJson())
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> val = jsonDecode(response.body)['data'];
      return CartItemModel.fromJson(val);
    }  else {
      throw ServerFailure();
    }
  }

  @override
  Future<NoParams> deleteCart(String token) {
    // TODO: implement deleteCart
    throw UnimplementedError();
  }

  @override
  Future<CartItemModel> deleteCartItem(CartItemModel cart, String token) {
    // TODO: implement deleteCartItem
    throw UnimplementedError();
  }

  @override
  Future<List<CartItemModel>> syncCart(List<CartItemModel> cart, String token) async {
    final response = await client.post(Uri.parse('$baseUrl/carts/sync'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "data": cart.map((e) => {
          "product": e.product.id,
          "priceTag": e.priceTag.id,
        }).toList()
      })
    );

    if (response.statusCode == 200) {
      var list = cartItemModelListFromRemoteJson(response.body);
      return list;
    }  else {
      throw ServerFailure();
    }
  }
}