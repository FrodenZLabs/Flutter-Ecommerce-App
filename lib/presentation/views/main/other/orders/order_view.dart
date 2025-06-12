import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/order_info_card.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Image.asset(kOrderDelivery),
      //     const Text("Orders are empty"),
      //     SizedBox(height: MediaQuery.of(context).size.height * 0.1,)
      //   ],
      // ),

      // body: ListView.builder(
      //   physics: const BouncingScrollPhysics(),
      //     itemCount: 6,
      //     padding: EdgeInsets.only(top: 20, right: 20, left: 10, bottom: (10 + MediaQuery.of(context).padding.bottom)),
      //     itemBuilder: (context, index) => OrderInfoCard()
      // ),
      
      // body: ListView.builder(
      //   physics: const BouncingScrollPhysics(),
      //     itemCount: 6,
      //     padding: EdgeInsets.only(top: 20, right: 20, left: 10, bottom: (10 + MediaQuery.of(context).padding.bottom)),
      //     itemBuilder: (context, index) => OrderInfoCard()
      // ),
    );
  }
}
