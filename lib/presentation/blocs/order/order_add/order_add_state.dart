part of 'order_add_cubit.dart';

@immutable
abstract class OrderAddState {}

final class OrderAddInitial extends OrderAddState {}

final class OrderAddLoading extends OrderAddState {}

final class OrderAddSuccess extends OrderAddState {
  final OrderDetails order;
  OrderAddSuccess(this.order);
}

final class OrderAddFail extends OrderAddState {}
