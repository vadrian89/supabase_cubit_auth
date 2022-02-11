part of 'register_cubit.dart';

@freezed

/// Class which represents the state of the register process.
///
/// We do not manage a success state because when the user registration is successful
/// [AuthenticationRepository.supabaseAuthSub] will receive a [AuthChangeEvent.signedIn] event which will
/// end up with the RootRouterCubit emitting a [RootRouterState.home] state.
class RegisterState with _$RegisterState {
  /// [RegisterState.initial] is the default state.
  ///
  /// Use this state to show the registering screen in it's basic state.
  const factory RegisterState.initial() = _Initial;

  /// Use [RegisterState.registering] to tell the user that the form has been sent.
  const factory RegisterState.registering() = _Registering;

  /// [SignInState.failure] should be used whenever an error occurs.
  ///
  /// Data validation errors, exceptions, etc.
  const factory RegisterState.failure(String message) = _Failure;
}
