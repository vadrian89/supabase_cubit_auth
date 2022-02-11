import 'package:flutter/material.dart';

/// A custom [ElevatedButton] used inside [SignInScreen] and [RegisterScreen].
class AuthFormButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const AuthFormButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        child: Text(label),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.headline6),
          padding: MaterialStateProperty.all(const EdgeInsets.all(18)),
        ),
        onPressed: onPressed,
      );
}
