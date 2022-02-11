import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_cubit_auth/domain/authentication/authentication_repository.dart';
import 'package:supabase_cubit_auth/infrastructure/global_utils.dart';

part 'sign_in_state.dart';
part 'sign_in_cubit.freezed.dart';

/// Cubit where we implement de logic for registering new users.
///
/// Used inside [SignInScreen] class.
class SignInCubit extends Cubit<SignInState> {
  final AuthenticationRepository _repo;

  SignInCubit({required AuthenticationRepository authRepo})
      : _repo = authRepo,
        super(const SignInState.initial());

  /// Public method used to sign in the user, using an e-mail and password.
  Future<void> signInWithEmail({required String email, required String password}) async {
    emit(const SignInState.signingIn());
    await responseDelay();
    final result = await _repo.signInUser(email: email, password: password);
    result.when(
      failure: (message) {
        emit(SignInState.failure(message));
        emit(const SignInState.initial());
      },
      success: (_) => null,
    );
  }
}
