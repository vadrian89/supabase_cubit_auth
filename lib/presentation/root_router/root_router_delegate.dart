import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_cubit_auth/application/root_router/root_router_cubit.dart';
import 'package:supabase_cubit_auth/presentation/authentication/register/register_screen.dart';
import 'package:supabase_cubit_auth/presentation/authentication/sign_in/sign_in_screen.dart';
import 'package:supabase_cubit_auth/presentation/core/screens/main_screen.dart';
import 'package:supabase_cubit_auth/presentation/core/utils/app_exit_dialog.dart';
import 'package:supabase_cubit_auth/presentation/home/logged_in_screen.dart';

/// The root delegate of the app.
///
/// Used as value for [MaterialApp.router.routerDelegate].
/// This is the place where we set up what and how screens shown to the user.
///
/// Because I prefer to get rid of [addListener] and [removeListener] methods, I added [ChangeNotifier]
/// as mixin and call [notifyListeners] whenever [RootRouterCubit] emits a new state.
class RootRouterDelegate extends RouterDelegate<RootRouterState> with ChangeNotifier {
  final GlobalKey<NavigatorState> _navigatorKey;
  final RootRouterCubit _routerCubit;

  /// The value returned by the [Route] when [Navigator.onPopPage] is called.
  dynamic _popResult;

  RootRouterDelegate(GlobalKey<NavigatorState> navigatorKey, RootRouterCubit routerCubit)
      : _navigatorKey = navigatorKey,
        _routerCubit = routerCubit;

  /// The navigator's key.
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Called by the [Router] when it detects a route information may have changed as a result of rebuild.
  ///
  /// This is required for browser history navigation.
  @override
  RootRouterState get currentConfiguration => _routerCubit.state;

  @override
  Widget build(BuildContext context) => BlocListener<RootRouterCubit, RootRouterState>(
        listener: (context, state) => notifyListeners(),
        child: Navigator(
          key: navigatorKey,
          pages: List.from([
            _materialPage(valueKey: "mainScreen", child: const MainScreen()),
            ..._extraPages,
          ]),
          onPopPage: _onPopPageParser,
        ),
      );

  /// Set a new path based on the one reported by the system, by calling [RootRouterCubit.setNewRoutePath].
  ///
  /// This method is called by the [Router] when a new route has been requested by the underlying system.
  /// It’s recommended to return a [SynchronousFuture] to avoid waiting for microtasks.
  ///
  /// This happens right after the RouteInformation has been parsed by the [Router].
  /// For example: when a URL has been manually inserted, the URL get’s parsed, then this mehod is called.
  @override
  Future<void> setNewRoutePath(RootRouterState configuration) =>
      _routerCubit.setNewRoutePath(configuration);

  /// Parser for [Navigator.onPopPage] property, which calls [popRoute] to manage what happens when route was poped.
  /// If a pop ocurred `route.didPop(result) == true` then we pass the result value to the [_popResult] property
  /// to use when calling [RootRouterCubit.popRoute].
  bool _onPopPageParser(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) return false;
    _popResult = result;
    popRoute();
    return true;
  }

  /// Called by the [Router] when the [Router.backButtonDispatcher] reports that
  /// the operating system is requesting that the current route be popped.
  ///
  /// We call [RootRouterCubit.popRoute] to go one level lower based on the logic implemented in the method.
  /// If [RootRouterCubit.popRoute] returns `false` it means we are the root of the app and should ask the user if
  /// he wants to close the app.
  ///
  /// The confirmation dialog should return `false` to confirm and `true` to cancel.
  @override
  Future<bool> popRoute() {
    if (_routerCubit.popRoute(_popResult)) {
      return Future.value(true);
    }
    return _confirmAppExit();
  }

  /// List of extra pages 1 level above stack.
  ///
  /// Alternatively to have a cleaner delegate, the list of pages can be built in a separate class.
  List<Page> get _extraPages {
    final Page? page = _routerCubit.state.maybeWhen(
      orElse: () => null,
      register: () => _materialPage(
        valueKey: RootRouterState.registerPath,
        child: const RegisterScreen(),
      ),
      signIn: () => _materialPage(
        valueKey: RootRouterState.signInPath,
        child: const SignInScreen(),
      ),
      home: (user, showScreen) => showScreen!
          ? _materialPage(
              valueKey: RootRouterState.loggedInScreenPath,
              child: LoggedInScreen(user: user!),
            )
          : null,
    );

    return [if (page != null) page];
  }

  /// Ask the user to confirm he wants to exit the app.
  Future<bool> _confirmAppExit() => const AppExitDialog().show(_navigatorKey.currentContext!);

  /// Build a [Page] (screens) to use in [Navigator.pages] list.
  Page _materialPage({
    required String valueKey,
    required Widget child,
  }) =>
      MaterialPage(
        key: ValueKey<String>(valueKey),
        child: child,
      );
}
