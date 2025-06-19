import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/pagination_meta_data.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product.dart';
import 'package:flutter_ecommerce_app/domain/usecases/product/get_product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUsecase _getProductUsecase;

  ProductBloc(this._getProductUsecase) : super(ProductInitial(
    products: const [], params: const FilterProductParams(), metaData: PaginationMetaData(limit: 0, pageSize: 20, total: 0)
  )) {
    on<GetProducts>(_onLoadProducts);
    on<GetMoreProducts>(_onLoadMoreProducts);
  }

  void _onLoadProducts(GetProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading(products: const [], metaData: state.metaData, params: event.params));

      final result = await _getProductUsecase(event.params);
      result.fold(
              (failure) => emit(ProductError(products: state.products, metaData: state.metaData, params: event.params, failure: failure)),
          (productResponse) => emit(ProductLoaded(products: productResponse.products, metaData: productResponse.paginationMetaData, params: event.params))
      );
    } catch (e) {
      emit(ProductError(products: state.products, metaData: state.metaData, params: state.params, failure: ExceptionFailure()));
    }
  }

  void _onLoadMoreProducts(GetMoreProducts event, Emitter<ProductState> emit) async {
    var state = this.state;
    var limit = state.metaData.limit;
    var total = state.metaData.total;
    var loadedProductsLength = state.products.length;

    if (state is ProductLoaded && (loadedProductsLength < total)) {
      try {
        emit(ProductLoading(products: state.products, metaData: state.metaData, params: state.params));
        final result = await _getProductUsecase(FilterProductParams(limit: limit + 10));
        result.fold(
                (failure) => emit(ProductError(products: state.products, metaData: state.metaData, params: state.params, failure: failure)),
                (productResponse) {
                  List<Product> products = state.products;
                  products.addAll(productResponse.products);
                  emit(ProductLoaded(products: products, metaData: state.metaData, params: state.params));
                }
        );
      } catch (e) {
        emit(ProductError(products: state.products, metaData: state.metaData, params: state.params, failure: ExceptionFailure()));
      }
    }
  }
}
