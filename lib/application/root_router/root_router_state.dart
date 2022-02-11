part of 'root_router_cubit.dart';

/// The root router's state.
///
/// Built using freezed package: https://pub.dev/packages/freezed.
/// I use freezed package to write less boilerplate and cleaner/readable state classes.
/// Some of the members could be put in a separated class, for a more cleaner state class.
/// For alternative way of writing state classes you can check my tutorial: https://medium.com/@verbanady/navigator-2-0-with-bloc-cubit-part-1-3dbad5a43054#7a23
@freezed
class RootRouterState with _$RootRouterState {
  /// The root path of the app.
  static const rootPath = "/";

  /// Home path returned, once the user is authenticated.
  static const homePath = "/home";

  /// Home path returned, once the user is authenticated.
  static const loggedInScreenPath = "/logged-in-screen";

  /// Path which means the user is not authenticated.
  static const authPath = "/auth";

  /// Path used for unverified users.
  static const unverifiedPath = "/unverified";

  /// Path used for sign with e-mail and password in screen.
  static const signInPath = "/sign-in";

  /// Path used for registration screen.
  static const registerPath = "/register";

  /// 404 - page not found state
  static const unknownPath = "/404";

  /// Getter to quickly check if the router is in unkown state.
  bool get isUknown => maybeWhen(orElse: () => false, unknown: () => true);

  /// Check if we the screen is root.
  /// [RootRouterState.unauthenticated] and [RootRouterState.home] show the root of the screen
  /// based on the current [AuthenticationState].
  bool get isRoot => maybeWhen(
        orElse: () => false,
        unauthenticated: () => true,
        home: (_, showScreen) => !(showScreen!),
      );

  /// Define the private constructor to enable support for class methods and properties.
  const RootRouterState._();

  /// [RootRouterState.initial] is the initial state of the app.
  ///
  /// This should be used to show the user a loading screen/widget, until the app verifies
  /// if the user is authenticated or not.
  const factory RootRouterState.initial() = _Initial;

  /// [RootRouterState.unauthenticated] shows the [AuthenticationScreen].
  ///
  /// We switch to it when the [AuthenticationState.unauthenticated] is emitted.
  const factory RootRouterState.unauthenticated() = _Unauthenticated;

  /// [RootRouterState.home] is the state of the router after the user is authenticated.
  const factory RootRouterState.home({UserModel? user, @Default(false) bool? showScreen}) = _Home;

  /// [RootRouterState.register] shows [RegisterScreen].
  const factory RootRouterState.register() = _Register;

  /// [RootRouterState.signIn] shows [SignInScreen].
  const factory RootRouterState.signIn() = _SignIn;

  /// [RootRouterState.unknown] is the state returned when the user requests an uknown page.
  ///
  /// This is the equivalent of error 404 for HTTP requests: https://en.wikipedia.org/wiki/HTTP_404.
  /// It shows [UnkownScreen].
  const factory RootRouterState.unknown() = _Unknown;

  /// Factory constructor used to get the correct state from an [Uri].
  ///
  /// This constructor is used inside [RootRouterParser.parseRouteInformation].
  factory RootRouterState.fromUriLevel1(Uri uri) {
    final pathSegment = "/${uri.pathSegments[0]}";
    if (pathSegment == homePath) {
      return const RootRouterState.home();
    } else if (pathSegment == authPath) {
      return const RootRouterState.unauthenticated();
    } else if (pathSegment == signInPath) {
      return const RootRouterState.signIn();
    } else if (pathSegment == registerPath) {
      return const RootRouterState.register();
    } else {
      return const RootRouterState.unknown();
    }
  }

  /// Factory constructor used to get the correct state from an [Uri] when [Uri.length] is 2.
  ///
  /// This constructor is used inside [RootRouterParser.parseRouteInformation].
  factory RootRouterState.fromUriLevel2(Uri uri) {
    final pathSegment1 = "/${uri.pathSegments[0]}";
    final pathSegment2 = "/${uri.pathSegments[1]}";
    if (pathSegment1 == homePath && pathSegment2 == loggedInScreenPath) {
      return const RootRouterState.home(showScreen: true);
    } else {
      return const RootRouterState.unknown();
    }
  }

  /// Get the corresponding url for each state
  String get urlPath => maybeWhen(
        initial: () => rootPath,
        unauthenticated: () => authPath,
        register: () => registerPath,
        signIn: () => signInPath,
        home: (_, showScreen) => "$homePath${showScreen! ? loggedInScreenPath : ""}",
        orElse: () => unknownPath,
      );
}
