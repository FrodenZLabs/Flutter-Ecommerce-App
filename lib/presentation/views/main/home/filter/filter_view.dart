import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_range_slider.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
        actions: [
          IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.refresh)
          )
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
              itemCount: 10,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) => Row(
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                ],
              )
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Price Range",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          InputRangeSlider(initMax: 1000, initMin: 100)
        ],
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Builder(
                builder: (context){
                  return InputFormButton(
                    onClick: (){},
                    color: Colors.black87,
                    titleText: "Continue",
                  );
                }
            ),
          ),
      ),
    );
  }
}
