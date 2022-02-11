import 'package:flutter/material.dart';

/// A custom [TextFormField] used in [SignInScreen] and [RegisterScreen].
class AuthFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final String? label;
  final bool obscureText;
  final String? Function(String? value)? validator;

  const AuthFormField({
    Key? key,
    this.controller,
    this.hint = "Insert text here",
    this.label,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            errorMaxLines: 3,
          ),
          obscureText: obscureText,
          validator: validator ??
              (value) => (value?.trim().isEmpty ?? true) ? "$label should not be empty" : null,
        ),
      );
}
