import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/category/category.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/price_tag.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product.dart';
import 'package:flutter_ecommerce_app/presentation/main/category/category_view.dart';
import 'package:flutter_ecommerce_app/presentation/product/product_details_view.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
          title: "Labs Shop",
          debugShowCheckedModeBanner: false,
          home: CategoryView()
      );
    });
  }
}

