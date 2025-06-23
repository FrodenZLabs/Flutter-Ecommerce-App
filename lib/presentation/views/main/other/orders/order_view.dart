import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/order/order_fetch/order_fetch_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/order_info_card.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: BlocBuilder<OrderFetchCubit, OrderFetchState>(
        builder: (context, state) {
          if (state is OrderFetchLoading && state.orders.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(kOrderDelivery),
                const Text("Orders are empty"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            );
          }
          if (state is OrderFetchSuccess) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 6,
              padding: EdgeInsets.only(
                top: 10,
                right: 20,
                left: 20,
                bottom: (10 + MediaQuery.of(context).padding.bottom),
              ),
              itemBuilder: (context, index) =>
                  OrderInfoCard(orderDetails: state.orders[index]),
            );
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 6,
              padding: EdgeInsets.only(
                top: 10,
                right: 20,
                left: 20,
                bottom: (10 + MediaQuery.of(context).padding.bottom),
              ),
              itemBuilder: (context, index) => OrderInfoCard(),
            );
          }
        },
      ),
    );
  }
}
