import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/presentation/views/main/other/other_view.dart';
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
          home: OtherView()
      );
    });
  }
}

