part of 'sign_in_cubit.dart';

@freezed

/// Class which represents the state of the sign in process, using e-mail and password.
///
/// We do not manage a success state because when the sign in is successful
/// [AuthenticationRepository.supabaseAuthSub] will receive a [AuthChangeEvent.signedIn] event which will
/// end up with the RootRouterCubit emitting a [RootRouterState.home] state.
class SignInState with _$SignInState {
  /// [SignInState.initial] is the default state.
  ///
  /// Use this state to show the sign in form in it's basic state.
  const factory SignInState.initial() = _Initial;

  /// Use [SignInState.signingIn] to tell the user that the sign in data has been sent.
  const factory SignInState.signingIn() = _SigningIn;

  /// [SignInState.failure] should be used whenever an error occurs.
  ///
  /// Data validation errors, exceptions, etc.
  const factory SignInState.failure(String message) = _Failure;
}
