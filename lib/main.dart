import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart/cart_item.dart';
import 'package:flutter_ecommerce_app/domain/entities/category/category.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/price_tag.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product.dart';
import 'package:flutter_ecommerce_app/presentation/views/order_checkout/order_checkout_view.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy product and price tag setup
    final Product sampleProduct = Product(
      id: '1',
      name: 'Sample Laptop',
      description: 'A powerful laptop for professionals and students.',
      priceTags: [
        PriceTag(id: 'pt1', name: 'Standard', price: 1000.0),
        PriceTag(id: 'pt2', name: 'Student Discount', price: 850.0),
      ],
      categories: [
        Category(id: 'c1', name: 'Electronics', image: 'assets/status_image/empty.png'),
      ],
      images: [
        'assets/status_image/empty.png',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

// Dummy cart items
    final List<CartItem> items = [
      CartItem(
        id: 'ci1',
        product: sampleProduct,
        priceTag: sampleProduct.priceTags[0], // Standard price
      ),
      CartItem(
        id: 'ci2',
        product: sampleProduct,
        priceTag: sampleProduct.priceTags[1], // Discounted price
      ),
    ];

    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
          title: "Labs Shop",
          debugShowCheckedModeBanner: false,
          home: OrderCheckoutView(items: items)
      );
    });
  }
}

