import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/core/constant/validators.dart';
import 'package:flutter_ecommerce_app/widgets/input_form_button.dart';
import 'package:flutter_ecommerce_app/widgets/input_text_form_field.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                    "Please enter your email address and password to sign-in",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 30),
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
                    textInputAction: TextInputAction.go,
                    hint: "Password",
                    isSecureField: true,
                    validation: (String? val) =>
                        Validators.validateField(val, "Password"),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {}, // Add logic
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  InputFormButton(
                    onClick: () {},
                    color: Colors.black87,
                    titleText: "Sign In",
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account! ",
                        style: TextStyle(fontSize: 14),
                      ),
                      InkWell(
                        onTap: () {}, // Add logic
                        child: const Text(
                          "Register",
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
}
