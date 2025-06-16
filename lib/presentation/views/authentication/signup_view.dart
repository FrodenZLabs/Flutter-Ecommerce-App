import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/core/constant/validators.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/router/app_router.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_up_usecase.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_text_form_field.dart';

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
  final _formKey = GlobalKey<FormState>();

  void _onSignUp(BuildContext context){
    if(_formKey.currentState!.validate()){
      if (passwordController.text != confirmPasswordController.text) {
        EasyLoading.showError("Passwords do not match");
        return;
      }
      context.read<UserBloc>().add(SignUpUser(SignUpParams(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text
      ))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is UserLoading) {
          EasyLoading.show(status: "Loading...");
        }  else if (state is UserLogged) {
          Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.home, (Route<dynamic> route) => false);
        } else if (state is UserLoggedFail) {
          String errorMessage = "An error occurred.Please try again.";
          if (state.failure is CredentialFailure) {
            errorMessage = "Incorrect email or password";
          }  else if (state.failure is NetworkFailure) {
            errorMessage = "Network error. Check your connection.";
          }
          EasyLoading.showError(errorMessage);
        }
      },
      child: Scaffold(
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
                      child: Image.asset(kAppLogo, color: Colors.black,),
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
                      onFieldSubmitted: (_) => _onSignUp(context),
                    ),
                    const SizedBox(height: 24),
                    InputFormButton(
                      onClick: () => _onSignUp(context),
                      color: Colors.black87,
                      titleText: "Register",
                    ),
                    const SizedBox(height: 10),
                    InputFormButton(
                      onClick: (){
                        Navigator.of(context).pop();
                      },
                      color: Colors.black87,
                      titleText: "Back",
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
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRouter.signIn);
                          }, // Add logic
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
      ),
    );
  }
}

