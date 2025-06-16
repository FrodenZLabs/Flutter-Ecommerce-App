import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/domain/entities/user/user.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_text_form_field.dart';

class UserProfileView extends StatefulWidget {
  final User user;

  const UserProfileView({super.key, required this.user});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _emailController.text = widget.user.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: ListView(
          children: [
            Hero(
                tag: "C001",
                child: CircleAvatar(
                  radius: 75.0,
                  backgroundColor: Colors.grey.shade200,
                  child: Image.asset(kUserAvatar),
                )
            ),
            const SizedBox(height: 50,),
            InputTextFormField(
              controller: _firstNameController,
              hint: "First Name",
            ),
            const SizedBox(height: 12,),
            InputTextFormField(
              controller: _lastNameController,
              hint: "Last Name",
            ),
            const SizedBox(height: 12,),
            InputTextFormField(
              controller: _emailController,
              enable: false,
              hint: "Email Address",
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: InputFormButton(
              onClick: (){},
              titleText: "Update",
              color: Colors.black87,
            ),
          )
      ),
    );
  }
}
