import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/category/category.dart';
import 'package:flutter_ecommerce_app/domain/repositories/category_repository.dart';

class GetLocalCategoryUsecase implements Usecase<List<Category>, NoParams> {
  final CategoryRepository repository;

  GetLocalCategoryUsecase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await repository.getLocalCategories();
  }
}