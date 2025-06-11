import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart/cart_item.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/outline_label_card.dart';

class OrderCheckoutView extends StatelessWidget {
  final List<CartItem> items;

  const OrderCheckoutView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Order Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 12,),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: OutlineLabelCard(
                    title: "Delivery Details",
                    child: Container(
                      padding: const EdgeInsets.only(top: 16, bottom: 12, left: 4, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Bobby Max, +254 111 927170", style: const TextStyle(fontSize: 14),),
                          Text("Dandora, Nairobi 01000", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                        ],
                      ),
                    )
                    
                    // child: Container(
                    //   height: 50,
                    //   padding: const EdgeInsets.only(top: 20, bottom: 8, left: 4),
                    //   child: const Text("Please select delivery information"),
                    // ),
                  ),
                ),
                Positioned(
                  right: -4,
                    top: 0,
                    child: IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.edit, size: 18,)
                    )
                )
              ],
            ),
            const SizedBox(height: 16,),
            OutlineLabelCard(
                title: "Selected Products",
                child: Padding(
                  padding: const EdgeInsets.only(top: 18, bottom: 8),
                  child: Column(
                    children: items.map((product) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 75,
                            child: AspectRatio(
                              aspectRatio: 0.88,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(imageUrl: product.product.images.first),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(product.product.name, style: Theme.of(context).textTheme.labelLarge,),
                                  const SizedBox(height: 4,),
                                  Text("Kshs. ${product.priceTag.price.toStringAsFixed(2)}")
                                ],
                              )
                          )
                        ],
                      ),
                    )
                    ).toList(),
                  ),
                )
            ),
            const SizedBox(height: 16,),
            OutlineLabelCard(
                title: "Order Summary",
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total number of items"),
                          Text("x ")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total Price"),
                          Text("data")
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Charge"),
                          Text("Kshs. 1999")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total"),
                          Text("data")
                        ],
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: InputFormButton(
              onClick: (){},
              color: Colors.black87,
              titleText: "Confirm",
            ),
          )
      ),
    );
  }
}
