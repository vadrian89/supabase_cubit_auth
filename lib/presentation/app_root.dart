import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_cubit_auth/application/root_router/root_router_cubit.dart';

import 'root_router/root_router_delegate.dart';
import 'root_router/root_router_parser.dart';

/// The app's root widget.
///
/// Here we build [WidgetsApp]/[MaterialApp]/[CupertinoApp].
class AppRoot extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ).copyWith(secondary: Colors.yellow),
          scaffoldBackgroundColor: Colors.white,
        ),
        routerDelegate: RootRouterDelegate(
          navigatorKey,
          context.read<RootRouterCubit>(),
        ),
        routeInformationParser: const RootRouterParser(),
      );
}
