import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/data/models/order/order_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderDetailsModel>> getOrders();
  Future<void> saveOrders(List<OrderDetailsModel> params);
  Future<void> clearOrder();
}

const cachedOrders = 'CACHED_ORDERS';

class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final SharedPreferences sharedPreferences;

  OrderLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> clearOrder() async {
    await sharedPreferences.remove(cachedOrders);
    return;
  }

  @override
  Future<List<OrderDetailsModel>> getOrders() {
    final jsonString = sharedPreferences.getString(cachedOrders);
    if (jsonString != null) {
      return Future.value(orderDetailsModelListFromLocalJson(jsonString));
    }  else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> saveOrders(List<OrderDetailsModel> params) {
    return sharedPreferences.setString(cachedOrders, orderModelListToJson(params));
  }
}