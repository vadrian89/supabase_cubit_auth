import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_cubit_auth/application/authentication/register/register_cubit.dart';
import 'package:supabase_cubit_auth/domain/authentication/authentication_repository.dart';
import 'package:supabase_cubit_auth/domain/user/user_model.dart';
import 'package:supabase_cubit_auth/infrastructure/validators.dart';
import 'package:supabase_cubit_auth/presentation/authentication/core/auth_form_button.dart';
import 'package:supabase_cubit_auth/presentation/core/utils/snackbars.dart';

import '../core/auth_form_field.dart';

/// The user registration screen of the app.
///
/// Used to offer the user a way to register a new account to enable e-mail + password sign in.
///
/// This screen is shown when the router's state is [RootRouterState.register] and
/// when the Uri path contains [RootRouterState.registerPath].
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final RegisterCubit _bloc;
  late final TextEditingController _passwordController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _emailController;

  bool get _formIsValid => _formKey.currentState?.validate() ?? false;

  String get _password => _passwordController.text;

  UserModel get _user => UserModel(
        lastName: _lastNameController.text,
        firstName: _firstNameController.text,
        email: _emailController.text,
        password: _password,
      );

  @override
  void initState() {
    super.initState();
    _bloc = RegisterCubit(authRepo: context.read<AuthenticationRepository>());
    _lastNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaffoldMessenger(
        child: BlocConsumer<RegisterCubit, RegisterState>(
          bloc: _bloc,
          listener: (context, state) => state.maybeWhen(
            orElse: () => false,
            registering: () => showLoadingSnackBar(
              context,
              message: "Registering ${_user.email}...",
            ),
            failure: (message) => showErrorSnackBar(context, message: message),
          ),
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text("Register")),
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
                  controller: _lastNameController,
                  hint: "Insert last name",
                  label: "Last name",
                ),
                AuthFormField(
                  controller: _firstNameController,
                  hint: "Insert first name",
                  label: "First name",
                ),
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
                AuthFormField(
                  hint: "Confirm password",
                  label: "Password confirmation",
                  obscureText: true,
                  validator: (value) => (_password.isNotEmpty && _password == value)
                      ? null
                      : "Password does not match",
                ),
                const SizedBox(height: 20),
                AuthFormButton(
                  label: "Register",
                  onPressed: () {
                    if (!_formIsValid) {
                      showErrorSnackBar(context, message: "Form is not valid!");
                      return;
                    }
                    _bloc.registerUser(_user);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
