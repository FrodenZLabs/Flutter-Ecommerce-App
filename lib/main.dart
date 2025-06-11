import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart/cart_item.dart';
import 'package:flutter_ecommerce_app/domain/entities/category/category.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/price_tag.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product.dart';
import 'package:flutter_ecommerce_app/presentation/views/main/cart/cart_view.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Product sampleProduct = Product(
      id: '1',
      name: 'Bluetooth Headphones',
      description: 'High-quality over-ear headphones with noise cancellation.',
      priceTags: [
        PriceTag(id: 'price1', name: 'Standard', price: 3499.0),
      ],
      categories: [
        Category(id: 'cat1', name: 'Audio', image: ''),
      ],
      images: [
        'https://via.placeholder.com/150' // Replace with your asset or network image
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final List<CartItem> items = List.generate(5, (index) {
      return CartItem(
        id: 'item_$index',
        product: sampleProduct,
        priceTag: sampleProduct.priceTags.first,
      );
    });

    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
          title: "Labs Shop",
          debugShowCheckedModeBanner: false,
          home: CartView(items: items)
      );
    });
  }
}

