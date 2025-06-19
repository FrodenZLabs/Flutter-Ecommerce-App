import 'dart:convert';
import 'package:flutter_ecommerce_app/core/constant/strings.dart';
import 'package:flutter_ecommerce_app/core/error/exceptions.dart';
import 'package:flutter_ecommerce_app/data/models/product/product_response_model.dart';
import 'package:flutter_ecommerce_app/domain/usecases/product/get_product_usecase.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  Future<ProductResponseModel> getProducts(FilterProductParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductResponseModel> getProducts(FilterProductParams params) => _getProductFromUrl(
    '$baseUrl/products?keyword=${params.keyword}&pageSize=${params.pageSize}&page=${params.limit}&categories=${jsonEncode(params.categories.map((e) => e.id).toList())}'
  );

  Future<ProductResponseModel> _getProductFromUrl(String url) async {
    final response = await client.get(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      }
    );
    if (response.statusCode == 200) {
      return productResponseModelFromJson(response.body);
    }  else {
      throw ServerExceptions();
    }
  }
}