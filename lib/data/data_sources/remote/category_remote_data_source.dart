import 'package:flutter_ecommerce_app/core/constant/strings.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/data/models/category/category_model.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource{
  final http.Client client;
  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategories() => _getCategoryFromUrl('$baseUrl/categories');

  Future<List<CategoryModel>> _getCategoryFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json"
      }
    );

    if (response.statusCode == 200) {
      return categoryModelListFromRemoteJson(response.body);
    }  else {
      throw ServerFailure();
    }
  }
}