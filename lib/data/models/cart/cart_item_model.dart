import 'dart:convert';
import 'package:flutter_ecommerce_app/data/models/product/price_tag_model.dart';
import 'package:flutter_ecommerce_app/data/models/product/product_model.dart';
import '../../../domain/entities/cart/cart_item.dart';

List<CartItemModel> cartItemModelListFromLocalJson(String str) =>
    List<CartItemModel>.from(
        json.decode(str).map((x) => CartItemModel.fromJson(x)));

List<CartItemModel> cartItemModelListFromRemoteJson(String str) =>
    List<CartItemModel>.from(
        json.decode(str)["data"].map((x) => CartItemModel.fromJson(x)));

List<CartItemModel> cartItemModelFromJson(String str) =>
    List<CartItemModel>.from(
        json.decode(str).map((x) => CartItemModel.fromJson(x)));

String cartItemModelToJson(List<CartItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItemModel extends CartItem {
  const CartItemModel({
    super.id,
    required ProductModel super.product,
    required PriceTagModel super.priceTag,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json["_id"],
      product: ProductModel.fromJson(json["product"]),
      priceTag: PriceTagModel.fromJson(json["priceTag"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product": (product as ProductModel).toJson(),
    "priceTag": (priceTag as PriceTagModel).toJson(),
  };

  Map<String, dynamic> toBodyJson() => {
    "_id": id,
    "product": product.id,
    "priceTag": priceTag.id,
  };

  factory CartItemModel.fromParent(CartItem cartItem) => CartItemModel(
    id: cartItem.id,
    product: cartItem.product as ProductModel,
    priceTag: cartItem.priceTag as PriceTagModel,
  );
}