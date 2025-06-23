import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/delivery_info/delivery_info_action/delivery_info_action_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/delivery_info_card.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/delivery_info_form.dart';

class DeliveryInfoView extends StatefulWidget {
  const DeliveryInfoView({super.key});

  @override
  State<DeliveryInfoView> createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfoView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryInfoActionCubit, DeliveryInfoActionState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is DeliveryInfoActionLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is DeliveryInfoSelectActionSuccess) {
          context.read<DeliveryInfoFetchCubit>().selectDeliveryInfo(
            state.deliveryInfo,
          );
        } else if (state is DeliveryInfoActionFail) {
          EasyLoading.showError("Error");
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Delivery Details")),
        body: BlocBuilder<DeliveryInfoFetchCubit, DeliveryInfoFetchState>(
          builder: (context, state) {
            if (state is! DeliveryInfoFetchLoading &&
                state.deliveryInformation.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(kEmptyDeliveryInfo),
                  const Text("Delivery information is empty."),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ],
              );
            }
            return ListView.builder(
              itemCount:
                  (state is DeliveryInfoFetchLoading &&
                      state.deliveryInformation.isEmpty)
                  ? 5
                  : state.deliveryInformation.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) =>
                  (state is DeliveryInfoFetchLoading &&
                      state.deliveryInformation.isEmpty)
                  ? const DeliveryInfoCard()
                  : DeliveryInfoCard(
                      deliveryInformation: state.deliveryInformation[index],
                      isSelected:
                          state.deliveryInformation[index] ==
                          state.selectedDeliveryInformation,
                    ),
            );
          },
        ),
        floatingActionButton: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  builder: (BuildContext context) {
                    return const DeliveryInfoForm();
                  },
                );
              },
              tooltip: "Increment",
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
