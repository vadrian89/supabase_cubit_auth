import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_cubit_auth/application/root_router/root_router_cubit.dart';

/// The [RouteInformationParser] implementation for our [MaterialApp.router]
///
/// It's main directives are to enable browser history, update the URL and restore the state based on inserted URL.
class RootRouterParser extends RouteInformationParser<RootRouterState> {
  const RootRouterParser();

  /// Parse the incoming [Uri] string and based on [Uri.pathSegments] length return the correct [RootRouterState].
  @override
  Future<RootRouterState> parseRouteInformation(RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location ?? "");
    RootRouterState state = const RootRouterState.initial();
    if (uri.pathSegments.isNotEmpty) {
      if (uri.pathSegments.length == 1) {
        state = RootRouterState.fromUriLevel1(uri);
      }
      if (uri.pathSegments.length == 2) {
        state = RootRouterState.fromUriLevel2(uri);
      }
      state = const RootRouterState.unknown();
    }
    return SynchronousFuture(state);
  }

  /// Restore the route information from the given configuration (or state, in our case).
  ///
  /// It's required to properly update the browser's history.
  @override
  RouteInformation restoreRouteInformation(RootRouterState configuration) =>
      RouteInformation(location: configuration.urlPath);
}
