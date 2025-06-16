import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/category/category.dart';
import 'package:flutter_ecommerce_app/domain/repositories/category_repository.dart';

class FilterCategoryUsecase implements Usecase<List<Category>, String> {
  final CategoryRepository repository;

  FilterCategoryUsecase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(String params) async {
    return await repository.filterCachedCategories(params);
  }
}