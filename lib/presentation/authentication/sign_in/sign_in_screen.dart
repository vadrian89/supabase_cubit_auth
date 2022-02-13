import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_cubit_auth/application/authentication/sign_in/sign_in_cubit.dart';
import 'package:supabase_cubit_auth/domain/authentication/authentication_repository.dart';
import 'package:supabase_cubit_auth/infrastructure/validators.dart';
import 'package:supabase_cubit_auth/presentation/core/utils/snackbars.dart';

import '../core/auth_form_button.dart';
import '../core/auth_form_field.dart';

/// The user sign in screen of the app where the user can sign in using e-mail & password.
///
/// This screen is shown when the router's state is [RootRouterState.signIn] and
/// when the Uri path contains [RootRouterState.signInPath].
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late final SignInCubit _bloc;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool get _formIsValid => _formKey.currentState?.validate() ?? false;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  @override
  void initState() {
    super.initState();
    _bloc = SignInCubit(authRepo: context.read<AuthenticationRepository>());
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaffoldMessenger(
        child: BlocConsumer<SignInCubit, SignInState>(
          bloc: _bloc,
          listener: (context, state) => state.maybeWhen(
            orElse: () => false,
            signingIn: () => showLoadingSnackBar(context, message: "Signing in $_email..."),
            failure: (message) => showErrorSnackBar(context, message: message),
          ),
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text("Sign in")),
            body: _body,
          ),
        ),
      );

  Widget get _body => Builder(
        builder: (context) => Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              children: [
                AuthFormField(
                  controller: _emailController,
                  hint: "Insert email",
                  label: "E-mail",
                  validator: (value) =>
                      Validators.isValidEmail(value) ? null : "E-mail is not valid",
                ),
                AuthFormField(
                  controller: _passwordController,
                  hint: "Set password",
                  label: "Password",
                  obscureText: true,
                  validator: (value) => Validators.isValidPassword(value)
                      ? null
                      : "Password should contain at least 1 lowercase, 1 uppercase, 1 digit, 1 special character and be at least 8 characters long.",
                ),
                const SizedBox(height: 20),
                AuthFormButton(
                  label: "Sign in",
                  onPressed: () {
                    if (!_formIsValid) {
                      showErrorSnackBar(context, message: "Form is not valid!");
                      return;
                    }
                    _bloc.signInWithEmail(email: _email, password: _password);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
