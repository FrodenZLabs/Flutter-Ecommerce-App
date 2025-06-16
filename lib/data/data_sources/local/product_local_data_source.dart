import 'dart:convert';

import 'package:flutter_ecommerce_app/core/error/exceptions.dart';
import 'package:flutter_ecommerce_app/data/models/product/product_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
  Future<ProductResponseModel> getLastProducts();
  Future<void> saveProducts(ProductResponseModel productsToCache);
}

const cachedProducts = "CACHED_PRODUCTS";

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ProductResponseModel> getLastProducts() {
    final jsonString = sharedPreferences.getString(cachedProducts);
    if (jsonString != null) {
      return Future.value(productResponseModelFromJson(jsonDecode(jsonString)));
    }  else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveProducts(ProductResponseModel productsToCache) {
    return sharedPreferences.setString(cachedProducts, json.encode(productResponseModelToJson(productsToCache)));
  }
}