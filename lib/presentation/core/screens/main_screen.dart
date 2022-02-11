import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_cubit_auth/application/root_router/root_router_cubit.dart';
import 'package:supabase_cubit_auth/presentation/authentication/authentication_screen.dart';
import 'package:supabase_cubit_auth/presentation/core/screens/home_screen.dart';
import 'package:supabase_cubit_auth/presentation/core/screens/loading_screen.dart';

import 'unkown_screen.dart';

/// This is the place where the content of the app is loaded based on [RootRouterState].
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  Widget get authScreen => const AuthenticationScreen();

  @override
  Widget build(BuildContext context) => BlocBuilder<RootRouterCubit, RootRouterState>(
        builder: (context, state) => state.maybeWhen(
          initial: () => const LoadingScreen(),
          unauthenticated: () => const AuthenticationScreen(),
          register: () => const AuthenticationScreen(),
          signIn: () => const AuthenticationScreen(),
          home: (user, _) => HomeScreen(user: user!),
          orElse: () => const UnkownScreen(),
        ),
      );
}
