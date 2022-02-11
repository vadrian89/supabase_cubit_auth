import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_cubit_auth/application/authentication/authentication_cubit.dart';
import 'package:supabase_cubit_auth/application/root_router/root_router_cubit.dart';
import 'package:supabase_cubit_auth/presentation/core/utils/snackbars.dart';

/// The authentication screen of the app.
///
/// Meant to act as a portal which contains the authentication information, buttons to use OAuth-based authentication,
/// and buttons to open sign in screens ([SignInScreen]) and register screens ([RegisterScreen]).
///
/// This screen is shown when the router's state is [RootRouterState.unauthenticated] and
/// when the Uri path contains [RootRouterState.authPath].
class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  Widget get _mediumVerticalSpace => const SizedBox(height: 25);

  @override
  Widget build(BuildContext context) => ScaffoldMessenger(
        child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) => state.maybeWhen(
            orElse: () => null,
            failure: (message) => showErrorSnackBar(context, message: message),
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: _body(context),
          ),
        ),
      );

  Widget _body(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome", style: Theme.of(context).textTheme.headline2),
            const SizedBox(height: 100),
            SignInButtonBuilder(
              onPressed: () => context.read<RootRouterCubit>().goToSignIn(),
              backgroundColor: Theme.of(context).primaryColor,
              text: "Sign in with E-mail",
              icon: Icons.email,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            ),
            _mediumVerticalSpace,
            SignInButtonBuilder(
              onPressed: () => context.read<RootRouterCubit>().goToRegister(),
              backgroundColor: Theme.of(context).primaryColorDark,
              text: "Register new account",
              icon: Icons.person_add,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            ),
          ],
        ),
      );
}
