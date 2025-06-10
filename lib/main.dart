import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/category/category.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/price_tag.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product.dart';
import 'package:flutter_ecommerce_app/presentation/product/product_details_view.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a dummy product
    final product = Product(
      id: '1',
      name: 'Sample Product',
      description: 'This is a sample product for testing.',
      priceTags: [
        PriceTag(id: 'pt1', name: 'Standard', price: 199.0),
        PriceTag(id: 'pt2', name: 'Discounted', price: 149.0),
      ],
      categories: [
        Category(id: 'c1', name: 'Electronics', image: 'assets/status_image/empty-cart.png'),
        Category(id: 'c2', name: 'Gadgets', image: 'assets/status_image/empty.png'),
      ],
      images: [
        'assets/status_image/empty.png',
        'assets/status_image/delivery-info.png',
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
          title: "Labs Shop",
          debugShowCheckedModeBanner: false,
          home: ProductDetailsView(product: product)
      );
    });
  }
}

