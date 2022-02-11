import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_cubit_auth/application/authentication/authentication_cubit.dart';
import 'package:supabase_cubit_auth/application/root_router/root_router_cubit.dart';
import 'package:supabase_cubit_auth/domain/authentication/authentication_repository.dart';

/// Helper widget to have all global available blocs and repositories.
///
/// Should be used on top of our [MaterialApp]/[CupertinoApp]/[WidgetsApp] to be available
/// for all routes pushed on stack.
class BlocInitialiser extends StatelessWidget {
  final Widget child;

  const BlocInitialiser({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => _repoProviders(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationCubit(
                repo: context.read<AuthenticationRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => RootRouterCubit(
                authCubit: context.read<AuthenticationCubit>(),
              ),
            ),
          ],
          child: Builder(builder: (_) => child),
        ),
      );

  Widget _repoProviders({required Widget child}) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthenticationRepository(),
          )
        ],
        child: Builder(builder: (_) => child),
      );
}
