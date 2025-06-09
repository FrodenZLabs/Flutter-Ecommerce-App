import 'package:flutter/material.dart';

class InputTextFormField extends StatefulWidget {
  final String? hint;
  final TextEditingController controller;
  final bool autocorrect;
  final bool isSecureField;
  final bool enable;
  final double hintTextSize;
  final EdgeInsets? contentPadding;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validation;

  const InputTextFormField({super.key, this.hint, required this.controller, this.autocorrect = false, this.isSecureField = false, this.enable = true, this.hintTextSize = 14, this.contentPadding, this.textInputAction, this.onFieldSubmitted, this.validation});

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isSecureField,
      enableSuggestions: !widget.isSecureField,
      autocorrect: widget.autocorrect,
      validator: widget.validation,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.enable,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: widget.hintTextSize
        ),
        contentPadding: widget.contentPadding,
        suffixIcon: widget.isSecureField ? IconButton(
            onPressed: (){
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.black87,
            ))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 0.0
          )
        )
      ),
    );
  }
}
