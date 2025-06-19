import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/usecases/usecase.dart';
import 'package:flutter_ecommerce_app/domain/entities/category/category.dart';
import 'package:flutter_ecommerce_app/domain/usecases/category/filter_category_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/category/get_local_category_usecase.dart';
import 'package:flutter_ecommerce_app/domain/usecases/category/get_remote_category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetRemoteCategoryUsecase _getCategoryUsecase;
  final GetLocalCategoryUsecase _getCachedCategoryUsecase;
  final FilterCategoryUsecase _filterCategoryUsecase;

  CategoryBloc(this._getCategoryUsecase, this._getCachedCategoryUsecase, this._filterCategoryUsecase) : super(CategoryInitial(categories: [])) {
    on<GetCategories>(_onLoadCategories);
    on<FilterCategories>(_onFilterCategories);
  }

  void _onLoadCategories(GetCategories event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading(categories: []));
      final cachedResult = await _getCachedCategoryUsecase(NoParams());
      cachedResult.fold(
          (failure) => (),
          (categories) => emit(CategoryCacheLoaded(categories: categories))
      );

      final result = await _getCategoryUsecase(NoParams());
      result.fold(
          (failure) => emit(CategoryError(categories: state.categories, failure: failure)),
          (categories) => emit(CategoryLoaded(categories: categories))
      );
    } catch (e) {
      EasyLoading.showError(e.toString());
      emit(CategoryError(categories: state.categories, failure: ExceptionFailure()));
    }
  }

  void _onFilterCategories(FilterCategories event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading(categories: state.categories));
      final cachedResult = await _filterCategoryUsecase(event.keyword);
      cachedResult.fold(
              (failure) => emit(CategoryError(categories: state.categories, failure: failure)),
              (categories) => emit(CategoryCacheLoaded(categories: categories))
      );
    } catch (e) {
      emit(CategoryError(categories: state.categories, failure: ExceptionFailure()));
    }
  }
}
