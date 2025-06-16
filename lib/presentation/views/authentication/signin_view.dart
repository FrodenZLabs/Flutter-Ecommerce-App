import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/core/constant/validators.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/router/app_router.dart';
import 'package:flutter_ecommerce_app/domain/usecases/user/sign_in_usecase.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/home/navbar_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_text_form_field.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSignIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<UserBloc>().add(
        SignInUser(SignInParams(
          username: emailController.text,
          password: passwordController.text,
        ))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        debugPrint('state: $state');
        EasyLoading.dismiss();
        if (state is UserLoading) {
          EasyLoading.show(status: 'Loading');
        }  else if (state is UserLogged) {
          context.read<NavbarCubit>().update(0);
          Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.home, ModalRoute.withName(''));
        }  else if (state is UserLoggedFail) {
          debugPrint("Login failed: ${state.failure}");
          if (state.failure is CredentialFailure) {
            EasyLoading.showError("Username/ Password Wrong!");
          }  else {
            EasyLoading.showError("Error");
          }
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
                      onFieldSubmitted: (_) => _onSignIn(context),
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
                      onClick: () => _onSignIn(context),
                      color: Colors.black87,
                      titleText: "Sign In",
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
                          "Don't have an account! ",
                          style: TextStyle(fontSize: 14),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRouter.signUp);
                          }, // Add logic
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
      ),
    );
  }
}
