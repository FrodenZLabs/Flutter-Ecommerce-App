import 'package:flutter_ecommerce_app/data/models/product/price_tag_model.dart';
import 'package:flutter_ecommerce_app/data/models/product/product_model.dart';
import 'package:flutter_ecommerce_app/domain/entities/order/order_item.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel({required super.id, required super.product, required super.priceTag, required super.price, required super.quantity});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
    id: json["_id"],
    product: ProductModel.fromJson(json["product"]),
    priceTag: PriceTagModel.fromJson(json["priceTag"]),
    price: json["price"],
    quantity: json["quantity"]
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product": (product as ProductModel).toJson(),
    "priceTag": (priceTag as PriceTagModel).toJson(),
    "price": price,
    "quantity": quantity,
  };

  Map<String, dynamic> toJsonBody() => {
    "_id": id,
    "product": product.id,
    "priceTag": priceTag.id,
    "price": price,
    "quantity": quantity,
  };

  factory OrderItemModel.fromEntity(OrderItem entity) => OrderItemModel(
      id: entity.id,
      product: ProductModel.fromEntity(entity.product),
      priceTag: PriceTagModel.fromEntity(entity.priceTag),
      price: entity.price,
      quantity: entity.quantity
  );
}