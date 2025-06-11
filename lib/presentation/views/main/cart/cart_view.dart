import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart/cart_item.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/cart_item_card.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_form_button.dart';

class CartView extends StatefulWidget {
  final List<CartItem> items;

  const CartView({super.key, required this.items});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // List<CartItem> selectedCartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      // child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Image.asset(kNoConnection),
                      //     const Center(child: Text("Cart is Empty"),),
                      //     SizedBox(height: MediaQuery.of(context).size.height * 0.1,)
                      //   ],
                      // ),

                      child: ListView.builder(
                        itemCount: widget.items.length,
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top + 20,
                              bottom: MediaQuery.of(context).padding.bottom + 200
                          ),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index){
                            return CartItemCard(cartItem: widget.items[index]);
                          }
                      ),
                  )
                )
              ],
            ),
            Positioned(
              bottom: (MediaQuery.of(context).padding.bottom + 90),
                top: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 4,left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total items",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "${widget.items.length}",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: InputFormButton(
                          onClick: (){},
                          color: Colors.black87,
                          cornerRadius: 36,
                          padding: EdgeInsets.zero,
                          titleText: "Checkout",
                        ),
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
