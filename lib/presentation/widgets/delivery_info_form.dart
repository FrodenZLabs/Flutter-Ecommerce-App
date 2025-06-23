import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/data/models/user/delivery_info_model.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/delivery-info.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/delivery_info/delivery_info_action/delivery_info_action_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_text_form_field.dart';

class DeliveryInfoForm extends StatefulWidget {
  final DeliveryInfo? deliveryInfo;

  const DeliveryInfoForm({super.key, this.deliveryInfo});

  @override
  State<DeliveryInfoForm> createState() => _DeliveryInfoFormState();
}

class _DeliveryInfoFormState extends State<DeliveryInfoForm> {
  String? id;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressLineOneController =
      TextEditingController();
  final TextEditingController _addressLineTwoController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.deliveryInfo != null) {
      id = widget.deliveryInfo!.id;
      _firstNameController.text = widget.deliveryInfo!.firstName;
      _lastNameController.text = widget.deliveryInfo!.lastName;
      _addressLineOneController.text = widget.deliveryInfo!.addressLineOne;
      _addressLineTwoController.text = widget.deliveryInfo!.addressLineTwo;
      _cityController.text = widget.deliveryInfo!.city;
      _zipCodeController.text = widget.deliveryInfo!.zipCode;
      _contactNumberController.text = widget.deliveryInfo!.contactNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryInfoActionCubit, DeliveryInfoActionState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is DeliveryInfoActionLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is DeliveryInfoAddActionSuccess) {
          Navigator.of(context).pop();
          context.read<DeliveryInfoFetchCubit>().addDeliveryInfo(
            state.deliveryInfo,
          );
          EasyLoading.showSuccess("Delivery info successfully added!");
        } else if (state is DeliveryInfoEditActionSuccess) {
          Navigator.of(context).pop();
          context.read<DeliveryInfoFetchCubit>().editDeliveryInfo(
            state.deliveryInfo,
          );
          EasyLoading.showSuccess("Delivery info successfully edited!");
        } else if (state is DeliveryInfoActionFail) {
          EasyLoading.showError("Error");
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  const SizedBox(height: 24),
                  InputTextFormField(
                    controller: _firstNameController,
                    hint: "First Name",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "This field can't be empty.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextFormField(
                    controller: _lastNameController,
                    hint: "Last Name",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "This field can't be empty.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextFormField(
                    controller: _addressLineOneController,
                    hint: "Address Line One",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "This field can't be empty.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextFormField(
                    controller: _addressLineTwoController,
                    hint: "Address Line Two",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "This field can't be empty.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextFormField(
                    controller: _cityController,
                    hint: "City",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "This field can't be empty.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextFormField(
                    controller: _zipCodeController,
                    hint: "Zip Code",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "This field can't be empty.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextFormField(
                    controller: _contactNumberController,
                    hint: "Contact Number",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    validation: (String? val) {
                      if (val == null || val.isEmpty) {
                        return "This field can't be empty.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  InputFormButton(
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.deliveryInfo == null) {
                          context
                              .read<DeliveryInfoActionCubit>()
                              .addDeliveryInfo(
                                DeliveryInfoModel(
                                  id: '',
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  addressLineOne:
                                      _addressLineOneController.text,
                                  addressLineTwo:
                                      _addressLineTwoController.text,
                                  city: _cityController.text,
                                  zipCode: _zipCodeController.text,
                                  contactNumber: _contactNumberController.text,
                                ),
                              );
                        } else {
                          context
                              .read<DeliveryInfoActionCubit>()
                              .editDeliveryInfo(
                                DeliveryInfoModel(
                                  id: id!,
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  addressLineOne:
                                      _addressLineOneController.text,
                                  addressLineTwo:
                                      _addressLineTwoController.text,
                                  city: _cityController.text,
                                  zipCode: _zipCodeController.text,
                                  contactNumber: _contactNumberController.text,
                                ),
                              );
                        }
                      }
                    },
                    color: Colors.black87,
                    titleText: widget.deliveryInfo == null ? "Save" : "Update",
                  ),
                  const SizedBox(height: 8),
                  InputFormButton(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.black87,
                    titleText: "Cancel",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
