import 'package:flutter_ecommerce_app/data/models/product/pagination_data_model.dart';
import 'package:flutter_ecommerce_app/data/models/product/product_model.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/pagination_meta_data.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product_response.dart';

class ProductResponseModel extends ProductResponse {
  const ProductResponseModel({required PaginationMetaData meta, required List<Product> data}) : super(products: data, paginationMetaBeta: meta);

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) => ProductResponseModel(
    meta: PaginationMetaDataModel.fromJson(json["meta"]),
    data: List<ProductModel>.from(json["data"].map((x) => ProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": (paginationMetaBeta as PaginationMetaDataModel).toJson(),
    "data": List<dynamic>.from((products as List<ProductModel>).map((x) => x.toJson())),
  };
}