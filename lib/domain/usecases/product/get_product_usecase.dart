import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/category/category.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product_response.dart';
import 'package:flutter_ecommerce_app/domain/repositories/product_repository.dart';

class GetProductUsecase implements Usecase<ProductResponse, FilterProductParams> {
  final ProductRepository repository;

  GetProductUsecase(this.repository);

  @override
  Future<Either<Failure, ProductResponse>> call(FilterProductParams params) async {
    return await repository.getRemoteProducts(params);
  }
}

class FilterProductParams {
  final String? keyword;
  final List<Category> categories;
  final double minPrice;
  final double maxPrice;
  final int? limit;
  final int? pageSize;

  const FilterProductParams(
      {this.keyword = "", this.categories = const [], this.minPrice = 0, this.maxPrice = 10000, this.limit = 0, this.pageSize = 10});

  FilterProductParams copyWith({
    int? skip,
    String? keyword,
    List<Category>? categories,
    double? minPrice,
    double? maxPrice,
    int? limit,
    int? pageSize}) => FilterProductParams(
      keyword: keyword ?? this.keyword,
      categories: categories ?? this.categories,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      limit: skip ?? this.limit,
      pageSize: pageSize ?? this.pageSize
  );
}