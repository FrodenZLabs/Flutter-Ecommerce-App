import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/delivery_info_card.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/delivery_info_form.dart';

class DeliveryInfo extends StatefulWidget {
  const DeliveryInfo({super.key});

  @override
  State<DeliveryInfo> createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Details"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(kEmptyDeliveryInfo),
          const Text("Delivery information are empty."),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
        ],
      ),

      // body: ListView.builder(
      //   itemCount: 5,
      //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //     itemBuilder: (context, index) => DeliveryInfoCard()
      // ),
      floatingActionButton: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: (){
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                    builder: (BuildContext context) {
                      return const DeliveryInfoForm();
                    }
                );
              },
              tooltip: "Increment",
              child: const Icon(Icons.add, color: Colors.white,),
            ),
          )
      ),
    );
  }
}
