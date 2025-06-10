import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/core/constant/validators.dart';
import 'package:flutter_ecommerce_app/widgets/input_form_button.dart';
import 'package:flutter_ecommerce_app/widgets/input_text_form_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 80,
                    child: Image.asset(kAppLogo),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Please enter your email address to create an account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 30),
                  InputTextFormField(
                    controller: firstNameController,
                    textInputAction: TextInputAction.next,
                    hint: "First Name",
                    validation: (String? val) =>
                        Validators.validateField(val, "First Name"),
                  ),
                  const SizedBox(height: 12),
                  InputTextFormField(
                    controller: lastNameController,
                    textInputAction: TextInputAction.next,
                    hint: "Last Name",
                    validation: (String? val) =>
                        Validators.validateField(val, "Last Name"),
                  ),
                  const SizedBox(height: 12),
                  InputTextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    hint: "Email Address",
                    validation: (String? val) =>
                        Validators.validateEmail(val),
                  ),
                  const SizedBox(height: 12),
                  InputTextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    hint: "Password",
                    isSecureField: true,
                    validation: (String? val) =>
                        Validators.validateField(val, "Password"),
                  ),
                  const SizedBox(height: 12),
                  InputTextFormField(
                    controller: confirmPasswordController,
                    textInputAction: TextInputAction.go,
                    hint: "Confirm Password",
                    isSecureField: true,
                    validation: (String? val) =>
                        Validators.validatePasswordMatch(val, passwordController.text),
                    // onFieldSubmitted: (_) => _onSignUp(context),
                  ),
                  const SizedBox(height: 24),
                  InputFormButton(
                    onClick: () => {},
                    color: Colors.black87,
                    titleText: "Register",
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account! ",
                        style: TextStyle(fontSize: 14),
                      ),
                      InkWell(
                        onTap: () {}, // Add logic
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _onSignUp(BuildContext context){
  //   if(_formKey.currentState!.validate()){
  //     return;
  //   }
  // }
}

